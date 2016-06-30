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
   parameter simulation_name = "accelerometer_00";
   parameter number_of_tests = 2;


   defparam `ADXL362_ACCELEROMETER.XDATA_FILE = "accelerometer_00_xdata.txt";
   defparam `ADXL362_ACCELEROMETER.YDATA_FILE = "accelerometer_00_ydata.txt";
   defparam `ADXL362_ACCELEROMETER.ZDATA_FILE = "accelerometer_00_zdata.txt";
   defparam `ADXL362_ACCELEROMETER.TEMPERATURE_FILE = "accelerometer_00_temperature_data.txt";
   
   
   reg  err;
   reg [31:0] data_out = 0;
   integer    i;
   
   initial begin
      $display("Accelerometer 00 Case");
      `TB.master_bfm.reset;      
      @(posedge `WB_RST);
      @(negedge `WB_RST);
      @(posedge `WB_CLK);

      `SIMPLE_SPI_INIT;

      //
      // Set FIFO Mode to Streaming
      // Turn on Temperature FIFO
      //
      `ADXL362_WRITE_REGISTER(`ADXL362_FIFO_CONTROL, 8'h06);

      `ADXL362_READ_REGISTER(`ADXL362_STATUS, data_out);
      while (data_out[8] ==0) begin
         repeat(100) @(posedge `WB_CLK);
         `ADXL362_READ_REGISTER(`ADXL362_STATUS, data_out);
      end
      repeat(5) @(posedge `WB_CLK);
      `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_XDATA_LOW, 16'h0001);
      `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_YDATA_LOW, 16'h0011);
      `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_ZDATA_LOW, 16'h01f1);
      `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_TEMP_LOW,  16'h0047);
      while (data_out[8] ==1) begin
         repeat(100) @(posedge `WB_CLK);
         `ADXL362_READ_REGISTER(`ADXL362_STATUS, data_out);
      end
      
      while (data_out[8] ==0) begin
         repeat(100) @(posedge `WB_CLK);
         `ADXL362_READ_REGISTER(`ADXL362_STATUS, data_out);
      end
      repeat(5) @(posedge `WB_CLK);
      `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_XDATA_LOW, 16'h0002);
      `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_YDATA_LOW, 16'h0012);
      `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_ZDATA_LOW, 16'h00F2);
      `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_TEMP_LOW,  16'h0048);
      while (data_out[8] ==1) begin
         repeat(100) @(posedge `WB_CLK);
         `ADXL362_READ_REGISTER(`ADXL362_STATUS, data_out);
      end
      
      while (data_out[8] ==0) begin
         repeat(100) @(posedge `WB_CLK);
         `ADXL362_READ_REGISTER(`ADXL362_STATUS, data_out);
      end
      repeat(5) @(posedge `WB_CLK);
      `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_XDATA_LOW, 16'h0000);
      `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_YDATA_LOW, 16'h0000);
      `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_ZDATA_LOW, 16'h0000);
      `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_TEMP_LOW,  16'h0000);
      while (data_out[8] ==1) begin
         repeat(100) @(posedge `WB_CLK);
         `ADXL362_READ_REGISTER(`ADXL362_STATUS, data_out);
      end
      
      while (data_out[8] ==0) begin
         repeat(100) @(posedge `WB_CLK);
         `ADXL362_READ_REGISTER(`ADXL362_STATUS, data_out);
      end
      repeat(5) @(posedge `WB_CLK);
      `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_XDATA_LOW, 16'h0000);
      `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_YDATA_LOW, 16'h0000);
      `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_ZDATA_LOW, 16'h0000);
      `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_TEMP_LOW,  16'h0000);      
      while (data_out[8] ==1) begin
         repeat(100) @(posedge `WB_CLK);
         `ADXL362_READ_REGISTER(`ADXL362_STATUS, data_out);
      end
      
      repeat(100) @(posedge `WB_CLK);
      `TEST_COMPLETE;      
   end

endmodule // test_case
