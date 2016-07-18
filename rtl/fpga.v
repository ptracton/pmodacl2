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
   sck_o, ncs_o, mosi_o,
   // Inputs
   clk_i, rst_i, miso_i, int1, int2
   ) ;
   input wire clk_i;
   input wire rst_i;

   output wire sck_o;
   output wire ncs_o;
   output wire mosi_o;
   input wire  miso_i;
   input wire  int1;
   input wire  int2;
   
   /*AUTOREG*/

   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire                 clear_spif;             // From controller of spi_controller.v
   wire                 clear_wcol;             // From controller of spi_controller.v
   wire                 clk;                    // From sys_con of system_controller.v
   wire                 inta_o;                 // From spi of simple_spi_top_modified.v
   wire                 nrst;                   // From sys_con of system_controller.v
   wire [7:0]           rfdout;                 // From spi of simple_spi_top_modified.v
   wire                 rfre;                   // From controller of spi_controller.v
   wire                 rst;                    // From sys_con of system_controller.v
   wire [7:0]           spcr;                   // From controller of spi_controller.v
   wire [7:0]           sper;                   // From controller of spi_controller.v
   wire [7:0]           spsr;                   // From spi of simple_spi_top_modified.v
   wire [15:0]          temperature;            // From controller of spi_controller.v
   wire [7:0]           wfdin;                  // From controller of spi_controller.v
   wire                 wfwe;                   // From controller of spi_controller.v
   wire                 wr_spsr;                // From controller of spi_controller.v
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
                             .nrst              (nrst),
                             // Inputs
                             .clk_i             (clk_i),
                             .rst_i             (rst_i));
   
   //
   // SPI Controller
   //
   // This is a state machine to control interfacing with the ADXL362
   //


   spi_controller controller(/*AUTOINST*/
                             // Outputs
                             .wfdin             (wfdin[7:0]),
                             .spcr              (spcr[7:0]),
                             .sper              (sper[7:0]),
                             .wfwe              (wfwe),
                             .rfre              (rfre),
                             .wr_spsr           (wr_spsr),
                             .clear_spif        (clear_spif),
                             .clear_wcol        (clear_wcol),
                             .ncs_o             (ncs_o),
                             .temperature       (temperature[15:0]),
                             // Inputs
                             .clk               (clk),
                             .rst               (rst),
                             .rfdout            (rfdout[7:0]),
                             .inta_o            (inta_o),
                             .spsr              (spsr[7:0]));
   
   
   
   //
   // SPI
   //
   // This is the SPI module that handles communication with ADXL362
   //
   simple_spi_top_modified spi(/*AUTOINST*/
                               // Outputs
                               .spsr            (spsr[7:0]),
                               .inta_o          (inta_o),
                               .rfdout          (rfdout[7:0]),
                               .sck_o           (sck_o),
                               .mosi_o          (mosi_o),
                               // Inputs
                               .clk_i           (clk_i),
                               .nrst            (nrst),
                               .spcr            (spcr[7:0]),
                               .sper            (sper[7:0]),
                               .wfwe            (wfwe),
                               .rfre            (rfre),
                               .wr_spsr         (wr_spsr),
                               .clear_spif      (clear_spif),
                               .clear_wcol      (clear_wcol),
                               .wfdin           (wfdin[7:0]),
                               .miso_i          (miso_i));
   
   
endmodule // fpga
