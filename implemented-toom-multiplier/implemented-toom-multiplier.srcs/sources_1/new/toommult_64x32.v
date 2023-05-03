`timescale 1ns / 1ps

// DONE 4/12: check implementation with pmults using 2 DSPs and make sure LUT cost goes down by 153*2
// 4/12: before implementing improvements, doing pmult with 2 DSPs led to 12 DSP, 752 LUT cost.
//       implying that pmult LUT cost was about 153 (orig cost 1362-4*153=750)

module toommult_64x32 (
input wire clk,
input wire [63:0] a,
input wire [31:0] b,
output wire [95:0] r
);

reg [15:0] s2,s8;
reg [16:0] s4;
reg signed [16:0] s6;
reg [23:0] s1,s7;
reg [25:0] s3;
reg signed [25:0] s5;
// do all pre-processing here
always @(posedge clk)
begin
s1 <= {a[63:56],a[15:0]};
s2 <= b[15:0];
s3 <= a[15:0]+a[39:16]+{a[55:40],8'b0};
s4 <= b[15:0]+b[31:16];
//s5 <= {10'b0,a[15:0]}-{2'b0,a[39:16]}+{2'b0,a[55:40],8'b0}; // 26-bit two's complement
s5 <= s3-{1'b0,a[39:16],1'b0};
s6 <= {1'b0,b[15:0]}-{1'b0,b[31:16]}; // 17-bit two's complement
s7 <= {a[63:56],a[55:40]};
s8 <= b[31:16];
end

// multiplication stage
wire [23:0] p1,p6;
wire [31:0] p2,p5;
wire [42:0] p3;
wire signed [41:0] p4;
pmult_24x16 m1(clk,s1,s2,p2,p1); // partial product mults require 1 DSP, a lot of LUTs
uns_mult_26x17 m2(clk,s3,s4,p3);
s_mult_26x17 m3(clk,s5,s6,p4);
pmult_24x16 m4(clk,s7,s8,p5,p6);

reg signed [44:0] c3,c4,p7,p8;
reg [42:0] p9,p10,p11,p12;
// do all post-processing here
always @(posedge clk)
begin
c3 <= {2'b0,p3};
c4 <= {p4[41],p4[41],p4[41],p4};
p7 <= c3+c4;
p8 <= c3-c4;
p9 <= p7[43:1];
p10 <= p8[43:1];
p11 <= p9-p2;
p12 <= p10-{p5,8'b0};
end

assign r = p2+{p12,16'b0}+{p11,32'b0}+{p5,56'b0}+{p1,56'b0}+{p6,72'b0};

endmodule