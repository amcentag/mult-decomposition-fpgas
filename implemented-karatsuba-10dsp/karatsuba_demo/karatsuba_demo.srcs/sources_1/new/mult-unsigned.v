`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2023 05:38:23 PM
// Design Name: 
// Module Name: mult-unsigned
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mult_unsigned (clk, A, B, RES);
parameter WIDTHA = 24; // up to 26 for ultrascale+
parameter WIDTHB = 17; // up to 17 for ultrascale+
input wire clk;
input wire [WIDTHA-1:0] A;
input wire [WIDTHB-1:0] B;
output wire [WIDTHA+WIDTHB-1:0] RES;
reg [WIDTHA-1:0] rA;
reg [WIDTHB-1:0] rB;
reg [WIDTHA+WIDTHB-1:0] M [3:0];
integer i;
always @(posedge clk)
begin
rA <= A;
rB <= B;
M[0] <= rA * rB;
for (i = 0; i < 3; i = i+1)
M[i+1] <= M[i];
end
assign RES = M[3];


endmodule
