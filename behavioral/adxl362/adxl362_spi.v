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
   
   output reg [5:0] address = 0;
   output reg [7:0] data_write =0 ;
   input wire [7:0] data_read;
   input wire [15:0] data_fifo_read;  
   output reg        data_fifo_write =0;   
   output reg        write =0;
   input wire        rst;
   output reg        read_data_fifo =0;
   
   /*AUTOWIRE*/

   /*AUTOREG*/

   reg [7:0]         spi_data_in = 0;
   reg [7:0]         spi_data_out =0 ;   
   reg [2:0]         bit_count =0;
   reg [2:0]         bit_count_previous =0;
   reg [7:0]         command =0;
   reg               read_fifo = 0;
   wire [7:0]        data_rd;
   reg               flush_fifo = 0;   
   wire              flush = flush_fifo ;//| (nCS == 1);
   reg               write_fifo =0;   
   wire              empty_fifo;                  // From fifo of adxl362_fifo.v
   wire              full_fifo;                   // From fifo of adxl362_fifo.v
   
   //
   // Capture SPI data coming in.  The spec says this IC is always CPHA = 0 and CPOL = 0
   // so we can get away with this very simple solution.
   //

   always @(posedge SCLK or posedge nCS)
     if (nCS) begin
        bit_count <= 0;
        bit_count_previous <= 0;        
        //        spi_data_in <= 0;
        MISO <= 0;        
     end else begin
        bit_count_previous <= bit_count;        
        bit_count <= bit_count + 1;
        //        spi_data_in <= {spi_data_in[6:0], MOSI};
        MISO <= spi_data_out[7-bit_count];
     end


   wire spi_byte_done = (bit_count == 0) && (bit_count_previous == 7);
   wire spi_byte_begin = (bit_count == 1) && (bit_count_previous == 0);
   
   
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
   

 
   
   always @(*) begin
      if (nCS) begin
         command = 0;
         address = 0;
         data_write = 0;
         spi_data_out = 0;
         spi_data_in = 0;              
      end else begin
//         $display("negedge nCS begin @%d", $time);
         command = 0;
         address = 0;
         data_write = 0;
         spi_data_out = 0;
         spi_data_in = 0;      
         repeat (8) @(posedge SCLK) spi_data_in = {spi_data_in, MOSI};
         #1 command = spi_data_in;
         #1 spi_data_in = 0;         
         @(posedge clk_sys);
         if (`ADXL362_COMMAND_FIFO == command) begin
//            while (!nCS) begin
               spi_data_out = data_fifo_read[7:0];
               repeat (8) @(posedge SCLK);
               spi_data_out = data_fifo_read[15:8];
               repeat (8) @(posedge SCLK);
               @(posedge clk_sys);
               read_data_fifo = 1;
               @(posedge clk_sys);
               read_data_fifo = 0;            
//            end         
         end else if (`ADXL362_COMMAND_WRITE == command) begin // if (`ADXL362_COMMAND_FIFO == command)
            $display("Command Write  @%d", $time);
            repeat (8) @(posedge SCLK) spi_data_in = {spi_data_in[6:0], MOSI};
            #1 address = spi_data_in;
            #1 spi_data_in = 0; 
//            while (!nCS) begin
               $display("Write nCS 0x%d  @%d",nCS,  $time);
               repeat (8) @(posedge SCLK) spi_data_in = {spi_data_in[6:0], MOSI};
               #1 data_write = spi_data_in;            
               @(posedge clk_sys);
               write = 1;
               $display("Write Data 0x%x to Address 0x%x @%d", data_write, address, $time);
               @(posedge clk_sys);
               write = 0;
               address = address + 1;            
//            end         
         end else if (`ADXL362_COMMAND_READ ==command) begin // if (`ADXL362_COMMAND_WRITE == command)
            repeat (8) @(posedge SCLK) spi_data_in = {spi_data_in[6:0], MOSI};
            #1 address = spi_data_in; 
            #1 spi_data_in = 0;         
//            while (!nCS) begin
               spi_data_out = data_read;
               repeat (8) @(posedge SCLK);
               @(posedge clk_sys);
               address = address + 1;            
//            end         
         end else begin
            $display("INVALID COMMAND 0x%x @ %d", command, $time);         
         end // else: !if(`ADXL362_COMMAND_READ ==command)
         command = 0;
         address = 0;
         data_write = 0;
         spi_data_in = 0;
//         $display("negedge nCS done @%d", $time);      
      end // else: !if(nCS)
   end // always @ (nCS)
   
   
   
   
endmodule // adxl362_spi
