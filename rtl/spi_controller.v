//                              -*- Mode: Verilog -*-
// Filename        : spi_controller.v
// Description     : State Machine to control SPI interface
// Author          : Philip Tracton
// Created On      : Fri Jul  8 20:59:53 2016
// Last Modified By: Philip Tracton
// Last Modified On: Fri Jul  8 20:59:53 2016
// Update Count    : 0
// Status          : Unknown, Use with caution!
module spi_controller (/*AUTOARG*/
   // Outputs
   rx_read, tx_write, tx_data,
   // Inputs
   clk, rst, rx_data, rx_full, rx_empty, tx_empty, tx_full
   ) ;
   input wire clk;
   input wire rst;

   //
   // RX FIFO
   //
   output wire rx_read;   
   input wire [7:0] rx_data;
   input wire       rx_full;
   input wire       rx_empty;
   
   //
   // TX FIFO
   //
   output wire  tx_write;
   output [7:0] tx_data;
   input wire   tx_empty;
   input wire   tx_full;
   
endmodule // spi_controller
