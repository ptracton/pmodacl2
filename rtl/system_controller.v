//                              -*- Mode: Verilog -*-
// Filename        : system_controller.v
// Description     : Prototype System Controller for SPI FPGA
// Author          : Philip Tracton
// Created On      : Fri Jul  8 20:54:44 2016
// Last Modified By: Philip Tracton
// Last Modified On: Fri Jul  8 20:54:44 2016
// Update Count    : 0
// Status          : Unknown, Use with caution!

module system_controller (/*AUTOARG*/
   // Outputs
   clk, rst, sclk_o,
   // Inputs
   clk_i, rst_i, clk_enable
   ) ;
   input wire clk_i;
   input wire rst_i;
   input wire clk_enable;

   output wire clk;
   output wire rst;
   output wire sclk_o;


   //
   // Input buffer the clk pin
   //
   wire        clk_ibuf;
   IBUF xclk_ibufg(.I(clk_i), .O(clk_ibuf));
endmodule // system_controller
