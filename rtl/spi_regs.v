//                              -*- Mode: Verilog -*-
// Filename        : spi_regs.v
// Description     : SPI Registers
// Author          : Philip Tracton
// Created On      : Tue Jul 19 21:20:13 2016
// Last Modified By: Philip Tracton
// Last Modified On: Tue Jul 19 21:20:13 2016
// Update Count    : 0
// Status          : Unknown, Use with caution!

module spi_regs (/*AUTOARG*/
   // Outputs
   data_out, wfwe, rfre, wr_spsr, clear_spif, clear_wcol, wfdin,
   // Inputs
   clk, reset, port_id, data_in, read_strobe, write_strobe, rfdout
   ) ;
   parameter BASE_ADDRESS = 8'h00;   

   //
   // System Interface
   //
   input clk;
   input reset;

   //
   // Picoblaze Bus Interface
   //
   input [7:0]            port_id;
   input [7:0]            data_in;
   output [7:0]           data_out;
   input                  read_strobe;
   input                  write_strobe;

   //
   // Spi Device Interface
   //
   input wire [7:0]       rfdout; //Read FIFO Output 
   output wire            wfwe; //Write FIFO     
   output wire            rfre; //Read FIFO
   output wire            wr_spsr; // Write SPSR
   output wire            clear_spif; //Clear the SPIF bit
   output wire            clear_wcol; //Clear the WCOL bit
   output wire [7:0]      wfdin;  // Write FIFO Data In
   
endmodule // spi_regs
