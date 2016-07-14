//                              -*- Mode: Verilog -*-
// Filename        : spi.v
// Description     : Simple SPI Module
// Author          : Philip Tracton
// Created On      : Fri Jul  8 20:42:13 2016
// Last Modified By: Philip Tracton
// Last Modified On: Fri Jul  8 20:42:13 2016
// Update Count    : 0
// Status          : Unknown, Use with caution!

module spi (/*AUTOARG*/
   // Outputs
   ncs_o, mosi_o, clk_enable, active, rx_data, rx_full, rx_empty,
   tx_empty, tx_full,
   // Inputs
   miso_i, sclk, clk, rst, enable, start, rx_read, tx_write, tx_data
   ) ;

   //
   // SPI Side Interface
   //
   output reg ncs_o;
   output wire mosi_o;
   input  wire miso_i;
   input wire  sclk;
   
   //
   // Host Side Interface
   //
   input wire  clk;
   input wire  rst;
   input wire  enable;
   output reg  clk_enable = 0;
   output wire active;
   input wire  start;
   
   
   //
   // RX FIFO
   //
   input wire  rx_read;   
   output reg [7:0] rx_data;
   output wire       rx_full;
   output wire       rx_empty;
   
   //
   // TX FIFO
   //
   input wire  tx_write;
   input wire [7:0] tx_data;
   output wire tx_empty;
   output wire tx_full;

   reg [2:0]   bit_count;
   reg [2:0]   bit_count_previous;
   assign mosi_o = tx_data[7-bit_count];

   wire        spi_byte_done = (bit_count == 0) && (bit_count_previous == 7);
   wire        spi_byte_begin = (bit_count == 1) && (bit_count_previous == 0);
   
   always @(posedge sclk or posedge rst)
     if (rst) begin
        bit_count <= 0;
        rx_data <= 0;  
        bit_count_previous <= 0;        
     end else begin
        bit_count <= bit_count + 1;
        bit_count_previous <= bit_count;        
        rx_data[7-bit_count] <= miso_i;        
     end

   parameter STATE_IDLE = 3'h0;
   parameter STATE_LOWER_NCS = 3'h1;
   parameter STATE_START_TRANSFER = 3'h2;
   parameter STATE_WAIT_TRANSFER_DONE = 3'h3;
   parameter STATE_RAISE_NCS = 3'h4;
   
   reg [2:0] state;
   reg [2:0] next_state;
   assign active = (state != STATE_IDLE);
   
   always @(posedge clk)
     if (rst) begin
        state <= STATE_IDLE;        
     end else begin
        state <= next_state;        
     end

   always @(*) begin
      case (state)

        STATE_IDLE: begin
           ncs_o = 1;
           clk_enable = 0;           
           if (start) begin
              next_state = STATE_LOWER_NCS;              
           end else begin
              next_state = STATE_IDLE;              
           end
        end

        STATE_LOWER_NCS: begin
           ncs_o = 0;
           next_state = STATE_START_TRANSFER;           
        end

        STATE_START_TRANSFER:begin
           clk_enable = 1;
           next_state = STATE_WAIT_TRANSFER_DONE;           
        end

        STATE_WAIT_TRANSFER_DONE:begin
           if (spi_byte_done) begin
              next_state = STATE_RAISE_NCS;
              clk_enable = 0;              
           end else begin
              next_state = STATE_WAIT_TRANSFER_DONE;              
           end
        end

        STATE_RAISE_NCS:begin
           ncs_o = 1;
           next_state = STATE_IDLE;           
        end
        
        default: next_state = STATE_IDLE;
        
      endcase // case (state)
      
   end
   
endmodule // spi
