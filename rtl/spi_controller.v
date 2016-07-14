//                              -*- Mode: Verilog -*-
// Filename        : spi_controller.v
// Description     : State Machine to control SPI interface
// Author          : Philip Tracton
// Created On      : Fri Jul  8 20:59:53 2016
// Last Modified By: Philip Tracton
// Last Modified On: Fri Jul  8 20:59:53 2016
// Update Count    : 0
// Status          : Unknown, Use with caution!
module spi_controller (/*AUTOARG*/
   // Outputs
   rx_read, tx_write, tx_data, start,
   // Inputs
   clk, rst, rx_data, rx_full, rx_empty, tx_empty, tx_full, active
   ) ;
   input wire clk;
   input wire rst;

   //
   // RX FIFO
   //
   output wire rx_read;   
   input wire [7:0] rx_data;
   input wire       rx_full;
   input wire       rx_empty;
   
   //
   // TX FIFO
   //
   output wire  tx_write;
   output reg [7:0] tx_data;
   input wire   tx_empty;
   input wire   tx_full;

   //
   // SPI Interface
   //
   input wire   active;
   output reg   start;


   parameter STATE_IDLE          = 3'h0;
   parameter STATE_SEND_COMMAND = 3'h1;
   parameter STATE_WAIT_COMMAND = 3'h2;
   parameter STATE_SEND_ADDRESS = 3'h3;
   parameter STATE_WAIT_ADDRESS = 3'h4;
   parameter STATE_SEND_READ    = 3'h5;
   parameter STATE_WAIT_READ    = 3'h6;
   parameter STATE_END          = 3'h7;
   
   reg [2:0]    state;
   reg [2:0]    next_state;
   reg [31:0]   count;
   wire         count_done;
   reg [7:0]    address;
   reg          first;
   
   assign count_done = (count == 32'd1000);
   
   always @(posedge clk)
     if (rst) begin
        count <=0;        
     end else begin
        if (count_done) begin
           count <=0;           
        end else begin
           count <= count +1;           
        end
     end
   
   always @(posedge clk)
     if (rst) begin
        state <= STATE_IDLE;        
     end else begin
        state <= next_state;        
     end

   always @(*) begin
      case (state)
        STATE_IDLE: begin
           start = 0;
           tx_data = 0; 
           address = 8'h14;
           first = 1;           
           if (count_done) begin
              next_state = STATE_SEND_COMMAND;              
           end else begin
              next_state = STATE_IDLE;              
           end
        end

        STATE_SEND_COMMAND:begin
           start = 1;
           tx_data = 8'h0B;  // Read Command
           next_state = STATE_WAIT_COMMAND;           
        end

        STATE_WAIT_COMMAND:begin
           if (active) begin
              start = 0;           
              next_state = STATE_WAIT_COMMAND;              
           end else begin
              next_state = STATE_SEND_ADDRESS;              
           end
        end

        STATE_SEND_ADDRESS:begin
           start = 1;           
           tx_data = address;
           next_state = STATE_WAIT_ADDRESS;           
        end

        STATE_WAIT_ADDRESS:begin
           if (active) begin
              start = 0;           
              next_state = STATE_WAIT_ADDRESS;              
           end else begin
              next_state = STATE_SEND_READ;              
           end           
        end

        STATE_SEND_READ:begin
           start = 1;           
           tx_data = 0;
           next_state = STATE_WAIT_READ;            
        end

        STATE_WAIT_READ:begin
           if (active) begin
              start = 0;           
              next_state = STATE_WAIT_READ;              
           end else begin
              next_state = STATE_END;              
           end                      
        end        

        STATE_END:begin
        end
        
        default: begin
           next_state = STATE_IDLE;           
        end
      endcase // case (state)
      
   end
     
endmodule // spi_controller
