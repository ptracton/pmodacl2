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
   parameter simulation_name = "accel_00";
  
   
   parameter number_of_tests = 3;

   reg  err;
   reg [31:0] data_out;
   integer    i;
   
   initial begin
      $display("Test 00 Case");
      `TB.master_bfm.reset;      
      @(posedge `WB_RST);
      @(negedge `WB_RST);
      @(posedge `WB_CLK);
      @(negedge `ADXL362_RESET);
      `SIMPLE_SPI_INIT;      
      `ADXL362_WRITE_REGISTER(`ADXL362_THRESH_ACT_LOW, 8'h7);
      `ADXL362_WRITE_REGISTER(`ADXL362_THRESH_ACT_HIGH, 8'h65);
//      `ADXL362_WRITE_DOUBLE_REGISTER(`ADXL362_THRESH_ACT_LOW, 16'h6507);
//      
      `ADXL362_CHECK_REGISTER(`ADXL362_DEVID_AD, 8'hAD);
      `ADXL362_CHECK_REGISTER(`ADXL362_DEVID_MST, 8'h1D);
      `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_THRESH_ACT_LOW, 16'h507);
      
//      `ADXL362_READ_REGISTER(`ADXL362_DEVID_AD, data_out);      
//      `ADXL362_READ_REGISTER(`ADXL362_DEVID_MST, data_out);
//      `ADXL362_READ_REGISTER(`ADXL362_THRESH_ACT_LOW, data_out);
      #10000;
      `TEST_COMPLETE;      
   end

endmodule // test_case
