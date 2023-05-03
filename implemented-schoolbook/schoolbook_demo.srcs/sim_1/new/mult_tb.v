`timescale 1ns / 1ps

module mult_tb();
reg clk;
reg [63:0] a,b;
wire [127:0] r;
reg [127:0] diff;

initial begin
clk <= 0;
forever begin
#1.042 clk <= ~clk;
end
end

mult_demo test(clk,a,b,r);

always @(posedge clk) begin
a <= 64'hffff_ffff_ffff_ffff;
b <= 64'hffff_ffff_ffff_ffff;
diff <= r-a*b;
end

endmodule