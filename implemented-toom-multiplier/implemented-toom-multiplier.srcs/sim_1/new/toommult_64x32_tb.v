`timescale 1ns / 1ps

module toommult_64x64_tb();
    reg clk;
    reg [63:0] a;
    reg [63:0] b;
    wire [127:0] r;
    reg [127:0] m,diff,exp;
    
    
    initial begin
    clk <= 0;
    forever begin
    #1.137 clk <= ~clk;
    end
    end
    
    
    mult_64x64 test(clk,a,b,r);
    
    always @(posedge clk) begin
    a = 64'h0000_0011_1111_0000;
    b = 64'he16f_78ed_4d66_fa30;
    
    exp <= a*b;
    m <= r;
    diff <= m - exp;
    end
    
    
endmodule