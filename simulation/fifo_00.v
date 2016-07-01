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
   parameter simulation_name = "fifo_00";
   parameter number_of_tests = 32;


   defparam `ADXL362_ACCELEROMETER.XDATA_FILE = "accelerometer_00_xdata.txt";
   defparam `ADXL362_ACCELEROMETER.YDATA_FILE = "accelerometer_00_ydata.txt";
   defparam `ADXL362_ACCELEROMETER.ZDATA_FILE = "accelerometer_00_zdata.txt";
   defparam `ADXL362_ACCELEROMETER.TEMPERATURE_FILE = "accelerometer_00_temperature_data.txt";
   
   
   reg  err;
   reg [31:0] data_out = 0;
   integer    i;
   reg [(16*7):0] read_mem  = 0;
   initial begin
      $display("FIFO 00 Case");
      `TB.master_bfm.reset;      
      @(posedge `WB_RST);
      @(negedge `WB_RST);
      @(posedge `WB_CLK);
      @(negedge `ADXL362_RESET);
      
      `SIMPLE_SPI_INIT;

      //
      // Set FIFO Mode to Streaming
      // Turn on Temperature FIFO
      // Enable FIFO Streaming Mode
      //
      `ADXL362_WRITE_REGISTER(`ADXL362_FIFO_CONTROL, 8'h06);

      `ADXL362_READ_REGISTER(`ADXL362_STATUS, data_out);
      while (data_out[9] ==0) begin
         repeat(100) @(posedge `WB_CLK);
         `ADXL362_READ_REGISTER(`ADXL362_STATUS, data_out);
      end
      repeat(10) @(posedge `WB_CLK);
      `ADXL362_READ_BURST_FIFO(read_mem, 8);
      
      `TEST_COMPARE("FIFO 0",  8'h01, read_mem[7:0]);
      `TEST_COMPARE("FIFO 1",  8'h00, read_mem[15:8]);
      `TEST_COMPARE("FIFO 2",  8'h11, read_mem[23:16]);
      `TEST_COMPARE("FIFO 3",  8'h40, read_mem[31:24]);
      `TEST_COMPARE("FIFO 4",  8'hF1, read_mem[39:32]);
      `TEST_COMPARE("FIFO 5",  8'h80, read_mem[47:40]);
      `TEST_COMPARE("FIFO 6",  8'h47, read_mem[55:48]);
      `TEST_COMPARE("FIFO 7",  8'hC0, read_mem[63:56]);      

      
      repeat(100) @(posedge `WB_CLK);
      `ADXL362_READ_REGISTER(`ADXL362_STATUS, data_out);      
      while (data_out[9] ==0) begin
         repeat(100) @(posedge `WB_CLK);
         `ADXL362_READ_REGISTER(`ADXL362_STATUS, data_out);
      end
      repeat(10) @(posedge `WB_CLK);
      `ADXL362_READ_BURST_FIFO(read_mem, 8);

      `TEST_COMPARE("FIFO 0",  8'h02, read_mem[7:0]);
      `TEST_COMPARE("FIFO 1",  8'h00, read_mem[15:8]);
      `TEST_COMPARE("FIFO 2",  8'h12, read_mem[23:16]);
      `TEST_COMPARE("FIFO 3",  8'h40, read_mem[31:24]);
      `TEST_COMPARE("FIFO 4",  8'hF2, read_mem[39:32]);
      `TEST_COMPARE("FIFO 5",  8'h80, read_mem[47:40]);
      `TEST_COMPARE("FIFO 6",  8'h48, read_mem[55:48]);
      `TEST_COMPARE("FIFO 7",  8'hC0, read_mem[63:56]);

      repeat(100) @(posedge `WB_CLK);
      `ADXL362_READ_REGISTER(`ADXL362_STATUS, data_out);      
      while (data_out[9] ==0) begin
         repeat(100) @(posedge `WB_CLK);
         `ADXL362_READ_REGISTER(`ADXL362_STATUS, data_out);
      end
      repeat(10) @(posedge `WB_CLK);
      `ADXL362_READ_BURST_FIFO(read_mem, 8);

      `TEST_COMPARE("FIFO 0",  8'h03, read_mem[7:0]);
      `TEST_COMPARE("FIFO 1",  8'h00, read_mem[15:8]);
      `TEST_COMPARE("FIFO 2",  8'h13, read_mem[23:16]);
      `TEST_COMPARE("FIFO 3",  8'h40, read_mem[31:24]);
      `TEST_COMPARE("FIFO 4",  8'hF3, read_mem[39:32]);
      `TEST_COMPARE("FIFO 5",  8'h80, read_mem[47:40]);
      `TEST_COMPARE("FIFO 6",  8'h49, read_mem[55:48]);
      `TEST_COMPARE("FIFO 7",  8'hC0, read_mem[63:56]); 

      repeat(100) @(posedge `WB_CLK);
      `ADXL362_READ_REGISTER(`ADXL362_STATUS, data_out);      
      while (data_out[9] ==0) begin
         repeat(100) @(posedge `WB_CLK);
         `ADXL362_READ_REGISTER(`ADXL362_STATUS, data_out);
      end
      repeat(10) @(posedge `WB_CLK);
      `ADXL362_READ_BURST_FIFO(read_mem, 8);

      `TEST_COMPARE("FIFO 0",  8'h04, read_mem[7:0]);
      `TEST_COMPARE("FIFO 1",  8'h00, read_mem[15:8]);
      `TEST_COMPARE("FIFO 2",  8'h14, read_mem[23:16]);
      `TEST_COMPARE("FIFO 3",  8'h40, read_mem[31:24]);
      `TEST_COMPARE("FIFO 4",  8'hF4, read_mem[39:32]);
      `TEST_COMPARE("FIFO 5",  8'h80, read_mem[47:40]);
      `TEST_COMPARE("FIFO 6",  8'h4A, read_mem[55:48]);
      `TEST_COMPARE("FIFO 7",  8'hC0, read_mem[63:56]);       
      
      repeat(100) @(posedge `WB_CLK);
      `TEST_COMPLETE;      
   end

endmodule // test_case
