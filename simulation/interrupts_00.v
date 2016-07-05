//                              -*- Mode: Verilog -*-
// Filename        : burst_00.v
// Description     : Test burst read/write interfacing
// Author          : Philip Tracton
// Created On      : Tue Jun 28 11:31:45 2016
// Last Modified By: Philip Tracton
// Last Modified On: Tue Jun 28 11:31:45 2016
// Update Count    : 0
// Status          : Unknown, Use with caution!

`include "simulation_includes.vh"

module test_case (/*AUTOARG*/ ) ;
   //
   // Test Configuration
   // These parameters need to be set for each test case
   //
   parameter simulation_name = "interrupts_00";
  
   
   parameter number_of_tests = 28;

   reg  err;
   reg [31:0] data_out;
   reg [15:0] i;
   reg [15:0] index ;

   defparam `ADXL362_ACCELEROMETER.XDATA_FILE = "accelerometer_00_xdata.txt";
   defparam `ADXL362_ACCELEROMETER.YDATA_FILE = "accelerometer_00_ydata.txt";
   defparam `ADXL362_ACCELEROMETER.ZDATA_FILE = "accelerometer_00_zdata.txt";
   defparam `ADXL362_ACCELEROMETER.TEMPERATURE_FILE = "accelerometer_00_temperature_data.txt";
   
   //
   // Can't pass memories to tasks, so gigantic arrays!
   //
   reg [(16*7):0] write_mem = 0;   
   reg [(16*7):0] read_mem  = 0;
   
   initial begin
      $display("Interrupts 00 Case");
      `TB.master_bfm.reset;      
      @(posedge `WB_RST);
      @(negedge `WB_RST);
      @(posedge `WB_CLK);
      @(negedge `ADXL362_RESET);
      
      `SIMPLE_SPI_INIT;   

      //
      // INT1 goes high when data ready!
      //
      `ADXL362_WRITE_REGISTER(`ADXL362_INTMAP1, 8'h01);

      @(posedge `ADXL362_INT1) begin
         `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_XDATA_LOW, 16'h0001);
         `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_YDATA_LOW, 16'h0011);
         `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_ZDATA_LOW, 16'h00f1);
         `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_TEMP_LOW,  16'h0047);
      end
      `TEST_COMPARE("INT1 After Data Read", `ADXL362_INT1, 0);

      @(posedge `ADXL362_INT1) begin
         `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_XDATA_LOW, 16'h0002);
         `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_YDATA_LOW, 16'h0012);
         `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_ZDATA_LOW, 16'h00F2);
         `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_TEMP_LOW,  16'h0048);         
      end
      `TEST_COMPARE("INT1 After Data Read", `ADXL362_INT1, 0);

      //
      // INT2 when data in FIFO
      // FIFO the data
      //
      `ADXL362_WRITE_REGISTER(`ADXL362_INTMAP2, 8'h02);     
      `ADXL362_WRITE_REGISTER(`ADXL362_FIFO_CONTROL, 8'h06);
      @(posedge `ADXL362_INT2) begin
         `ADXL362_READ_BURST_FIFO(read_mem, 8);
         `TEST_COMPARE("FIFO 0",  8'h03, read_mem[7:0]);
         `TEST_COMPARE("FIFO 1",  8'h00, read_mem[15:8]);
         `TEST_COMPARE("FIFO 2",  8'h13, read_mem[23:16]);
         `TEST_COMPARE("FIFO 3",  8'h40, read_mem[31:24]);
         `TEST_COMPARE("FIFO 4",  8'hF3, read_mem[39:32]);
         `TEST_COMPARE("FIFO 5",  8'h80, read_mem[47:40]);
         `TEST_COMPARE("FIFO 6",  8'h49, read_mem[55:48]);
         `TEST_COMPARE("FIFO 7",  8'hC0, read_mem[63:56]);          
      end // UNMATCHED !!
      repeat(5) @(posedge `WB_CLK);
      `TEST_COMPARE("INT2 After Data Read", `ADXL362_INT2, 0);

      @(posedge `ADXL362_INT2) begin
         `ADXL362_READ_BURST_FIFO(read_mem, 8);
         `TEST_COMPARE("FIFO 0",  8'h04, read_mem[7:0]);
         `TEST_COMPARE("FIFO 1",  8'h00, read_mem[15:8]);
         `TEST_COMPARE("FIFO 2",  8'h14, read_mem[23:16]);
         `TEST_COMPARE("FIFO 3",  8'h40, read_mem[31:24]);
         `TEST_COMPARE("FIFO 4",  8'hF4, read_mem[39:32]);
         `TEST_COMPARE("FIFO 5",  8'h80, read_mem[47:40]);
         `TEST_COMPARE("FIFO 6",  8'h4A, read_mem[55:48]);
         `TEST_COMPARE("FIFO 7",  8'hC0, read_mem[63:56]);       
      end // UNMATCHED !!
      repeat(5) @(posedge `WB_CLK);
      `TEST_COMPARE("INT2 After Data Read", `ADXL362_INT2, 0);

      
      
      repeat(10) @(posedge `WB_CLK);
      `TEST_COMPLETE;      
   end

   
endmodule // test_case

