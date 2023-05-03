`timescale 1ns / 1ps


module mult_17x17(
input wire clk,
input wire [16:0] a,
input wire [16:0] b,
output wire [33:0] r
    );
    
reg [16:0] ra,rb;
reg [33:0] m;

always @(posedge clk) begin
ra <= a;
rb <= b;
m <= ra*rb;
end

assign r = m;
endmodule