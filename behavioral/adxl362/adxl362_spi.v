//                              -*- Mode: Verilog -*-
// Filename        : adxl362_spi.v
// Description     : SPI Slave Interface for ADXL362
// Author          : Philip Tracton
// Created On      : Wed Jun 22 21:33:25 2016
// Last Modified By: Philip Tracton
// Last Modified On: Wed Jun 22 21:33:25 2016
// Update Count    : 0
// Status          : Unknown, Use with caution!

module adxl362_spi (/*AUTOARG*/
   // Outputs
   MISO, address, data_write, write, read,
   // Inputs
   SCLK, MOSI, nCS, data_read
   ) ;
   input wire SCLK;
   input wire MOSI;
   input wire nCS;
   output reg MISO;

   output reg [5:0] address;
   output reg [7:0] data_write;
   input wire [7:0] data_read;
   output reg      write;
   output reg      read;
   
endmodule // adxl362_spi
