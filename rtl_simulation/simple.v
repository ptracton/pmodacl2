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
   parameter simulation_name = "simple";
  
   defparam `ADXL362_ACCELEROMETER.XDATA_FILE = "accelerometer_00_xdata.txt";
   defparam `ADXL362_ACCELEROMETER.YDATA_FILE = "accelerometer_00_ydata.txt";
   defparam `ADXL362_ACCELEROMETER.ZDATA_FILE = "accelerometer_00_zdata.txt";
   defparam `ADXL362_ACCELEROMETER.TEMPERATURE_FILE = "accelerometer_00_temperature_data.txt";
   
      
   parameter number_of_tests = 3;

   reg  err;
   reg [31:0] data_out;
   integer    i;
   
   initial begin
      $display("Simple 00 Case");
      @(posedge `WB_RST);
      @(negedge `WB_RST);
      @(posedge `WB_CLK);
      @(negedge `ADXL362_RESET);

      #220000;
      `TEST_COMPLETE;      
   end

endmodule // test_case