`timescale 1ns / 1ps

// demo multiplier, just splitting a big multiply into two parts
// question 1: lots of warnings with synthesis and implementation, but do we only care about the DSP and LUT usage?
// question 2: will i/o resources become a problem for bigger operands/outputs?
// question 3: how to connect clock? vivado seems to assign random i/o pins



module mult_demo #(
wA = 64, // A width
wB = 64 // B width
)(
input wire clk,
input wire [wA-1:0] A,
input wire [wB-1:0] B,
output wire [wA+wB-1:0] R
);

reg [23:0] A1, A2;
reg [15:0] A3, B1, B2, B3, B4;
// do all pre-processing here
// question: should we use reg or wire data type for the intermediate values?
//           if we need to pipeline the input/output, then would it be better to use reg inside always block?
always @(posedge clk)
begin
A1 <= A[23:0];
A2 <= A[47:24];
A3 <= A[63:48];
B1 <= B[15:0];
B2 <= B[31:16];
B3 <= B[47:32];
B4 <= B[63:48];
end

wire [39:0] P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12;  // intermediate products
mult_unsigned m1(clk, A1, B1, P1);
mult_unsigned m2(clk, A1, B2, P2);
mult_unsigned m3(clk, A1, B3, P3);
mult_unsigned m4(clk, A1, B4, P4);
mult_unsigned m5(clk, A2, B1, P5);
mult_unsigned m6(clk, A2, B2, P6);
mult_unsigned m7(clk, A2, B3, P7);
mult_unsigned m8(clk, A2, B4, P8);
mult_unsigned m9(clk, {8'b0,A3}, B1, P9);
mult_unsigned m10(clk, {8'b0,A3}, B2, P10);
mult_unsigned m11(clk, {8'b0,A3}, B3, P11);
mult_unsigned m12(clk, {8'b0,A3}, B4, P12);

reg [wA+wB-1:0] rR;
// do all post-processing here
always @(posedge clk)
begin
rR <= P1+{P2,16'b0}+{P3,32'b0}+{P4,48'b0}+
{P5,24'b0}+{P6,40'b0}+{P7,56'b0}+{P8,72'b0}+
{P9,48'b0}+{P10,64'b0}+{P11,80'b0}+{P12,96'b0}; // sum the two products and shift P2 by 24 bits
end
assign R = rR;

endmodule


/* testing multiplier that gives both partial products
module mult_demo (
input wire clk,
input wire [23:0] a,
input wire [15:0] b,
output wire [55:0] r
);

partialmult_demo m1(clk, a[23:16], a[15:0], b[15:0], r[55:32], r[31:0]);
endmodule
*/
