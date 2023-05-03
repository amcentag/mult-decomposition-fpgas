`timescale 1ns / 1ps

module partialmult_demo(
input wire clk,
input wire [7:0] a2,
input wire [15:0] a1,
input wire [15:0] b,
output wire [23:0] r2,
output wire [31:0] r1
);
   
reg [7:0] Ra2;
reg [15:0] Ra1, Rb;
reg [23:0] m2 [3:0];
reg [31:0] m1 [3:0];
integer i;

always @(posedge clk)
begin
Ra2 <= a2;
Ra1 <= a1;
Rb <= b;
m1[0] <= Ra1 * Rb;
m2[0] <= Ra2 * Rb;
for (i = 0; i < 3; i=i+1)
    begin
    m1[i+1] <= m1[i];
    m2[i+1] <= m2[i];
    end
end
assign r1 = m1[3];
assign r2 = m2[3];

endmodule
