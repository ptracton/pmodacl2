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
   spi_tx_data, start, ncs_o, clk_enable, temperature,
   // Inputs
   clk, rst, spi_rx_data, spi_byte_done, spi_byte_begin, bit_count,
   state_machine_active
   ) ;

   //
   // System Interface
   //
   input wire clk;
   input wire rst;

   output reg [7:0] spi_tx_data;
   input wire [7:0] spi_rx_data;
   input wire       spi_byte_done;
   input wire       spi_byte_begin;
   
   //
   // SPI Interface
   //
   input wire [2:0] bit_count;
   input wire       state_machine_active;   
   output reg       start;
   output reg       ncs_o;
   output reg       clk_enable;
   output reg [15:0]       temperature =0;
   
   parameter STATE_IDLE         = 4'h0;
   parameter STATE_SEND_COMMAND = 4'h1;
   parameter STATE_WAIT_COMMAND = 4'h2;
   parameter STATE_SEND_ADDRESS = 4'h3;
   parameter STATE_WAIT_ADDRESS = 4'h4;
   parameter STATE_SEND_READ    = 4'h5;
   parameter STATE_WAIT_READ    = 4'h6;
   parameter STATE_RAISE_NCS    = 4'h7;   
   parameter STATE_END          = 4'h8;
   
   reg [3:0]    state;
   reg [3:0]    next_state;
   reg [31:0]   count;
   wire         count_done;
   reg          first;
   reg          clk_enable_async;
   reg [7:0]    address;
   reg [2:0]    delay_count;
   
   assign count_done = (count == 32'd10000);

   always @(posedge clk)
     if (rst) begin
        delay_count <= 0;        
     end else if (state == STATE_RAISE_NCS) begin
        delay_count <= delay_count + 1;        
     end else begin
        delay_count <= 0;        
     end
   
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

   always @(posedge clk)
     clk_enable <= clk_enable_async;   
   
   always @(*) begin
      case (state)
        STATE_IDLE: begin
           start = 0;
           spi_tx_data = 0;
           address = 8'h14;           
           first = 1;
           ncs_o = 1;     
           clk_enable_async = 0;           
           if (count_done) begin
              clk_enable_async = 1;              
              next_state = STATE_SEND_COMMAND;
           end else begin
              next_state = STATE_IDLE;              
           end
        end

        STATE_SEND_COMMAND:begin
           ncs_o = 0;           
           start = 1;
           clk_enable_async = 1;  
           spi_tx_data = 8'h0B;  // Read Command
           if (bit_count == 1) begin
              next_state = STATE_WAIT_COMMAND;  
           end else begin
              next_state = STATE_SEND_COMMAND;  
           end
        end

        STATE_WAIT_COMMAND:begin
           if (bit_count == 0) begin
              start = 0;           
              next_state = STATE_SEND_ADDRESS;              
           end else begin
              next_state = STATE_WAIT_COMMAND;              
           end
        end

        STATE_SEND_ADDRESS:begin
           start = 1;
           spi_tx_data = address;
           if (bit_count == 1) begin
              next_state = STATE_WAIT_ADDRESS;
           end else begin
              next_state = STATE_SEND_ADDRESS;
           end
        end

        STATE_WAIT_ADDRESS:begin
           if (bit_count == 0) begin
              start = 0;           
              next_state = STATE_SEND_READ;              
           end else begin
              next_state = STATE_WAIT_ADDRESS;              
           end           
        end

        STATE_SEND_READ:begin
           start = 1;           
           spi_tx_data = 0;
           if (bit_count == 1) begin
              next_state = STATE_WAIT_READ;
           end else begin
              next_state = STATE_SEND_READ;
           end
        end

        STATE_WAIT_READ:begin
           if (bit_count == 7) begin
              start = 0;           
              next_state = STATE_RAISE_NCS;              
           end else begin
              next_state = STATE_WAIT_READ;              
           end                      
        end        

        STATE_RAISE_NCS:begin
           ncs_o = 1;
           clk_enable_async = 0;
           if (&delay_count) begin
              next_state = STATE_END;              
           end else begin
              next_state = STATE_RAISE_NCS;              
           end
        end
        
        STATE_END:begin
           if (first) begin
              first = 0;
              address = address + 1;              
              next_state = STATE_SEND_COMMAND;
              temperature[7:0] = spi_rx_data;              
           end else begin
              next_state = STATE_IDLE;
              temperature[15:08] = spi_rx_data;              
           end
        end
        
                
        default: begin
           next_state = STATE_IDLE;           
        end
      endcase // case (state)
      
   end

  reg [(40*8)-1:0] spi_controller_state_name ="NONE";
   always @(*)
     case (state)
       STATE_IDLE         : spi_controller_state_name = "IDLE";
       STATE_SEND_COMMAND : spi_controller_state_name = "SEND COMMAND";
       STATE_WAIT_COMMAND : spi_controller_state_name = "WAIT COMMAND";
       STATE_SEND_ADDRESS : spi_controller_state_name = "SEND ADDRESS";
       STATE_WAIT_ADDRESS : spi_controller_state_name = "WAIT ADDRESS";
       STATE_SEND_READ    : spi_controller_state_name = "SEND READ";
       STATE_WAIT_READ    : spi_controller_state_name = "WAIT READ";
       STATE_RAISE_NCS    : spi_controller_state_name = "RAISE NCS";
       STATE_END          : spi_controller_state_name = "END";
       default: spi_controller_state_name = "Default";       
     endcase // case (state)
   
endmodule // spi_controller
