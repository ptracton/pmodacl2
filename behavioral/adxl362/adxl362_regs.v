//                              -*- Mode: Verilog -*-
// Filename        : adxl362_regs.v
// Description     : ADXL362 Registers
// Author          : Philip Tracton
// Created On      : Thu Jun 23 20:02:46 2016
// Last Modified By: Philip Tracton
// Last Modified On: Thu Jun 23 20:02:46 2016
// Update Count    : 0
// Status          : Unknown, Use with caution!


`include "adxl362_registers.vh"

module adxl362_regs (/*AUTOARG*/
   // Outputs
   data_read, threshold_active, time_active, threshold_inactive,
   time_inactive, act_inact_ctrl, fifo_ctrl, fifo_samples, intmap1,
   intmap2, filter_ctrl, power_ctrl, self_test,
   // Inputs
   clk_sys, write, address, data_write, xdata, ydata, zdata,
   temperature, status
   ) ;

   input wire clk_sys;   
   input wire write;
   input wire [5:0] address;
   input wire [7:0] data_write;
   output reg [7:0] data_read;

   output reg [10:0] threshold_active =0;
   output reg [7:0]  time_active = 0;
   output reg [10:0] threshold_inactive = 0;
   output reg [15:0] time_inactive =0;   
   output reg [7:0]  act_inact_ctrl = 0;
   output reg [3:0]  fifo_ctrl = 0;
   output reg [7:0]  fifo_samples = 8'h80;
   output reg [7:0]  intmap1 = 0;
   output reg [7:0]  intmap2 = 0;
   output reg [7:0]  filter_ctrl = 8'h13;
   output reg [7:0]  power_ctrl = 0;
   output reg        self_test = 0;

   input wire [11:0] xdata;
   input wire [11:0] ydata;
   input wire [11:0] zdata;
   input wire [11:0] temperature;
   input wire [7:0]  status;
   
   
   //
   // Read from the registers
   //
   always @(*) begin
      case (address)
        `ADXL362_DEVID_AD:  data_read = 8'hAD;  
        `ADXL362_DEVID_MST: data_read = 8'h1D;
        `ADXL362_PARTID:    data_read = 8'hF2;
        `ADXL362_REVID:     data_read = 8'h01; 
        `ADXL362_XDATA:     data_read = xdata[11:3];
        `ADXL362_YDATA:     data_read = ydata[11:3];
        `ADXL362_ZDATA:     data_read = zdata[11:3];
        `ADXL362_STATUS:    data_read = status;
        `ADXL362_FIFO_ENTRIES_LOW: data_read = 0;
        `ADXL362_FIFO_ENTRIES_HIGH: data_read = 0;
        `ADXL362_XDATA_LOW:  data_read = xdata[7:0];
        `ADXL362_XDATA_HIGH: data_read = {4'h0, xdata[11:8]};
        `ADXL362_YDATA_LOW:  data_read = ydata[7:0];
        `ADXL362_YDATA_HIGH: data_read = {4'h0, ydata[11:8]};
        `ADXL362_ZDATA_LOW:  data_read = zdata[7:0];
        `ADXL362_ZDATA_HIGH: data_read = {4'h0, zdata[11:8]};
        `ADXL362_TEMP_LOW:   data_read = temperature[7:0];
        `ADXL362_TEMP_HIGH:  data_read  = {4'h0, temperature[11:8]};
        `ADXL362_SOFT_RESET: data_read  = 0;
        `ADXL362_THRESH_ACT_LOW: data_read =  threshold_active[07:00];
        `ADXL362_THRESH_ACT_HIGH: data_read =  threshold_active[10:08];
        `ADXL362_TIME_ACT:   data_read = time_active;
        `ADXL362_THRESH_INACT_LOW: data_read =  threshold_inactive[07:00];
        `ADXL362_THRESH_INACT_HIGH: data_read = threshold_inactive[10:08];
        `ADXL362_TIME_INACT_LOW: data_read = time_inactive[7:0];
        `ADXL362_TIME_INACT_HIGH: data_read = time_inactive[15:08];
        `ADXL362_ACT_INACT_CTL: data_read = 0;
        `ADXL362_FIFO_CONTROL: data_read = fifo_ctrl;
        `ADXL362_FIFO_SAMPLES: data_read = fifo_samples;
        `ADXL362_INTMAP1: data_read = intmap1;
        `ADXL362_INTMAP2: data_read = intmap2;
        `ADXL362_FILTER_CTL: data_read =filter_ctrl;
        `ADXL362_POWER_CTL: data_read = power_ctrl;
        `ADXL362_SELF_TEST: data_read ={7'b0, self_test};
        default: data_read = 0;        
      endcase // case (address)      
   end
    
   //
   // Write to the registers
   //
   //   always @(posedge write) begin
   always @(posedge clk_sys) begin
      if (write) begin
         case (address)
           `ADXL362_THRESH_ACT_LOW:    threshold_active[07:00] = data_write;        
           `ADXL362_THRESH_ACT_HIGH:   threshold_active[10:08] = data_write[2:0];
           `ADXL362_TIME_ACT:          time_active[07:00] = data_write;
           `ADXL362_THRESH_INACT_LOW:  threshold_inactive[07:00] = data_write;
           `ADXL362_THRESH_INACT_HIGH: threshold_inactive[10:08] = data_write[2:0]; 
           `ADXL362_TIME_INACT_LOW:    time_inactive[7:0] = data_write;
           `ADXL362_TIME_INACT_HIGH:   time_inactive[15:8] = data_write;
           `ADXL362_FIFO_CONTROL:      fifo_ctrl = data_write;
           `ADXL362_FIFO_SAMPLES:      fifo_samples= data_write;
           `ADXL362_INTMAP1:           intmap1 = data_write;
           `ADXL362_INTMAP2:           intmap2 = data_write;
           `ADXL362_FILTER_CTL:        filter_ctrl = data_write;
           `ADXL362_POWER_CTL:         power_ctrl = data_write;
           `ADXL362_SELF_TEST:         self_test = data_write[0];        
          endcase // case (address)
      end else begin // if (write)
         
      end
   end // always @ (posedge clk)   
   
endmodule // adxl362_regs
