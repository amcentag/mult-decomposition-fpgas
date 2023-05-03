`timescale 1ns / 1ps

module mult_18x18(
input wire clk,
input wire [17:0] a,
input wire [17:0] b,
output wire [35:0] r
    );
    
reg [17:0] ra,rb;
reg [35:0] m;

always @(posedge clk) begin
ra <= a;
rb <= b;
m <= ra*rb;
end

assign r = m;
endmodule
