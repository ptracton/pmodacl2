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
  
   
   parameter number_of_tests = 15;

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
      //$display("Read Mem 0x%x", read_mem);
      
      `TEST_COMPARE("Reg 0",  8'h80, read_mem[7:0]);
      `TEST_COMPARE("Reg 1",  8'h01, read_mem[15:8]);
      `TEST_COMPARE("Reg 2",  8'h82, read_mem[23:16]);
      `TEST_COMPARE("Reg 3",  8'h83, read_mem[31:24]);
      `TEST_COMPARE("Reg 4",  8'h05, read_mem[39:32]);
      `TEST_COMPARE("Reg 5",  8'h84, read_mem[47:40]);
      `TEST_COMPARE("Reg 6",  8'h06, read_mem[55:48]);
      `TEST_COMPARE("Reg 7",  8'h00, read_mem[63:56]);
      `TEST_COMPARE("Reg 8",  8'h08, read_mem[71:64]);
      `TEST_COMPARE("Reg 9",  8'h89, read_mem[79:72]);
      `TEST_COMPARE("Reg 10", 8'h8a, read_mem[87:80]);
      `TEST_COMPARE("Reg 11", 8'h8b, read_mem[95:88]);
      `TEST_COMPARE("Reg 12", 8'h8c, read_mem[103:96]);
      `TEST_COMPARE("Reg 13", 8'h8d, read_mem[111:104]);
      
/* -----\/----- EXCLUDED -----\/-----
      $display("MEM 0: 0x%x", read_mem[07:00]);
      $display("MEM 1: 0x%x", read_mem[15:08]);
      $display("MEM 2: 0x%x", read_mem[23:16]);
      $display("MEM 3: 0x%x", read_mem[31:24]);
      $display("MEM 4: 0x%x", read_mem[39:32]);
      $display("MEM 5: 0x%x", read_mem[47:40]);
      $display("MEM 6: 0x%x", read_mem[55:48]);
      $display("MEM 7: 0x%x", read_mem[63:56]);
      $display("MEM 8: 0x%x", read_mem[71:64]);
      $display("MEM 9: 0x%x", read_mem[79:72]);
      $display("MEM 10: 0x%x", read_mem[87:80]);
      $display("MEM 11: 0x%x", read_mem[95:88]);
      $display("MEM 12: 0x%x", read_mem[103:96]);
      $display("MEM 13: 0x%x", read_mem[111:104]);
 -----/\----- EXCLUDED -----/\----- */

      repeat(100) @(posedge `WB_CLK);
      `TEST_COMPLETE;      
   end

   
endmodule // test_case

