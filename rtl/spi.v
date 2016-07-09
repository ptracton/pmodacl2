//                              -*- Mode: Verilog -*-
// Filename        : spi.v
// Description     : Simple SPI Module
// Author          : Philip Tracton
// Created On      : Fri Jul  8 20:42:13 2016
// Last Modified By: Philip Tracton
// Last Modified On: Fri Jul  8 20:42:13 2016
// Update Count    : 0
// Status          : Unknown, Use with caution!

module spi (/*AUTOARG*/
   // Outputs
   ncs_o, mosi_o, clk_enable, rx_data, rx_full, rx_empty, tx_empty,
   tx_full,
   // Inputs
   miso_i, clk, rst, enable, rx_read, tx_write, tx_data
   ) ;

   //
   // SPI Side Interface
   //
   output wire ncs_o;
   output wire mosi_o;
   input  wire miso_i;

   //
   // Host Side Interface
   //
   input wire  clk;
   input wire  rst;
   input wire  enable;
   output reg  clk_enable;

   //
   // RX FIFO
   //
   input wire  rx_read;   
   output wire [7:0] rx_data;
   output wire       rx_full;
   output wire       rx_empty;
   
   //
   // TX FIFO
   //
   input wire  tx_write;
   input [7:0] tx_data;
   output wire tx_empty;
   output wire tx_full;
   
endmodule // spi
