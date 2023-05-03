`timescale 1ns / 1ps


module mult_64x64(
input wire clk,
input wire [63:0] a,
input wire [63:0] b,
output wire [127:0] r
);

wire [95:0] p1,p2;
reg [127:0] m;

toommult_64x32 m1(clk,a,b[31:0],p1);
toommult_64x32 m2(clk,a,b[63:32],p2);

always @(posedge clk) begin
m <= p1 + {p2,32'b0};
end

assign r = m;

endmodule
