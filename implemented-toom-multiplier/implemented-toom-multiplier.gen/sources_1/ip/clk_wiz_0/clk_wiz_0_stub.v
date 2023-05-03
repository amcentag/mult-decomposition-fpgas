// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Wed Apr 26 11:33:52 2023
// Host        : DESKTOP-HOE36TI running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {c:/Users/amcen/Documents/capstone project vivado
//               files/implemented-toom-multiplier/implemented-toom-multiplier.gen/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.v}
// Design      : clk_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku5p-ffvb676-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_0(clk_100mhz, clk_250mhz, reset, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_100mhz,clk_250mhz,reset,locked,clk_in1" */;
  output clk_100mhz;
  output clk_250mhz;
  input reset;
  output locked;
  input clk_in1;
endmodule
