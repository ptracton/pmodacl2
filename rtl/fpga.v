//                              -*- Mode: Verilog -*-
// Filename        : fpga.v
// Description     : Prototype FPGA setup for SPI device
// Author          : Philip Tracton
// Created On      : Fri Jul  8 20:51:04 2016
// Last Modified By: Philip Tracton
// Last Modified On: Fri Jul  8 20:51:04 2016
// Update Count    : 0
// Status          : Unknown, Use with caution!

module fpga (/*AUTOARG*/
   // Outputs
   sclk_o, ncs_o, mosi_o,
   // Inputs
   clk_i, rst_i, miso_i, int1, int2
   ) ;
   input wire clk_i;
   input wire rst_i;

   output wire sclk_o;
   output wire ncs_o;
   output wire mosi_o;
   input wire  miso_i;
   input wire  int1;
   input wire  int2;
   
   /*AUTOREG*/

   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire                 active;                 // From spi_inst of spi.v
   wire                 clk;                    // From sys_con of system_controller.v
   wire                 clk_enable;             // From spi_master of spi_controller.v
   wire                 rst;                    // From sys_con of system_controller.v
   wire [7:0]           rx_data;                // From spi_inst of spi.v
   wire                 rx_empty;               // From spi_inst of spi.v
   wire                 rx_full;                // From spi_inst of spi.v
   wire                 rx_read;                // From spi_master of spi_controller.v
   wire                 start;                  // From spi_master of spi_controller.v
   wire [7:0]           tx_data;                // From spi_master of spi_controller.v
   wire                 tx_empty;               // From spi_inst of spi.v
   wire                 tx_full;                // From spi_inst of spi.v
   wire                 tx_write;               // From spi_master of spi_controller.v
   // End of automatics


   //
   // System Controller
   //
   // This module handles all clocks and synchronizes reset from the IO pins
   //
   system_controller sys_con(/*AUTOINST*/
                             // Outputs
                             .clk               (clk),
                             .rst               (rst),
                             .sclk_o            (sclk_o),
                             // Inputs
                             .clk_i             (clk_i),
                             .rst_i             (rst_i),
                             .clk_enable        (clk_enable));
//                             .clk_enable        (~ncs_o));
   
   //
   // SPI Controller
   //
   // This is a state machine to control interfacing with the ADXL362
   //
   spi_controller spi_master(/*AUTOINST*/
                             // Outputs
                             .rx_read           (rx_read),
                             .tx_write          (tx_write),
                             .tx_data           (tx_data[7:0]),
                             .start             (start),
                             .ncs_o             (ncs_o),
                             .clk_enable        (clk_enable),
                             // Inputs
                             .clk               (clk),
                             .rst               (rst),
                             .rx_data           (rx_data[7:0]),
                             .rx_full           (rx_full),
                             .rx_empty          (rx_empty),
                             .tx_empty          (tx_empty),
                             .tx_full           (tx_full),
                             .active            (active));
   
   //
   // SPI
   //
   // This is the SPI module that handles communication with ADXL362
   //
   spi spi_inst(/*AUTOINST*/
                // Outputs
                .mosi_o                 (mosi_o),
                .active                 (active),
                .rx_data                (rx_data[7:0]),
                .rx_full                (rx_full),
                .rx_empty               (rx_empty),
                .tx_empty               (tx_empty),
                .tx_full                (tx_full),
                // Inputs
                .miso_i                 (miso_i),
                .sclk                   (sclk_o),
                .clk                    (clk),
                .rst                    (rst),
                .enable                 (enable),
                .start                  (start),
                .rx_read                (rx_read),
                .tx_write               (tx_write),
                .tx_data                (tx_data[7:0]));
   
   
endmodule // fpga
