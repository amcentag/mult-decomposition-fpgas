`timescale 1ns / 1ps

module Comba(
    input wire clk,
    input wire [63:0] a,
    input wire [63:0] b,
    output wire [127:0] productC
    ); 
    
    reg [15:0] a0, a1, a2, a3;
    reg [15:0] b0, b1, b2, b3;

    reg  [127:0] c;
    
    reg  [31:0] partialProd[15:0];

    always @(posedge clk) begin
        a0 <= a[15:0];
        a1 <= a[31:16];
        a2 <= a[47:32];
        a3 <= a[63:48];

        b0 <= b[15:0];
        b1 <= b[31:16];
        b2 <= b[47:32];
        b3 <= b[63:48];
    end
    
    always @(posedge clk) begin    
        partialProd[0] = b3 * a3; 
               
        partialProd[1] = b3 * a2;        
        partialProd[2] = b2 * a3; 
               
        partialProd[3] = b3 * a1;        
        partialProd[4] = b2 * a2;        
        partialProd[5] = b1 * a3;
                
        partialProd[6] = b3 * a0;        
        partialProd[7] = b2 * a1;        
        partialProd[8] = b1 * a2;        
        partialProd[9]= b0 * a3; 
               
        partialProd[10] = b2 * a0;        
        partialProd[11] = b1 * a1;        
        partialProd[12] = b0 * a2; 
               
        partialProd[13] = b1 * a0;        
        partialProd[14] = b0 * a1;     
           
        partialProd[15] = b0 * a0;

        c = (partialProd[0]) 
            + ((partialProd[1] + partialProd[2]) << 16) 
            + ((partialProd[3] + partialProd[4] + partialProd[5]) << 32) 
            + ((partialProd[6] + partialProd[7] + partialProd[8] + partialProd[9]) << 48) 
            + ((partialProd[10] + partialProd[11] + partialProd[12]) << 64)
            + ((partialProd[13] + partialProd[14]) << 80)
            + ((partialProd[15]) << 96);
    end
           
        assign productC = c;
endmodule
