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
   parameter simulation_name = "burst_00";
  
   
   parameter number_of_tests = 3;

   reg  err;
   reg [31:0] data_out;
   reg [15:0] i;
   reg [15:0] index ;
   
   //
   // Can't pass memories to tasks, so gigantic arrays!
   //
   reg [(16*7):0] write_mem = 0;   
   reg [(16*7):0] read_mem  = 0;
   
   initial begin
      $display("Test 00 Case");
      `TB.master_bfm.reset;      
      @(posedge `WB_RST);
      @(negedge `WB_RST);
      @(posedge `WB_CLK);

      `SIMPLE_SPI_INIT;   

      `ADXL362_WRITE_DOUBLE_REGISTER(`ADXL362_THRESH_ACT_LOW, 16'h6507);
      `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_THRESH_ACT_LOW, 16'h507);

      repeat(100) @(posedge `WB_CLK);
      
      for (i = 0; i< 14; i= i+1) begin
         write_mem[(i*8)+7 -: 8] = i | 8'h80;         
      end

      repeat(100) @(posedge `WB_CLK);
      
      `ADXL362_WRITE_BURST_REGISTERS(`ADXL362_THRESH_ACT_LOW, write_mem, 14);
      `ADXL362_READ_BURST_REGISTERS(`ADXL362_THRESH_ACT_LOW, read_mem, 14);
      `TEST_COMPARE("Reg 0", 8'h80, read_mem[7:0]);
      $display("MEM 0: 0x%x", read_mem[07:00]);
      $display("MEM 1: 0x%x", read_mem[15:08]);
      $display("MEM 2: 0x%x", read_mem[23:16]);
      $display("MEM 3: 0x%x", read_mem[31:24]);
      $display("MEM 4: 0x%x", read_mem[39:32]);
      $display("MEM 5: 0x%x", read_mem[47:40]);
      $display("MEM 6: 0x%x", read_mem[55:48]);
      $display("MEM 7: 0x%x", read_mem[63:56]);
      
     // `ADXL362_CHECK_DOUBLE_REGISTER(`ADXL362_THRESH_ACT_LOW, 16'h507);


      
      #10000;
      `TEST_COMPLETE;      
   end

   
endmodule // test_case

