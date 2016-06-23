//                              -*- Mode: Verilog -*-
// Filename        : test_00.v
// Description     : Simple ADXL362 Test Case to bring environment to life
// Author          : Philip Tracton
// Created On      : Thu Jun 23 11:36:12 2016
// Last Modified By: Philip Tracton
// Last Modified On: Thu Jun 23 11:36:12 2016
// Update Count    : 0
// Status          : Unknown, Use with caution!

`include "simulation_includes.vh"

module test_case ();

   //
   // Test Configuration
   // These parameters need to be set for each test case
   //
   parameter simulation_name = "test_00";
  
   
   parameter number_of_tests = 2;

   reg  err;
   reg [31:0] data_out;
   integer    i;
   
   initial begin
      $display("Test 00 Case");
      `TB.master_bfm.reset;      
      @(posedge `WB_RST);
      @(negedge `WB_RST);
      @(posedge `WB_CLK);

      `TB.master_bfm.read_burst(`SPI_CONTROL_REG_ADDRESS, data_out, 4'h8, 1, 0, err);
      `TEST_COMPARE("SPI Control REG POR", 32'h10000000, data_out);

     `TB.master_bfm.read_burst(`SPI_STATUS_REG_ADDRESS, data_out, 4'h4, 1, 0, err);
      `TEST_COMPARE("SPI Status REG POR", 32'h0005_0000, data_out);
      
      #1000;
      `TEST_COMPLETE;      
   end

endmodule // test_case
