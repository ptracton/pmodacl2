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
   mosi_o, spi_active, spi_rx_data, bit_count, spi_byte_done,
   spi_byte_begin,
   // Inputs
   miso_i, sclk_o, ncs_o, clk, rst, spi_tx_data
   ) ;

   //
   // SPI Side Interface
   //
   
   output wire mosi_o;
   input  wire miso_i;
   input wire  sclk_o;
   input wire  ncs_o;
   
   //
   // Host Side Interface
   //
   input wire  clk;
   input wire  rst;
   output wire spi_active;   
   input wire [7:0] spi_tx_data;
   output reg [7:0] spi_rx_data;
   output reg [2:0] bit_count;
   output wire      spi_byte_done;
   output wire      spi_byte_begin;

   
   reg [2:0]        bit_count_previous;
   assign mosi_o = (ncs_o) ? 1'bz : spi_tx_data[7-bit_count];
   
//   assign      spi_byte_done = (bit_count == 0) && (bit_count_previous == 7);
//   assign      spi_byte_begin = (bit_count == 1) && (bit_count_previous == 0);

   assign      spi_byte_done = (bit_count == 7);   
   assign      spi_byte_begin = (bit_count == 0);

   
   always @(posedge sclk_o or posedge rst)
     if (rst) begin
        bit_count <= 0;
        spi_rx_data <= 0;  
        bit_count_previous <= 0;        
     end else begin
        bit_count <= bit_count + 1;
        bit_count_previous <= bit_count;        
        #1 spi_rx_data[7-bit_count] <= miso_i;        
     end

 
   
endmodule // spi
