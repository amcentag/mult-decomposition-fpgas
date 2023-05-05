`timescale 1ns / 1ps

module Comba_1(
    input wire clk,
    input wire [63:0] a,
    input wire [63:0] b,
    output wire [127:0] productC
    ); 
    
    reg [23:0] a0, a1, a2;
    reg [15:0] b0, b1, b2, b3;
    reg [127:0] c;
    
    reg [39:0] partialProd[11:0];

    always @(posedge clk) begin
        a0 = a[23:0];
        a1 = a[47:24];
        a2 = a[63:48];

        b0 = b[15:0];
        b1 = b[31:16];
        b2 = b[47:32];
        b3 = b[63:48];
    end
    
    always @(posedge clk) begin    
        partialProd[0] = b3 * a2; 
               
        partialProd[1] = b3 * a1;        
        partialProd[2] = b2 * a2; 
               
        partialProd[3] = b3 * a0;        
        partialProd[4] = b2 * a1;        
        partialProd[5] = b1 * a2;
                
        partialProd[6] = b2 * a0;        
        partialProd[7] = b1 * a1;        
        partialProd[8] = b0 * a2;        
        
        partialProd[9] = b1 * a0;        
        partialProd[10] = b0 * a1;   
             
        partialProd[11] = b0 * a0;  
        
        c = (partialProd[11]) 
            + (partialProd[9] << 16) 
            + (partialProd[10] << 24)
            + (partialProd[6] << 32) 
            + (partialProd[7] << 40)
            + ((partialProd[3] + partialProd[8]) << 48)
            + (partialProd[4] << 56)
            + (partialProd[5] << 64)
            + (partialProd[1] << 72)
            + (partialProd[2] << 80)
            + (partialProd[0] << 96);             
    end
           
    assign productC = c;
endmodule

