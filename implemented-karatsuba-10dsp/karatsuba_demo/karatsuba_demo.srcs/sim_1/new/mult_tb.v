`timescale 1ns / 1ps

module mult_tb();
reg clk;
reg [63:0] a,b;
wire [127:0] r;
reg [127:0] diff;

initial begin
clk <= 0;
forever begin
#1.923 clk <= ~clk;
end
end

mult_demo test(clk,a,b,r);

always @(posedge clk) begin
a <= 64'hb12c50b340c52f26;
b <= 64'hab5ccdea6f797240;
diff <= r-a*b;
end

endmodule