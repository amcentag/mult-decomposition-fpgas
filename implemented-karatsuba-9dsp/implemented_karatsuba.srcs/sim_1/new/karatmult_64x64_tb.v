`timescale 1ns / 1ps

module karatmult_64x64_tb();
    reg clk;
    reg [63:0] a;
    reg [63:0] b;
    wire [127:0] r;
    reg [127:0] diff,exp;
    
    initial begin
    clk <= 0;
    forever begin
    #0.781 clk <= ~clk;
    end
    end
    
    karatmult_64x64 test(clk,a,b,r);
    
    always @(posedge clk) begin
    a = 64'hed02_1eb1_6be3_0622;
    b = 64'he16f_78ed_4e4e_abcd;
    
    exp <= a*b;
    diff <= r - exp;
    end
    
    
endmodule
