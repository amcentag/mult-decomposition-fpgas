`timescale 1ns / 1ps


module lmult_8x16(
input wire clk,
input wire [7:0] a,
input wire [15:0] b,
output wire [23:0] r
);

reg [7:0] ra;
reg [15:0] rb;
reg [15:0] p1, p2, p3, p4, p5, p6, p7, p0;
reg [23:0] m;

always @(posedge clk)
begin
/*
ra <= a;
rb <= b;
p0 <= ra[0]*rb;
p1 <= ra[1]*rb;
p2 <= ra[2]*rb;
p3 <= ra[3]*rb;
p4 <= ra[4]*rb;
p5 <= ra[5]*rb;
p6 <= ra[6]*rb;
p7 <= ra[7]*rb;
m <= p0 + {p1,1'b0} + {p2,2'b0} + {p3,3'b0} + {p4,4'b0} + {p5,5'b0} + {p6,6'b0} + {p7,7'b0};
*/
ra <= a;
rb <= b;
m <= ra*rb;
end

assign r = m;

endmodule