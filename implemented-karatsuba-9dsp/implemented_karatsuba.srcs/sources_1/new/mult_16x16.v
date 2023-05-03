`timescale 1ns / 1ps


module mult_16x16(
input wire clk,
input wire [15:0] a,
input wire [15:0] b,
output wire [31:0] r
    );
    
reg [15:0] ra,rb;
reg [31:0] m;

always @(posedge clk) begin
ra <= a;
rb <= b;
m <= ra*rb;
end

assign r = m;
endmodule
