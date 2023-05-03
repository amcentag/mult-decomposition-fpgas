`timescale 1ns / 1ps


module karatmult_64x64(
input wire clk,
input wire [63:0] a,
input wire [63:0] b,
output wire [127:0] r
);

reg [16:0] s1,s2,s3,s4;
reg [17:0] s7,s8;
reg [32:0] s5,s6;
// do all pre-processing here
always @(posedge clk) begin
s1 <= a[63:48] + a[47:32];
s2 <= b[63:48] + b[47:32];
s3 <= a[31:16] + a[15:0];
s4 <= b[31:16] + b[15:0];
s5 <= a[63:32] + a[31:0];
s6 <= b[63:32] + b[31:0];
s7 <= s5[32:17] + s5[16:0];
s8 <= s6[32:17] + s6[16:0];
end

wire [31:0] p1,p2,p4,p5,p7;
wire [33:0] p3,p6,p8;
wire [35:0] p9;
mult_16x16 m1(clk,a[63:48],b[63:48],p1);
mult_16x16 m2(clk,a[47:32],b[47:32],p2);
mult_17x17 m3(clk,s1,s2,p3);
mult_16x16 m4(clk,a[31:16],b[31:16],p4);
mult_16x16 m5(clk,a[15:0],b[15:0],p5);
mult_17x17 m6(clk,s3,s4,p6);
mult_16x16 m7(clk,s5[32:17],s6[32:17],p7);
mult_17x17 m8(clk,s5[16:0],s6[16:0],p8);
mult_18x18 m9(clk,s7,s8,p9);

reg [31:0] rp1,rp2,rp4,rp5,rp7;
reg [33:0] rp3,rp6,rp8;
reg [35:0] rp9;
always @(posedge clk) begin
rp1 <= p1;
rp2 <= p2;
rp3 <= p3;
rp4 <= p4;
rp5 <= p5;
rp6 <= p6;
rp7 <= p7;
rp8 <= p8;
rp9 <= p9;
end

reg [33:0] p10b,p10,p12;
reg [35:0] p14;
reg [63:0] p11,p13;
reg [65:0] p15,p16;
// do all post-processing here
always @(posedge clk) begin
p10 <= rp3-rp2-rp1;
p11 <= {p1,32'b0}+p2+{p10,16'b0};
p12 <= rp6-rp5-rp4;
p13 <= {p4,32'b0}+p5+{p12,16'b0};
p14 <= rp9-rp8-rp7;
p15 <= {p7,34'b0}+p8+{p14,17'b0};
p16 <= p15-p13-p11;
end

assign r = {p11,64'b0}+p13+{p16,32'b0};

endmodule


/*
module test(
input wire clk,
input wire [17:0] a,
input wire [17:0] b,
output wire [33:0] r
);

mult_18x18(clk,a,b,r);

endmodule
*/
