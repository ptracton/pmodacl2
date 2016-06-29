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
   MISO, address, data_write, write,
   // Inputs
   SCLK, MOSI, nCS, clk_16mhz, data_read
   ) ;
   input wire SCLK;
   input wire MOSI;
   input wire nCS;
   output reg MISO;
   input wire clk_16mhz;
   
   output reg [5:0] address;
   output reg [7:0] data_write;
   input wire [7:0] data_read;
   output reg       write;

   /*AUTOWIRE*/

   /*AUTOREG*/

   reg [7:0]       spi_data_in = 0;
   reg [7:0]       spi_data_out =0 ;   
   reg [2:0]       bit_count =0;
   reg [2:0]       bit_count_previous =0;
   reg [7:0]       command;
   reg             read_fifo = 0;
   wire [7:0]      data_rd;
   reg             flush_fifo = 0;   
   wire            flush = flush_fifo | (nCS == 1);
   
   //
   // Capture SPI data coming in.  The spec says this IC is always CPHA = 0 and CPOL = 0
   // so we can get away with this very simple solution.
   //
   always @(posedge SCLK or posedge nCS)
     if (nCS) begin
        bit_count <= 0;
        bit_count_previous <= 0;        
        spi_data_in <= 0;
        MISO <= 0;        
     end else begin
        bit_count_previous <= bit_count;        
        bit_count <= bit_count + 1;
        spi_data_in <= {spi_data_in[6:0], MOSI};   
        MISO <= spi_data_out[7-bit_count];        
     end
   wire write_fifo = (bit_count == 0) && (bit_count_previous == 7);
   reg  write_fifo_delay;

   always @(posedge clk_16mhz)
     write_fifo_delay <= write_fifo;
   
   adxl362_fifo spi_data_received_fifo(
                                       // Outputs
                                       .data_rd         (data_rd[7:0]),
                                       .fifo_empty      (fifo_empty),
                                       // Inputs
                                       .clk_read        (clk_16mhz),
                                       .flush           (flush),
                                       .read            (read_fifo),
                                       .write           (write_fifo),
                                       .data_wr         (spi_data_in[7:0]));
   
   

   parameter STATE_IDLE              = 4'h0;
   parameter STATE_READ_COMMAND      = 4'h1;  
   parameter STATE_WAIT_ADDRESS      = 4'h2; 
   parameter STATE_READ_ADDRESS      = 4'h3;
   parameter STATE_WAIT_DATA         = 4'h4; 
   parameter STATE_READ_DATA         = 4'h5;
   parameter STATE_READ_REGISTER     = 4'h6;   
   parameter STATE_WRITE_REGISTER    = 4'h7;
   parameter STATE_READ_FIFO         = 4'h8;
   parameter STATE_INCREMENT_ADDRESS = 4'h9;
   parameter STATE_FINISH            = 4'hA;
   parameter STATE_WRITE_EMPTY_FIFO  = 4'hB;   
   parameter STATE_RESPOND_DATA      = 4'hC;
   
   reg [3:0] state = STATE_IDLE;   
   reg [3:0] next_state = STATE_IDLE;      
   reg       first = 0;
   
   always @(posedge clk_16mhz)
     if (nCS == 0) begin
        state <= next_state;        
     end else begin
        state <= STATE_IDLE;        
     end

   always @(*) begin
      case (state)
        STATE_IDLE: begin
           read_fifo = 0;
           flush_fifo = 0;  
           write = 0;           
           if (fifo_empty == 0)begin
              next_state = STATE_READ_COMMAND;               
           end else begin
              next_state = STATE_IDLE;              
           end
        end

        STATE_READ_COMMAND: begin
           read_fifo = 1;           
           command = data_rd;           
           next_state = STATE_WAIT_ADDRESS;              
        end        

        STATE_WAIT_ADDRESS: begin
           read_fifo = 0;           
           if (nCS) begin
              next_state = STATE_FINISH;              
           end else if (fifo_empty == 0) begin
              next_state = STATE_READ_ADDRESS;              
           end else begin
              next_state = STATE_WAIT_ADDRESS;              
           end
        end
        
        STATE_READ_ADDRESS: begin
           read_fifo = 1;           
           address = data_rd;
           if (nCS) begin
              next_state = STATE_FINISH;              
           end else begin
              if (`ADXL362_COMMAND_WRITE == command) next_state = STATE_WAIT_DATA;
              if (`ADXL362_COMMAND_FIFO  == command) next_state = STATE_READ_FIFO;
              if (`ADXL362_COMMAND_READ  == command) next_state = STATE_READ_DATA;              
           end
        end
      
        STATE_READ_DATA: begin
           flush_fifo = 1;
           read_fifo = 0;           
           spi_data_out = data_read;
           if (nCS) begin
              next_state = STATE_FINISH;              
           end else if (bit_count == 7) begin  
              first = 0;              
              next_state = STATE_INCREMENT_ADDRESS;
           end else begin
              next_state = STATE_RESPOND_DATA;              
           end           
        end

        STATE_RESPOND_DATA:begin
           flush_fifo = 1;
           if (nCS) begin
              next_state = STATE_FINISH;
           end else if (bit_count == 3'h7) begin
//              next_state = STATE_READ_DATA;
              first = 0;              
              next_state = STATE_INCREMENT_ADDRESS;              
           end else begin
              next_state = STATE_RESPOND_DATA;              
           end
        end
        
        STATE_READ_FIFO: begin
           next_state = STATE_IDLE;           
        end

        STATE_WAIT_DATA:begin
           read_fifo = 0;           
           write = 0;           
           if (nCS) begin
              next_state = STATE_FINISH;              
           end else if (fifo_empty == 0) begin
              next_state = STATE_WRITE_REGISTER;              
           end else begin
              next_state = STATE_WAIT_DATA;
           end           
        end
        
        STATE_WRITE_REGISTER: begin
           write = 1;
           data_write = data_rd;
           next_state = STATE_WRITE_EMPTY_FIFO;           
        end

        STATE_WRITE_EMPTY_FIFO: begin
           read_fifo = 1; 
           write = 0;           
           if (fifo_empty) begin
              read_fifo = 0;
              first = 0;              
              next_state = STATE_INCREMENT_ADDRESS;              
           end else begin
              next_state = STATE_WRITE_EMPTY_FIFO;              
           end
        end
        
        STATE_INCREMENT_ADDRESS: begin
           read_fifo = 0;
           write = 0;           
           if (nCS) begin
              next_state = STATE_FINISH;              
           end else begin 
              if (first == 0) begin
                 address = address + 1;
                 first = 1;                 
              end
              if (`ADXL362_COMMAND_WRITE == command) next_state = STATE_WAIT_DATA;
              if (`ADXL362_COMMAND_FIFO  == command) next_state = STATE_READ_FIFO;
              if (`ADXL362_COMMAND_READ  == command) next_state = STATE_READ_DATA;  
           end            
        end // case: STATE_INCREMENT_ADDRESS
               
        STATE_FINISH: begin
           flush_fifo = 1;
           if (fifo_empty) begin
              next_state = STATE_IDLE;              
           end begin
              next_state = STATE_FINISH;              
           end
        end
        
        default: begin
           next_state = STATE_FINISH;             
        end
      endcase // case (state)
      
   end


   reg [(40*8)-1:0] state_name =0;
   always @(*)
     case (state)
       STATE_IDLE: state_name = "IDLE";
       STATE_READ_COMMAND: state_name = "Read Command";
       STATE_WAIT_ADDRESS: state_name = "Wait Address";       
       STATE_READ_ADDRESS: state_name = "Read Address";
       STATE_WAIT_DATA: state_name = "Wait Data";              
       STATE_READ_DATA: state_name = "Read Data";
       STATE_READ_REGISTER: state_name = "Read Register";
       STATE_READ_FIFO: state_name = "Read FIFO";
       STATE_WRITE_REGISTER: state_name = "Write Register";
       STATE_INCREMENT_ADDRESS: state_name = "Increment Address";
       STATE_FINISH: state_name = "State Finish";  
       STATE_WRITE_EMPTY_FIFO: state_name = "Write Empty FIFO";
       STATE_RESPOND_DATA: state_name = "Respond Data";       
       default: state_name = "DEFAULT!";
       
     endcase // case (state)
   
   
endmodule // adxl362_spi
