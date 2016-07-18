//                              -*- Mode: Verilog -*-
// Filename        : spi_testbench.v
// Description     : Testbench for testing SPI module
// Author          : Philip Tracton
// Created On      : Fri Jul  8 21:08:52 2016
// Last Modified By: Philip Tracton
// Last Modified On: Fri Jul  8 21:08:52 2016
// Update Count    : 0
// Status          : Unknown, Use with caution!

`include "timescale.v"
`include "simulation_includes.vh"

module spi_testbench (/*AUTOARG*/ ) ;

   //
   // Creates a clock, reset, a timeout in case the sim never stops,
   // and pass/fail managers
   //
   
`include "test_management.v"

   wire sck;
   wire miso;
   wire mosi;
   wire ncs;

   wire wb_clk = clk;
   wire wb_rst = reset;
      
   fpga dut(
            // Outputs
            .sck_o(sck), 
            .ncs_o(ncs), 
            .mosi_o(mosi),
            // Inputs
            .clk_i(clk), 
            .rst_i(reset), 
            .miso_i(miso),
            .int1(int1),
            .int2(int2)
            ) ;

   
   //
   // Tasks used to interface with ADXL362
   //
   spi_tasks spi_tasks();
      

   adxl362 adxl362(
                   .SCLK(sck),
                   .MOSI(mosi),
                   .nCS(ncs),
                   .MISO(miso),
                   .INT1(int1),
                   .INT2(int2)                         
                   );
   
   
   //
   // Tasks used to help test cases
   //
   test_tasks test_tasks();
   
   //
   // The actual test cases that are being tested
   //
   test_case test_case();   
   
endmodule // spi_testbench
