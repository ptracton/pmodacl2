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
   wire [7:0]           act_inact_ctrl;         // From registers of adxl362_regs.v
   wire [5:0]           address;                // From spi of adxl362_spi.v
   wire                 clk;                    // From sys_con of adxl362_system_controller.v
   wire                 clk_16mhz;              // From sys_con of adxl362_system_controller.v
   wire [7:0]           data_write;             // From spi of adxl362_spi.v
   wire [3:0]           fifo_ctrl;              // From registers of adxl362_regs.v
   wire [7:0]           fifo_samples;           // From registers of adxl362_regs.v
   wire [7:0]           filter_ctrl;            // From registers of adxl362_regs.v
   wire [7:0]           intmap1;                // From registers of adxl362_regs.v
   wire [7:0]           intmap2;                // From registers of adxl362_regs.v
   wire [7:0]           power_ctrl;             // From registers of adxl362_regs.v
   wire                 reset;                  // From sys_con of adxl362_system_controller.v
   wire [7:0]           self_test;              // From registers of adxl362_regs.v
   wire [10:0]          threshold_active;       // From registers of adxl362_regs.v
   wire [10:0]          threshold_inactive;     // From registers of adxl362_regs.v
   wire [7:0]           time_active;            // From registers of adxl362_regs.v
   wire [15:0]          time_inactive;          // From registers of adxl362_regs.v
   wire                 write;                  // From spi of adxl362_spi.v
   // End of automatics

   /*AUTOREG*/
   reg                  soft_reset = 0;
   wire [11:0]          xdata;
   wire [11:0]          ydata;
   wire [11:0]          zdata;
   wire [11:0]          temperature;
   //
   // System Controller
   //
   // This module generates the 51.2 KHz clock used in the sytem.  This
   // module is not synthesizable.
   //
   adxl362_system_controller sys_con (/*AUTOINST*/
                                      // Outputs
                                      .clk              (clk),
                                      .clk_16mhz        (clk_16mhz),
                                      .reset            (reset),
                                      // Inputs
                                      .soft_reset       (soft_reset));


   //
   // SPI
   //
   // This module handles SPI communication with host CPU.  Register bus interface
   // is synched to the clk domain in this module!
   //
   wire [7:0]           data_read;   
   adxl362_spi spi(/*AUTOINST*/
                   // Outputs
                   .MISO                (MISO),
                   .address             (address[5:0]),
                   .data_write          (data_write[7:0]),
                   .write               (write),
                   // Inputs
                   .SCLK                (SCLK),
                   .MOSI                (MOSI),
                   .nCS                 (nCS),
                   .clk_16mhz           (clk_16mhz),
                   .data_read           (data_read[7:0]));

   //
   // Registers
   //
   // These are the firmware accessible registers
   //
   adxl362_regs registers(/*AUTOINST*/
                          // Outputs
                          .data_read            (data_read[7:0]),
                          .threshold_active     (threshold_active[10:0]),
                          .time_active          (time_active[7:0]),
                          .threshold_inactive   (threshold_inactive[10:0]),
                          .time_inactive        (time_inactive[15:0]),
                          .act_inact_ctrl       (act_inact_ctrl[7:0]),
                          .fifo_ctrl            (fifo_ctrl[3:0]),
                          .fifo_samples         (fifo_samples[7:0]),
                          .intmap1              (intmap1[7:0]),
                          .intmap2              (intmap2[7:0]),
                          .filter_ctrl          (filter_ctrl[7:0]),
                          .power_ctrl           (power_ctrl[7:0]),
                          .self_test            (self_test[7:0]),
                          // Inputs
                          .clk_16mhz            (clk_16mhz),
                          .write                (write),
                          .address              (address[5:0]),
                          .data_write           (data_write[7:0]),
                          .xdata                (xdata[11:0]),
                          .ydata                (ydata[11:0]),
                          .zdata                (zdata[11:0]),
                          .temperature          (temperature[11:0]));
   
   
endmodule // adxl362
