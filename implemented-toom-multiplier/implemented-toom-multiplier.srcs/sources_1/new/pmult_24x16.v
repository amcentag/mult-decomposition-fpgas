`timescale 1ns / 1ps

// for 24-bit input {a1[8],a0[16]) and 16-bit input b, returns the partial products
// a1*b and a0*b
// a1*b multiplication done in slice logic, potential to improve?
// costs: 1 DSP, 153 LUTs

module pmult_24x16(
input wire clk,
input wire [23:0] a,
input wire [15:0] b,
output wire [31:0] r1,
output wire [23:0] r2
);

(*use_dsp = "yes"*) mult_16x16 m1(clk,a[15:0],b,r1);
(*use_dsp = "yes"*) lmult_8x16 m2(clk,a[23:16],b,r2);

endmodule
