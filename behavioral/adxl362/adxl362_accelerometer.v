//                              -*- Mode: Verilog -*-
// Filename        : adxl362_accelerometer.v
// Description     : ADXL362 Accelerometer Module
// Author          : Philip Tracton
// Created On      : Thu Jun 23 20:53:26 2016
// Last Modified By: Philip Tracton
// Last Modified On: Thu Jun 23 20:53:26 2016
// Update Count    : 0
// Status          : Unknown, Use with caution!

module adxl362_accelerometer (/*AUTOARG*/
   // Outputs
   rising_clk_odr, fifo_write, fifo_write_data, xdata, ydata, zdata,
   temperature,
   // Inputs
   clk_16mhz, clk_odr, fifo_mode, fifo_temp
   ) ;

   parameter XDATA_FILE = "xdata.txt";
   parameter YDATA_FILE = "ydata.txt";
   parameter ZDATA_FILE = "zdata.txt";
   parameter TEMPERATURE_FILE = "temp_data.txt";
   parameter MEMORY_DEPTH = 16;

   
   input wire clk_16mhz;
   input wire clk_odr;
   input wire [1:0] fifo_mode; 
   input wire       fifo_temp;

   output wire      rising_clk_odr;   
   output reg fifo_write;
   output reg [15:0] fifo_write_data;
   output wire [11:0] xdata;
   output wire [11:0] ydata;
   output wire [11:0] zdata;
   output wire [11:0] temperature;
   
   integer           x = 0;
   integer           y = 0;
   integer           z = 0;
   integer           temp = 0;
   

   reg [11:0]        xdata_memory [MEMORY_DEPTH-1:0];
   reg [11:0]        ydata_memory [MEMORY_DEPTH-1:0];
   reg [11:0]        zdata_memory [MEMORY_DEPTH-1:0];
   reg [11:0]        temperature_memory [MEMORY_DEPTH-1:0];

   initial begin
      $readmemh(XDATA_FILE, xdata_memory);
      $readmemh(YDATA_FILE, ydata_memory);
      $readmemh(ZDATA_FILE, zdata_memory);
      $readmemh(TEMPERATURE_FILE, temperature_memory);
   end
   
   assign temperature = temperature_memory[temp];
   assign xdata = xdata_memory[x];
   assign ydata = ydata_memory[y];
   assign zdata = zdata_memory[z];
   always @(posedge clk_odr) begin
      x <= x + 1;
      y <= y + 1;
      z <= z + 1;
      temp <= temp + 1;      
   end

   reg previous;
   assign rising_clk_odr = (previous == 0) & (clk_odr == 1);
   always @(posedge clk_16mhz) begin
      previous <= clk_odr;  //Generally a bad idea, but we are not going for synthesis      
   end

   
   parameter STATE_IDLE                   = 4'h0;
   parameter STATE_WRITE_X                = 4'h1;
   parameter STATE_WRITE_X_DONE           = 4'h2;
   parameter STATE_WRITE_Y                = 4'h3;
   parameter STATE_WRITE_Y_DONE           = 4'h4;
   parameter STATE_WRITE_Z                = 4'h5;
   parameter STATE_WRITE_Z_DONE           = 4'h6;
   parameter STATE_WRITE_TEMPERATURE      = 4'h7;
   parameter STATE_WRITE_TEMPERATURE_DONE = 4'h8;
   
   reg [3:0] state = STATE_IDLE;
   reg [3:0] next_state = STATE_IDLE;

   always @(posedge clk_16mhz) begin
      state <= next_state;      
   end

   always @(*)begin
      case (state)
        STATE_IDLE: begin
           fifo_write = 0;
           fifo_write_data = 0;
           if (rising_clk_odr & |fifo_mode) begin
              next_state = STATE_WRITE_X;              
           end else begin
              next_state = STATE_IDLE;              
           end
        end // case: STATE_IDLE

        STATE_WRITE_X:begin
           fifo_write_data[15:14] = 2'b00;
           fifo_write_data[13:0] = {xdata[11], xdata[11], xdata};
           fifo_write = 1;
           next_state = STATE_WRITE_X_DONE;           
        end

        STATE_WRITE_X_DONE:begin
           fifo_write = 0;
           next_state = STATE_WRITE_Y;           
        end

        STATE_WRITE_Y:begin
           fifo_write_data[15:14] = 2'b01;
           fifo_write_data[13:0] = {ydata[11], ydata[11], ydata};
           fifo_write = 1;
           next_state = STATE_WRITE_Y_DONE;           
        end

        STATE_WRITE_Y_DONE:begin
           fifo_write = 0;
           next_state = STATE_WRITE_Z;           
        end

        STATE_WRITE_Z:begin
           fifo_write_data[15:14] = 2'b10;
           fifo_write_data[13:0] = {zdata[11], zdata[11], zdata};
           fifo_write = 1;
           next_state = STATE_WRITE_Z_DONE;           
        end

        STATE_WRITE_Z_DONE:begin
           fifo_write = 0;
           if (fifo_temp) begin
              next_state = STATE_WRITE_TEMPERATURE;              
           end else begin
              next_state = STATE_IDLE;
           end
        end

        STATE_WRITE_TEMPERATURE:begin
           fifo_write_data[15:14] = 2'b11;
           fifo_write_data[13:0] = {temperature[11], temperature[11], temperature};
           fifo_write = 1;
           next_state = STATE_WRITE_TEMPERATURE_DONE;           
        end

        STATE_WRITE_TEMPERATURE_DONE:begin
           fifo_write = 0;
           next_state = STATE_IDLE;           
        end        

        default: begin
           next_state = STATE_IDLE;           
        end
      endcase
   end
   
endmodule // adxl362_accelerometer
