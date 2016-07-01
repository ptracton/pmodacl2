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
         // 7    Interrupt Enable  1
         // 6    Peripheral Enable 1
         // 5    RESERVED          0
         // 4    Master            1
         // 3    CPOL              0
         // 2    CPHA              0 
         // 1:0  SPR               10  -- Divide WB_CLK by 16 target SPI at 6.25 MHz
         // 
         //
         @(posedge `WB_CLK);
         `TB.master_bfm.write_burst(`SPI_CONTROL_REG_ADDRESS, 32'hD200_0000, 4'h8, 1, 0, err);
         
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
         @(posedge `WB_CLK);
         `ADXL362_NCS = 1;         
         $display("ADXL362 Write Register REG=0x%x Data=0x%x @ %d", address, data, $time);
         @(posedge `WB_CLK);
         `ADXL362_NCS = 0;
         
         @(posedge `WB_CLK);
         `TB.master_bfm.write_burst(`SPI_DATA_REG_ADDRESS, {16'h0,`ADXL362_COMMAND_WRITE, 8'h0}, 4'h2, 1, 0, err);         
         @(posedge `SIMPLE_SPI_IRQ);
         `TB.master_bfm.write_burst(`SPI_STATUS_REG_ADDRESS, 32'h0080_0000, 4'h4, 1, 0, err);
         `TB.master_bfm.read_burst(`SPI_DATA_REG_ADDRESS, data_out, 4'h2, 1, 0, err);
         
         @(posedge `WB_CLK);
         `TB.master_bfm.write_burst(`SPI_DATA_REG_ADDRESS, {16'h0, address, 8'h0}, 4'h2, 1, 0, err);
         @(posedge `SIMPLE_SPI_IRQ);
         `TB.master_bfm.write_burst(`SPI_STATUS_REG_ADDRESS, 32'h0080_0000, 4'h4, 1, 0, err);
         `TB.master_bfm.read_burst(`SPI_DATA_REG_ADDRESS, data_out, 4'h2, 1, 0, err);
         
         @(posedge `WB_CLK);
         `TB.master_bfm.write_burst(`SPI_DATA_REG_ADDRESS, {16'h0, data,  8'h0}, 4'h2, 1, 0, err);
         @(posedge `SIMPLE_SPI_IRQ);
         `TB.master_bfm.write_burst(`SPI_STATUS_REG_ADDRESS, 32'h0080_0000, 4'h4, 1, 0, err);
         `TB.master_bfm.read_burst(`SPI_DATA_REG_ADDRESS, data_out, 4'h2, 1, 0, err);
         
         repeat(2) @(posedge `WB_CLK);
         `ADXL362_NCS = 1;
         repeat(5)  @(posedge `WB_CLK);
      end
   endtask //

   task write_double_register;
      input [7:0] address;
      input [15:0] data;
      begin
         write_single_register(address,   data[07:00]);
         write_single_register(address+1, data[15:08]);
      end
   endtask // write_burst
   

   task write_burst_registers;
      input [7:0] address;
      input [(512*7):0] data;
      input [31:0] count;
      integer      ii;
      
      begin
     @(posedge `WB_CLK);
         `ADXL362_NCS = 1;         
         $display("ADXL362 Write Register REG=0x%x Count=0x%x @ %d", address, count, $time);
         @(posedge `WB_CLK);
         `ADXL362_NCS = 0;
         
         @(posedge `WB_CLK);
         `TB.master_bfm.write_burst(`SPI_DATA_REG_ADDRESS, {16'h0,`ADXL362_COMMAND_WRITE, 8'h0}, 4'h2, 1, 0, err);         
         @(posedge `SIMPLE_SPI_IRQ);
         `TB.master_bfm.write_burst(`SPI_STATUS_REG_ADDRESS, 32'h0080_0000, 4'h4, 1, 0, err);
         `TB.master_bfm.read_burst(`SPI_DATA_REG_ADDRESS, data_out, 4'h2, 1, 0, err);
         
         @(posedge `WB_CLK);
         `TB.master_bfm.write_burst(`SPI_DATA_REG_ADDRESS, {16'h0, address, 8'h0}, 4'h2, 1, 0, err);
         @(posedge `SIMPLE_SPI_IRQ);
         `TB.master_bfm.write_burst(`SPI_STATUS_REG_ADDRESS, 32'h0080_0000, 4'h4, 1, 0, err);
         `TB.master_bfm.read_burst(`SPI_DATA_REG_ADDRESS, data_out, 4'h2, 1, 0, err);

         for (ii=0; ii<count; ii=ii+1) begin
            //@(posedge `WB_CLK);
            `TB.master_bfm.write_burst(`SPI_DATA_REG_ADDRESS, {16'h0, data[(ii*8)+7 -: 8],  8'h0}, 4'h2, 1, 0, err);
            @(posedge `SIMPLE_SPI_IRQ);
            `TB.master_bfm.write_burst(`SPI_STATUS_REG_ADDRESS, 32'h0080_0000, 4'h4, 1, 0, err);
            `TB.master_bfm.read_burst(`SPI_DATA_REG_ADDRESS, data_out, 4'h2, 1, 0, err);
            
         end

         @(posedge `WB_CLK);
         `ADXL362_NCS = 1;
         repeat(5)  @(posedge `WB_CLK);
         
      end
   endtask // write_burst
   
   
   task read_single_register;
      input [7:0] address;
      output [31:0] data;
      
      begin

         //
         // Start CS
         //
         @(posedge `WB_CLK);
         `ADXL362_NCS = 0;

         //
         // Write the READ Command the ADXL362
         //
         @(posedge `WB_CLK);
         `TB.master_bfm.write_burst(`SPI_DATA_REG_ADDRESS, {16'h0,`ADXL362_COMMAND_READ, 8'h0}, 4'h2, 1, 0, err);         
         @(posedge `SIMPLE_SPI_IRQ);
         `TB.master_bfm.write_burst(`SPI_STATUS_REG_ADDRESS, 32'h0080_0000, 4'h4, 1, 0, err);
         `TB.master_bfm.read_burst(`SPI_DATA_REG_ADDRESS, data, 4'h2, 1, 0, err);


         //
         // Write out the ADDRESS to the ADXL362
         //
         @(posedge `WB_CLK);
         
         `TB.master_bfm.write_burst(`SPI_DATA_REG_ADDRESS, {16'h0, address, 8'h0}, 4'h2, 1, 0, err);
         @(posedge `SIMPLE_SPI_IRQ);
         `TB.master_bfm.write_burst(`SPI_STATUS_REG_ADDRESS, 32'h0080_0000, 4'h4, 1, 0, err);
         `TB.master_bfm.read_burst(`SPI_DATA_REG_ADDRESS, data, 4'h2, 1, 0, err);

         //
         // Read data from ADXL 362
         //
         @(posedge `WB_CLK);
         `TB.master_bfm.write_burst(`SPI_DATA_REG_ADDRESS, 32'h0000_0000, 4'h2, 1, 0, err);
         @(posedge `SIMPLE_SPI_IRQ);
         `TB.master_bfm.write_burst(`SPI_STATUS_REG_ADDRESS, 32'h0080_0000, 4'h4, 1, 0, err);
         `TB.master_bfm.read_burst(`SPI_DATA_REG_ADDRESS, data, 4'h2, 1, 0, err);
                
         //$display("ADXL362 Read Register REG=0x%x Data=0x%x @ %d", address, data, $time);

         //
         // End CS
         //
         repeat(2) @(posedge `WB_CLK);
         `ADXL362_NCS = 1;
         repeat(5)  @(posedge `WB_CLK);
      end
   endtask //

   task read_burst_registers;
      input [7:0] address;
      output [(16*7):0] data;
      input [31:0] count;
      integer      ii;
      
      begin
     @(posedge `WB_CLK);
         `ADXL362_NCS = 1;         
         $display("ADXL362 Read Register REG=0x%x Count=0x%x @ %d", address, count, $time);
         @(posedge `WB_CLK);
         `ADXL362_NCS = 0;
         
         @(posedge `WB_CLK);
         `TB.master_bfm.write_burst(`SPI_DATA_REG_ADDRESS, {16'h0,`ADXL362_COMMAND_READ, 8'h0}, 4'h2, 1, 0, err);         
         @(posedge `SIMPLE_SPI_IRQ);
         `TB.master_bfm.write_burst(`SPI_STATUS_REG_ADDRESS, 32'h0080_0000, 4'h4, 1, 0, err);
         `TB.master_bfm.read_burst(`SPI_DATA_REG_ADDRESS, data_out, 4'h2, 1, 0, err);
         
         @(posedge `WB_CLK);
         `TB.master_bfm.write_burst(`SPI_DATA_REG_ADDRESS, {16'h0, address, 8'h0}, 4'h2, 1, 0, err);
         @(posedge `SIMPLE_SPI_IRQ);
         `TB.master_bfm.write_burst(`SPI_STATUS_REG_ADDRESS, 32'h0080_0000, 4'h4, 1, 0, err);
         `TB.master_bfm.read_burst(`SPI_DATA_REG_ADDRESS, data_out, 4'h2, 1, 0, err);

         for (ii=0; ii<count; ii=ii+1) begin
            @(posedge `WB_CLK);
            `TB.master_bfm.write_burst(`SPI_DATA_REG_ADDRESS, 0, 4'h2, 1, 0, err);
            @(posedge `SIMPLE_SPI_IRQ);
            `TB.master_bfm.write_burst(`SPI_STATUS_REG_ADDRESS, 32'h0080_0000, 4'h4, 1, 0, err);
           // `TB.master_bfm.read_burst(`SPI_DATA_REG_ADDRESS, data[(ii*8)+7 -: 8], 4'h2, 1, 0, err);
//            $display("Read %d Mem = 0x%x @ %d", ii,  data[(ii*8)+7 -: 8], $time);                        
            `TB.master_bfm.read_burst(`SPI_DATA_REG_ADDRESS, data_out, 4'h2, 1, 0, err);
//            $display("Read %d Mem = 0x%x @ %d", ii,  data_out, $time); 
            data[(ii*8)+7 -: 8] = data_out[15:8];           

         end

         @(posedge `WB_CLK);         
         `ADXL362_NCS = 1;
         repeat(5)  @(posedge `WB_CLK);
         
      end
   endtask // write_burst
   
   task check_single_register;
      input [7:0] address;
      input [7:0] expected;
      reg [31:0]  data;
      
      begin
         read_single_register(address, data);
         `TEST_COMPARE("Compare Register", expected, data[15:08]);         
      end      
   endtask //
  
   task check_double_register;
      input [7:0] address;
      input [15:0] expected;
      reg [31:0]  data_low;
      reg [31:0]  data_high;
      
      begin
         read_single_register(address,   data_low);
         read_single_register(address+1, data_high);
         `TEST_COMPARE("Compare Register", expected, {data_high[15:08], data_low[15:08]});         
      end      
   endtask // 
   
endmodule // adxl362_tasks
