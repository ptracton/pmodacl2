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
   ncs_o, mosi_o, clk_enable, state_machine_active, spi_active,
   rx_data,
   // Inputs
   miso_i, sclk, clk, rst, enable, start, command, address, tx_data
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
   output wire state_machine_active;
   output wire spi_active;   
   input wire  start;
   input wire [7:0] command;
   input wire [7:0] address;
   input wire [7:0] tx_data;
   output reg [7:0] rx_data;
   

   reg [7:0]        spi_tx_data;   
   reg [2:0]        bit_count;
   reg [2:0]        bit_count_previous;
   assign mosi_o = spi_tx_data[7-bit_count];
   
   wire        spi_byte_done = (bit_count == 0) && (bit_count_previous == 7);
   wire        spi_byte_begin = (bit_count == 1) && (bit_count_previous == 0);
   assign      spi_active = |bit_count;
   
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

   parameter STATE_IDLE = 4'h0;
   parameter STATE_LOWER_NCS = 4'h1;
   parameter STATE_START_TRANSFER_COMMAND = 4'h2;
   parameter STATE_WAIT_TRANSFER_COMMAND_DONE = 4'h3;
   parameter STATE_START_TRANSFER_ADDRESS = 4'h4;
   parameter STATE_WAIT_TRANSFER_ADDRESS_DONE = 4'h5;
   parameter STATE_START_TRANSFER_DATA = 4'h6;
   parameter STATE_WAIT_TRANSFER_DATA_DONE = 4'h7;   
   parameter STATE_RAISE_NCS = 4'h8;
   
   reg [3:0] state;
   reg [3:0] next_state;
   
   assign state_machine_active = (state != STATE_IDLE);
   
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
           spi_tx_data = 0;           
           if (start) begin
              next_state = STATE_LOWER_NCS;              
           end else begin
              next_state = STATE_IDLE;              
           end
        end

        STATE_LOWER_NCS: begin
           ncs_o = 0;
           next_state = STATE_START_TRANSFER_COMMAND;  
           spi_tx_data = command;           
        end

        STATE_START_TRANSFER_COMMAND:begin
           clk_enable = 1;
           next_state = STATE_WAIT_TRANSFER_COMMAND_DONE;           
        end

        STATE_WAIT_TRANSFER_COMMAND_DONE:begin
           if (spi_byte_done) begin
              next_state = STATE_START_TRANSFER_ADDRESS;
              clk_enable = 0;   
              spi_tx_data = address;                      
           end else begin
              next_state = STATE_WAIT_TRANSFER_COMMAND_DONE;              
           end
        end

        STATE_START_TRANSFER_ADDRESS:begin
           clk_enable = 1;
           next_state = STATE_WAIT_TRANSFER_ADDRESS_DONE;           
        end

        STATE_WAIT_TRANSFER_ADDRESS_DONE:begin
           if (spi_byte_done) begin
              next_state = STATE_START_TRANSFER_DATA;
              clk_enable = 0;  
              spi_tx_data = tx_data;                       
           end else begin
              next_state = STATE_WAIT_TRANSFER_ADDRESS_DONE;              
           end
        end        

        STATE_START_TRANSFER_DATA:begin
           clk_enable = 1;
           next_state = STATE_WAIT_TRANSFER_DATA_DONE;           
        end

        STATE_WAIT_TRANSFER_DATA_DONE:begin
           if (spi_byte_done) begin
              next_state = STATE_RAISE_NCS;
              clk_enable = 0;              
           end else begin
              next_state = STATE_WAIT_TRANSFER_DATA_DONE;              
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
