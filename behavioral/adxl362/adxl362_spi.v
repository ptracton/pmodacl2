//                              -*- Mode: Verilog -*-
// Filename        : adxl362_spi.v
// Description     : SPI Slave Interface for ADXL362
// Author          : Philip Tracton
// Created On      : Wed Jun 22 21:33:25 2016
// Last Modified By: Philip Tracton
// Last Modified On: Wed Jun 22 21:33:25 2016
// Update Count    : 0
// Status          : Unknown, Use with caution!

`include "adxl362_registers.vh"

module adxl362_spi (/*AUTOARG*/
   // Outputs
   MISO, address, data_write, data_fifo_write, write, read_data_fifo,
   // Inputs
   SCLK, MOSI, nCS, clk_sys, data_read, data_fifo_read, rst
   ) ;
   input wire SCLK;
   input wire MOSI;
   input wire nCS;
   output reg MISO;
   input wire clk_sys;
   
   output reg [5:0] address;
   output reg [7:0] data_write;
   input wire [7:0] data_read;
   input wire [15:0] data_fifo_read;  
   output reg       data_fifo_write;   
   output reg       write;
   input wire       rst;
   output reg       read_data_fifo;
      
   /*AUTOWIRE*/

   /*AUTOREG*/

   reg [7:0]       spi_data_in = 0;
   reg [7:0]       spi_data_out =0 ;   
   reg [2:0]       bit_count =0;
   reg [2:0]       bit_count_previous =0;
   reg [7:0]       command =0;
   reg             read_fifo = 0;
   wire [7:0]      data_rd;
   reg             flush_fifo = 0;   
   wire            flush = flush_fifo ;//| (nCS == 1);
   reg             write_fifo =0;   
   wire            empty_fifo;                  // From fifo of adxl362_fifo.v
   wire            full_fifo;                   // From fifo of adxl362_fifo.v
   
   //
   // Capture SPI data coming in.  The spec says this IC is always CPHA = 0 and CPOL = 0
   // so we can get away with this very simple solution.
   //
   reg [7:0]       running_bit_count  =0;
   
   always @(posedge SCLK or posedge nCS)
     if (nCS) begin
        bit_count <= 0;
        bit_count_previous <= 7;        
        spi_data_in <= 0;
        MISO <= 0;        
     end else begin
        bit_count_previous <= bit_count;        
        bit_count <= bit_count + 1;
        running_bit_count <= running_bit_count + 1;        
        spi_data_in <= {spi_data_in[6:0], MOSI};
        MISO <= spi_data_out[7-bit_count];
//        MISO <= (`ADXL362_COMMAND_READ==command) ? data_read[7-bit_count] : data_rd[7-bit_count];
     end

//
//   wire spi_byte_done = (bit_count == 0) && (bit_count_previous == 7);
//   wire spi_byte_begin = (bit_count == 1) && (bit_count_previous == 0);
   
   wire spi_byte_done =  (bit_count == 7);
   wire spi_byte_begin = (bit_count == 0);
   
   //
   // Detect the edge and pulse write for a single clock while we
   // are not flushing the FIFO
   //
   reg [2:0] wr_state;
   reg [2:0] wr_next_state;
   parameter WR_IDLE  = 3'h0;
   parameter WR_WRITE = 3'h1;
   parameter WR_DONE  = 3'h2;
   
   always @(posedge clk_sys)  begin
      wr_state <= wr_next_state;      
   end

   always @(*)
     case (wr_state)
       WR_IDLE: begin
          write_fifo = 0;
          if ((bit_count == 0) && (bit_count_previous == 7)) begin
             wr_next_state = WR_WRITE;             
          end else begin
             wr_next_state = WR_IDLE;             
          end
       end

       WR_WRITE: begin
          write_fifo = 1;
          wr_next_state = WR_DONE;          
       end

       WR_DONE:begin
          write_fifo = 0;
          wr_next_state = WR_IDLE;
       end
       default:
         wr_next_state = WR_IDLE;              
     endcase // case (state)   

   adxl362_fifo #(.WIDTH(8),.DEPTH(8))
   fifo (
         // Outputs
         .data_read        (data_rd),
         .full             (full_fifo),
         .empty            (empty_fifo),
         // Inputs
         .data_write       (spi_data_in),
         .clk              (clk_sys),
         .rst              (rst),
         .flush            (flush_fifo),
         .read             (read_fifo),
         .write            (write_fifo));
   
   
   parameter STATE_IDLE              = 5'h00;
   parameter STATE_WAIT_START_ADDRESS = 5'h02;
   parameter STATE_READ_ADDRESS = 5'h03;   
   parameter STATE_WAIT_START_DATA= 5'h04;
   parameter STATE_WAIT_START_READ_RESPONSE = 5'h05;   
   parameter STATE_READ_DATA = 5'h06;
   parameter STATE_WRITE_REGISTER = 5'h07;
   parameter STATE_WRITE_REGISTER_DONE = 5'h08;
   parameter STATE_WRITE_INCREMENT_ADDRESS = 5'h09;
   parameter STATE_WAIT_DONE_READ_RESPONSE = 5'h0A;   
   parameter STATE_READ_INCREMENT_ADDRESS = 5'h0B;
   parameter STATE_WAIT_START_FIFO_RESPONSE_LOW = 5'h0C;
   parameter STATE_WAIT_DONE_FIFO_RESPONSE_LOW = 5'h0D;
   parameter STATE_WAIT_START_FIFO_RESPONSE_HIGH = 5'h0E;
   parameter STATE_WAIT_DONE_FIFO_RESPONSE_HIGH= 5'h0F;
   parameter STATE_WAIT_START_FIFO_READ_LOW = 5'h10;
   parameter STATE_WAIT_START_FIFO_READ_HIGH = 5'h11;   
   parameter STATE_POP_FIFO = 5'h12;

   
   reg [4:0] state = STATE_IDLE;   
   reg [4:0] next_state = STATE_IDLE;      
   reg       first = 0;
   reg       finish = 0;
   reg       terminate_transaction =0;
   
   always @(posedge clk_sys)
     state <= next_state;        

   always @(*) begin
      case (state)
        STATE_IDLE: begin
           if (nCS) begin
              command = 0;
              address = 0;
              spi_data_out = 0;
              data_write = 0;
              write = 0;
              first = 0;
              read_data_fifo = 0;
           end 
           
           if (! nCS) begin
              if (spi_byte_done) begin
                 command = spi_data_in;
                 if (`ADXL362_COMMAND_FIFO == command) begin
                    spi_data_out = data_rd;                    
                    next_state = STATE_WAIT_START_FIFO_READ_LOW;                    
                 end else if ((`ADXL362_COMMAND_WRITE == command) || (`ADXL362_COMMAND_READ==command)) begin
                    next_state = STATE_WAIT_START_ADDRESS;                    
                 end
              end
           end
        end // case: STATE_IDLE

        STATE_WAIT_START_ADDRESS: begin
           if (spi_byte_begin) begin
              next_state = STATE_READ_ADDRESS;
           end else begin
              next_state = STATE_WAIT_START_ADDRESS;              
           end
        end

        STATE_READ_ADDRESS: begin
           if (spi_byte_done) begin
              address = spi_data_in;
              spi_data_out = data_read;
              if (`ADXL362_COMMAND_WRITE == command) next_state = STATE_WAIT_START_DATA;
              if (`ADXL362_COMMAND_READ == command)  next_state = STATE_WAIT_START_READ_RESPONSE;
           end else begin
              next_state = STATE_READ_ADDRESS;
           end
        end        

        STATE_WAIT_START_DATA: begin
           if (!nCS) begin
              if (spi_byte_begin) begin
                 next_state = STATE_READ_DATA;
              end else begin
                 next_state = STATE_WAIT_START_DATA; 
              end         
           end else begin
              next_state = STATE_IDLE;              
           end  
        end

        STATE_READ_DATA:begin
           if (spi_byte_done) begin
              data_write = spi_data_in;  
              next_state = STATE_WRITE_REGISTER;
           end else begin
              next_state = STATE_READ_DATA;
           end
        end

        STATE_WRITE_REGISTER:begin
           write = 1;
           next_state = STATE_WRITE_REGISTER_DONE;
        end

        STATE_WRITE_REGISTER_DONE:begin
           if (nCS) begin
              next_state = STATE_IDLE;              
           end else begin              
              write = 0;
              first = 1;              
              next_state = STATE_WRITE_INCREMENT_ADDRESS;
           end
        end

        STATE_WRITE_INCREMENT_ADDRESS: begin
           if (nCS) begin
              next_state = STATE_IDLE;              
           end else begin
              if (first) begin
                 address = address + 1;
                 first = 0;                 
              end
              next_state = STATE_WAIT_START_DATA;
           end
        end

        STATE_WAIT_START_READ_RESPONSE:begin
           if (! nCS) begin
//              spi_data_out = data_read;
              if (spi_byte_begin) begin
                 next_state = STATE_WAIT_DONE_READ_RESPONSE;              
              end else begin
                 next_state = STATE_WAIT_START_READ_RESPONSE;              
              end
           end else begin
              next_state = STATE_IDLE;              
           end
        end // case: STATE_WAIT_START_READ_RESPONSE        

        STATE_WAIT_DONE_READ_RESPONSE: begin
           if (spi_byte_done) begin
              first = 1;              
              next_state = STATE_READ_INCREMENT_ADDRESS;              
           end else begin
              next_state = STATE_WAIT_DONE_READ_RESPONSE;              
           end
        end

        STATE_READ_INCREMENT_ADDRESS: begin
           if (nCS) begin
              next_state = STATE_IDLE;              
           end else begin
              if (first) begin
                 address = address + 1;
                 first = 0;                 
              end
              next_state = STATE_WAIT_START_READ_RESPONSE;
           end
        end

        STATE_WAIT_START_FIFO_READ_LOW: begin
           if (nCS) begin
              next_state = STATE_IDLE;              
           end else begin
              read_data_fifo = 0;
              spi_data_out = data_fifo_read[7:0];
              next_state = STATE_WAIT_START_FIFO_RESPONSE_LOW;
           end
        end

        STATE_WAIT_START_FIFO_RESPONSE_LOW: begin
           if (nCS) begin
              next_state = STATE_IDLE;              
           end else begin
              if (spi_byte_begin) begin
                 next_state = STATE_WAIT_DONE_FIFO_RESPONSE_LOW;              
              end else begin
                 next_state = STATE_WAIT_START_FIFO_RESPONSE_LOW;              
              end           
           end
        end

        STATE_WAIT_DONE_FIFO_RESPONSE_LOW:begin
           if (spi_byte_done) begin
              next_state = STATE_WAIT_START_FIFO_READ_HIGH;              
           end else begin
              next_state = STATE_WAIT_DONE_FIFO_RESPONSE_LOW;              
           end           
        end

        STATE_WAIT_START_FIFO_READ_HIGH:begin
           if (nCS) begin
              next_state = STATE_IDLE;              
           end else begin
              read_data_fifo = 0;
              spi_data_out = data_fifo_read[15:08];
              next_state = STATE_WAIT_START_FIFO_RESPONSE_HIGH;
           end
        end


        STATE_WAIT_START_FIFO_RESPONSE_HIGH: begin
           if (spi_byte_begin) begin
              next_state = STATE_WAIT_DONE_FIFO_RESPONSE_HIGH;              
           end else begin
              next_state = STATE_WAIT_START_FIFO_RESPONSE_HIGH;              
           end           
        end

        STATE_WAIT_DONE_FIFO_RESPONSE_HIGH:begin
           if (spi_byte_done) begin
              next_state = STATE_POP_FIFO;              
           end else begin
              next_state = STATE_WAIT_DONE_FIFO_RESPONSE_HIGH;              
           end           
        end        
        
        STATE_POP_FIFO:begin
           if (nCS) begin
              next_state = STATE_IDLE;              
           end else begin
              read_data_fifo = 1;
              next_state = STATE_WAIT_START_FIFO_READ_LOW;
           end
        end
          
        
        default: begin
           next_state = STATE_IDLE;             
        end
      endcase // case (state)
      
   end

   reg [(40*8)-1:0] state_name =0;
   always @(*)
     case (state)
       STATE_IDLE: state_name = "IDLE";
       STATE_WAIT_START_FIFO_READ_LOW: state_name = "START FIFO READ LOW";       
       STATE_WAIT_START_ADDRESS : state_name = "WAIT START ADDRESS";
       STATE_READ_ADDRESS : state_name = "READ ADDRESS";
       STATE_WAIT_START_DATA: state_name = "WAIT START DATA";
       STATE_WAIT_START_READ_RESPONSE : state_name = "WAIT START READ"; 
       STATE_READ_DATA : state_name = "READ DATA"; 
       STATE_WRITE_REGISTER : state_name = "WRITE REGISTER"; 
       STATE_WRITE_REGISTER_DONE : state_name = "WRITE REGISTER DONE"; 
       STATE_WRITE_INCREMENT_ADDRESS : state_name = "WRITE INCREMENT ADDRESS";
       STATE_WAIT_DONE_READ_RESPONSE: state_name = "DONE READ RESPONSE"; 
       STATE_READ_INCREMENT_ADDRESS: state_name = "READ INCREMENT ADDRESS";
       STATE_WAIT_START_FIFO_RESPONSE_LOW: state_name = "START FIFO RESPONSE LOW";
       STATE_WAIT_DONE_FIFO_RESPONSE_LOW : state_name = "WAIT DONE FIFO RESPONSE LOW";
       STATE_WAIT_START_FIFO_RESPONSE_HIGH: state_name = "START FIFO RESPONSE HIGH";
       STATE_WAIT_DONE_FIFO_RESPONSE_HIGH : state_name = "WAIT DONE FIFO RESPONSE HIGH";       
       STATE_POP_FIFO: state_name = "POP FIFO";
       default: state_name = "DEFAULT!";
       
     endcase // case (state)
   
   
endmodule // adxl362_spi
