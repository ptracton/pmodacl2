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
   wire [2:0]           bit_count;              // From spi_inst of spi.v
   wire                 clk;                    // From sys_con of system_controller.v
   wire                 clk_enable;             // From spi_master of spi_controller.v
   wire                 rst;                    // From sys_con of system_controller.v
   wire                 spi_active;             // From spi_inst of spi.v
   wire                 spi_byte_begin;         // From spi_inst of spi.v
   wire                 spi_byte_done;          // From spi_inst of spi.v
   wire [7:0]           spi_rx_data;            // From spi_inst of spi.v
   wire [7:0]           spi_tx_data;            // From spi_master of spi_controller.v
   wire                 start;                  // From spi_master of spi_controller.v
   wire [15:0]          temperature;            // From spi_master of spi_controller.v
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
                             .spi_tx_data       (spi_tx_data[7:0]),
                             .start             (start),
                             .ncs_o             (ncs_o),
                             .clk_enable        (clk_enable),
                             .temperature       (temperature[15:0]),
                             // Inputs
                             .clk               (clk),
                             .rst               (rst),
                             .spi_rx_data       (spi_rx_data[7:0]),
                             .spi_byte_done     (spi_byte_done),
                             .spi_byte_begin    (spi_byte_begin),
                             .bit_count         (bit_count[2:0]),
                             .state_machine_active(state_machine_active));
   
   //
   // SPI
   //
   // This is the SPI module that handles communication with ADXL362
   //
   spi spi_inst(/*AUTOINST*/
                // Outputs
                .mosi_o                 (mosi_o),
                .spi_active             (spi_active),
                .spi_rx_data            (spi_rx_data[7:0]),
                .bit_count              (bit_count[2:0]),
                .spi_byte_done          (spi_byte_done),
                .spi_byte_begin         (spi_byte_begin),
                // Inputs
                .miso_i                 (miso_i),
                .sclk_o                 (sclk_o),
                .ncs_o                  (ncs_o),
                .clk                    (clk),
                .rst                    (rst),
                .spi_tx_data            (spi_tx_data[7:0]));
   
   
endmodule // fpga
