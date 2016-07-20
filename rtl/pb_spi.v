//                              -*- Mode: Verilog -*-
// Filename        : pb_spi.v
// Description     : Picoblaze SPI Module
// Author          : Philip Tracton
// Created On      : Tue Jul 19 21:17:12 2016
// Last Modified By: Philip Tracton
// Last Modified On: Tue Jul 19 21:17:12 2016
// Update Count    : 0
// Status          : Unknown, Use with caution!

module pb_spi (/*AUTOARG*/
   // Outputs
   data_out, interrupt, sck_o, ncs_o, mosi_o,
   // Inputs
   clk, reset, port_id, data_in, read_strobe, write_strobe, miso_i
   ) ;
   
   parameter WIDTH = 8;
   parameter BASE_ADDRESS = 8'h00;

   //
   // System Interface
   //
   input clk;
   input reset;

   //
   // Picoblaze Bus Interface
   //
   input [7:0] port_id;
   input [7:0] data_in;
   output [7:0] data_out;
   input        read_strobe;
   input        write_strobe;
   output       interrupt;

   //
   // SPI Interface
   //
   output wire  sck_o;
   output wire  ncs_o;
   output wire  mosi_o;
   input wire   miso_i;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg                  interrupt;
   // End of automatics

   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire                 clear_spif;             // From regs of spi_regs.v
   wire                 clear_wcol;             // From regs of spi_regs.v
   wire                 inta_o;                 // From spi of simple_spi_top_modified.v
   wire [7:0]           rfdout;                 // From spi of simple_spi_top_modified.v
   wire                 rfre;                   // From regs of spi_regs.v
   wire [7:0]           spcr;                   // From regs of spi_regs.v
   wire [7:0]           sper;                   // From regs of spi_regs.v
   wire [7:0]           spsr;                   // From spi of simple_spi_top_modified.v
   wire [7:0]           wfdin;                  // From regs of spi_regs.v
   wire                 wfwe;                   // From regs of spi_regs.v
   wire                 wr_spsr;                // From regs of spi_regs.v
   // End of automatics

   spi_regs regs(/*AUTOINST*/
                 // Outputs
                 .data_out              (data_out[7:0]),
                 .wfwe                  (wfwe),
                 .rfre                  (rfre),
                 .wr_spsr               (wr_spsr),
                 .clear_spif            (clear_spif),
                 .clear_wcol            (clear_wcol),
                 .wfdin                 (wfdin[7:0]),
                 .spcr                  (spcr[7:0]),
                 .sper                  (sper[7:0]),
                 // Inputs
                 .clk                   (clk),
                 .reset                 (reset),
                 .port_id               (port_id[7:0]),
                 .data_in               (data_in[7:0]),
                 .read_strobe           (read_strobe),
                 .write_strobe          (write_strobe),
                 .rfdout                (rfdout[7:0]));
   
   
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
   
endmodule // pb_spi
