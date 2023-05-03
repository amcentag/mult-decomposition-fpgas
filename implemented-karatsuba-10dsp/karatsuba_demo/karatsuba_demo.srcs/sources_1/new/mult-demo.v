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

reg [15:0] A0, A1, A2, A3, B0, B1, B2, B3;
reg [16:0] SA01, SB01, SA02, SB02, SA12, SB12, SA03, SB03, SA13, SB13, SA23, SB23;
// do all pre-processing here
// question: should we use reg or wire data type for the intermediate values?
//           if we need to pipeline the input/output, then would it be better to use reg inside always block?
always @(posedge clk)
begin
A0 <= A[15:0];
A1 <= A[31:16];
A2 <= A[47:32];
A3 <= A[63:48];
B0 <= B[15:0];
B1 <= B[31:16];
B2 <= B[47:32];
B3 <= B[63:48];
SA01 <= A0 + A1;
SB01 <= B0 + B1;
SA02 <= A0 + A2;
SB02 <= B0 + B2;
SA12 <= A1 + A2;
SB12 <= B1 + B2;
SA03 <= A0 + A3;
SB03 <= B0 + B3;
SA13 <= A1 + A3;
SB13 <= B1 + B3;
SA23 <= A2 + A3;
SB23 <= B2 + B3;
end

wire [40:0] P0, P1, P2, P3, P01, P02, P12, P03, P13, P23;  // intermediate products
mult_unsigned m0(clk, {8'b0,A0}, {1'b0,B0}, P0);
mult_unsigned m1(clk, {8'b0,A1}, {1'b0,B1}, P1);
mult_unsigned m2(clk, {8'b0,A2}, {1'b0,B2}, P2);
mult_unsigned m3(clk, {8'b0,A3}, {1'b0,B3}, P3);
mult_unsigned m4(clk, {7'b0,SA01}, SB01, P01);
mult_unsigned m5(clk, {7'b0,SA02}, SB02, P02);
mult_unsigned m6(clk, {7'b0,SA12}, SB12, P12);
mult_unsigned m7(clk, {7'b0,SA03}, SB03, P03);
mult_unsigned m8(clk, {7'b0,SA13}, SB13, P13);
mult_unsigned m9(clk, {7'b0,SA23}, SB23, P23);

reg [wA+wB-1:0] rR;
reg [31:0] R0, R1, R2, R3;
reg [33:0] R01, R02, R12, R03, R13, R23;
// do all post-processing here
always @(posedge clk)
begin
R0 <= P0;
R1 <= P1;
R2 <= P2;
R3 <= P3;
R01 <= P01;
R02 <= P02;
R12 <= P12;
R03 <= P03;
R13 <= P13;
R23 <= P23;

rR <= R0+
{R01 -R0-R1, 16'b0}+
{R1+R02 -R0-R2,32'b0}+
{R12+R03 -R1-R2-R0-R3, 48'b0}+
{R2+R13 -R1-R3,64'b0}+
{R23 -R2-R3, 80'b0}+
{R3,96'b0};
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
