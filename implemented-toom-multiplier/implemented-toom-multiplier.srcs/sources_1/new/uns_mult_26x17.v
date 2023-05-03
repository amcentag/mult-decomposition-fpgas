`timescale 1ns / 1ps

module uns_mult_26x17(
input wire clk,
input wire [25:0] a,
input wire [16:0] b,
output wire [42:0] r
);

reg [25:0] ra;
reg [16:0] rb;
reg [42:0] m;

always @(posedge clk)
begin
ra <= a;
rb <= b;
m <= ra*rb;
end

assign r = m;

endmodule
