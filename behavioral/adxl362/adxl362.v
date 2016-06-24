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
   MISO,
   // Inouts
   INT1, INT2,
   // Inputs
   SCLK, MOSI, nCS
   ) ;
   input wire SCLK;
   input wire MOSI;
   input wire nCS;
   output wire MISO;
   inout wire  INT1;
   inout wire  INT2;


   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [5:0]           address;                // From spi of adxl362_spi.v
   wire                 clk;                    // From sys_con of adxl362_system_controller.v
   wire [7:0]           data_write;             // From spi of adxl362_spi.v
   wire                 read;                   // From spi of adxl362_spi.v
   wire                 write;                  // From spi of adxl362_spi.v
   // End of automatics

   /*AUTOREG*/
   
   //
   // System Controller
   //
   // This module generates the 51.2 KHz clock used in the sytem.  This
   // module is not synthesizable.
   //
   adxl362_system_controller sys_con (/*AUTOINST*/
                                      // Outputs
                                      .clk              (clk));


   //
   // SPI
   //
   // This module handles SPI communication with host CPU.  Register bus interface
   // is synched to the clk domain in this module!
   //
   adxl362_spi spi(/*AUTOINST*/
                   // Outputs
                   .MISO                (MISO),
                   .address             (address[5:0]),
                   .data_write          (data_write[7:0]),
                   .write               (write),
                   .read                (read),
                   // Inputs
                   .SCLK                (SCLK),
                   .MOSI                (MOSI),
                   .nCS                 (nCS),
                   .clk                 (clk),
                   .data_read           (data_read[7:0]));
   
endmodule // adxl362
