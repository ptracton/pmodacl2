//                              -*- Mode: Verilog -*-
// Filename        : adxl362_tasks.v
// Description     : Tasks for interfacing with ADXL362
// Author          : Philip Tracton
// Created On      : Thu Jun 23 21:38:43 2016
// Last Modified By: Philip Tracton
// Last Modified On: Thu Jun 23 21:38:43 2016
// Update Count    : 0
// Status          : Unknown, Use with caution!


`include "simulation_includes.vh"

module adxl362_tasks (/*AUTOARG*/ ) ;
   reg  err;
   reg [31:0] data_out;
   integer    i;
   
   task init_simple_spi;

      begin
         //
         // SPCR -- Control Register
         //
         // BIT  Controls          State
         // 7    Interrupt Enable  0
         // 6    Peripheral Enable 1
         // 5    RESERVED          0
         // 4    Master            1
         // 3    CPOL              0
         // 2    CPHA              0 
         // 1:0  SPR               10  -- Divide WB_CLK by 16 target SPI at 6.25 MHz
         // 
         //
         @(posedge `WB_CLK);
         `TB.master_bfm.write_burst(`SPI_CONTROL_REG_ADDRESS, 32'h5200_0000, 4'h8, 1, 0, err);
         
         //
         // SPSR -- Status Register
         //
         // BIT  Controls          State
         // 7    Interrupt Flag    1  -- To clear it
         // 6    Write Collision   1  -- To Clear it
         // 5:4  RESERVED          RO
         // 3    WFFULL            RO
         // 2    WFEMPTY           RO
         // 1    RFFULL            RO
         // 0    RFEMPTY           RO
         //
         @(posedge `WB_CLK);
         `TB.master_bfm.write_burst(`SPI_STATUS_REG_ADDRESS, 32'h00C0_0000, 4'h4, 1, 0, err);
         
         //
         // SPER -- Extension Register
         //
         // BIT  Controls          State
         // 7:6  Int Count         00 -- After each transfer
         // 5:2  RESERVED          RO
         // 1:0  ESPR              00 -- Divide WB_CLK by 16 target SPI at 6.25 MHz
         //  
         @(posedge `WB_CLK);
         `TB.master_bfm.write_burst(`SPI_EXTENSION_REG_ADDRESS, 32'h0000_0000, 4'h1, 1, 0, err);
      end
   endtask //
   
   
   task write_single_register;
      input [7:0] address;
      input [7:0] data;

      begin
         `ADXL362_NCS = 1;         
         $display("ADXL362 Write Register REG=0x%x Data=0x%x @ %d", address, data, $time);
         @(posedge `WB_CLK);
         `ADXL362_NCS = 0;
         @(posedge `WB_CLK);
         `TB.master_bfm.write_burst(`SPI_DATA_REG_ADDRESS, {16'h0,`ADXL362_COMMAND_WRITE, 8'h0}, 4'h2, 1, 0, err);         
         @(posedge `WB_CLK);
         `TB.master_bfm.write_burst(`SPI_DATA_REG_ADDRESS, {16'h0, address, 8'h0}, 4'h2, 1, 0, err);
         @(posedge `WB_CLK);
         `TB.master_bfm.write_burst(`SPI_DATA_REG_ADDRESS, {16'h0, data,  8'h0}, 4'h2, 1, 0, err);
         @(posedge `WB_CLK);
         `ADXL362_NCS = 1;         
      end
   endtask //
   
   
   
endmodule // adxl362_tasks
