`timescale 1ns / 1ps

module s_mult_26x17(
input wire clk,
input wire signed [25:0] a,
input wire signed [16:0] b,
output wire signed [42:0] r
);

reg signed [25:0] ra;
reg signed [16:0] rb;
reg signed [42:0] m;

always @(posedge clk)
begin
ra <= a;
rb <= b;
m <= ra*rb;
end

assign r = m;

endmodule
