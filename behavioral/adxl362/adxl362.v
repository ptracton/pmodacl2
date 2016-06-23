//                              -*- Mode: Verilog -*-
// Filename        : adxl362.v
// Description     : Top level for ADXL362 Model
// Author          : Philip Tracton
// Created On      : Wed Jun 22 21:28:54 2016
// Last Modified By: Philip Tracton
// Last Modified On: Wed Jun 22 21:28:54 2016
// Update Count    : 0
// Status          : Unknown, Use with caution!


module adxl362 (/*AUTOARG*/
   // Outputs
   MISO, INT1, INT2,
   // Inputs
   SCLK, MOSI, nCS
   ) ;
   input wire SCLK;
   input wire MOSI;
   input wire nCS;
   output wire MISO;
   output wire INT1;
   output wire INT2;
   
endmodule // adxl362
