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
   MISO, address, data_write, data_fifo_write, write,
   // Inputs
   SCLK, MOSI, nCS, clk_16mhz, data_read, data_fifo_read, rst
   ) ;
   input wire SCLK;
   input wire MOSI;
   input wire nCS;
   output reg MISO;
   input wire clk_16mhz;
   
   output reg [5:0] address;
   output reg [7:0] data_write;
   input wire [7:0] data_read;
   input wire [7:0] data_fifo_read;  
   output reg       data_fifo_write;   
   output reg       write;
   input wire       rst;
   
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

   //
   // Detect the edge and pulse write for a single clock while we
   // are not flushing the FIFO
   //
   reg [2:0] wr_state;
   reg [2:0] wr_next_state;
   parameter WR_IDLE  = 3'h0;
   parameter WR_WRITE = 3'h1;
   parameter WR_DONE  = 3'h2;
   
   always @(posedge clk_16mhz)  begin
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
/* -----\/----- EXCLUDED -----\/-----
          if ((bit_count == 1) && (bit_count_previous == 0)) begin
             wr_next_state = WR_IDLE;             
          end else begin
             wr_next_state = WR_DONE;             
          end
 -----/\----- EXCLUDED -----/\----- */
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
         .clk              (clk_16mhz),
         .rst              (rst),
         .flush            (flush_fifo),
         .read             (read_fifo),
         .write            (write_fifo));
   
   
   parameter STATE_IDLE              = 4'h0;
   parameter STATE_READ_COMMAND      = 4'h1;
   parameter STATE_DONE_COMMAND      = 4'h2;   
   parameter STATE_WAIT_ADDRESS      = 4'h3; 
   parameter STATE_READ_ADDRESS      = 4'h4;
   parameter STATE_DONE_ADDRESS      = 4'h5; 
   parameter STATE_WAIT_DATA         = 4'h6; 
   parameter STATE_READ_DATA         = 4'h7;
   parameter STATE_DONE_DATA         = 4'h8;
   parameter STATE_READ_REGISTER     = 4'h9;   
   parameter STATE_WRITE_REGISTER    = 4'hA;
   parameter STATE_DONE_REGISTER     = 4'hB;
   parameter STATE_READ_FIFO         = 4'hC;
   parameter STATE_INCREMENT_ADDRESS = 4'hD;
   parameter STATE_FINISH            = 4'hE;
   parameter STATE_RESPOND_DATA      = 4'hF;
   
   reg [3:0] state = STATE_IDLE;   
   reg [3:0] next_state = STATE_IDLE;      
   reg       first = 0;
   reg       finish = 0;
   reg       terminate_transaction =0;
   
   always @(posedge clk_16mhz)
     state <= next_state;        

   always @(*) begin
      case (state)
        STATE_IDLE: begin
           read_fifo = 0;
           flush_fifo = 0;  
           write = 0;    
           data_fifo_write = 0;   
           finish = 0;           
           spi_data_out = 0;
           terminate_transaction = 0;
           if (! empty_fifo) begin
              next_state = STATE_READ_COMMAND;
              first = 1;              
           end
        end

        STATE_READ_COMMAND: begin
           if (nCS == 1) begin
              terminate_transaction = 1; 
              next_state = STATE_FINISH;               
           end           
           if (first) begin
              command = data_rd;
              read_fifo = 1;              
              next_state = STATE_DONE_COMMAND;              
           end
        end        

        STATE_DONE_COMMAND: begin
           if (nCS == 1) begin
              terminate_transaction = 1;
              next_state = STATE_FINISH;                             
           end           
           read_fifo = 0;
           first = 0;           
           next_state = STATE_WAIT_ADDRESS;           
        end
        
        STATE_WAIT_ADDRESS: begin
           if (nCS == 1) begin
              terminate_transaction = 1; 
              next_state = STATE_FINISH;                            
           end           
           if (! empty_fifo) begin
              next_state = STATE_READ_ADDRESS;
              address = data_rd;
              spi_data_out = data_read;  
              first = 1;              
           end else begin
              next_state = STATE_WAIT_ADDRESS;              
           end           
        end        
        
        STATE_READ_ADDRESS: begin
           if (nCS == 1) begin
              terminate_transaction = 1;    
              next_state = STATE_FINISH;                         
           end
//           address = data_rd;
           read_fifo = 1;
           first = 0;
           next_state = STATE_DONE_ADDRESS;           
        end

        STATE_DONE_ADDRESS:begin
           read_fifo = 0;           
           if (nCS == 1) begin
              terminate_transaction = 1;  
           end
           if (`ADXL362_COMMAND_WRITE == command) next_state = STATE_WAIT_DATA;           
           else if (`ADXL362_COMMAND_READ == command)  next_state = STATE_READ_DATA;
           else if (`ADXL362_COMMAND_FIFO == command)  next_state = STATE_READ_FIFO;
           else next_state = STATE_FINISH;           
        end
        
        STATE_READ_DATA: begin
           spi_data_out = data_read;  
           next_state = STATE_RESPOND_DATA;                
        end

        STATE_RESPOND_DATA:begin
           if (nCS == 1) begin
              terminate_transaction = 1;  
           end
           
           if (write_fifo) begin
              read_fifo = 1;
              first = 1;  
             // next_state =STATE_DONE_REGISTER;
              next_state = STATE_INCREMENT_ADDRESS;              
           end else begin
              read_fifo = 0;  
              next_state = STATE_RESPOND_DATA;
           end
        end
        
        STATE_READ_FIFO: begin
                 
        end

        STATE_WAIT_DATA:begin
           if (nCS == 1) begin
              terminate_transaction = 1;              
           end 
//           if (! empty_fifo) begin
           if (write_fifo) begin
              data_write = spi_data_in;
              write = 1;
              read_fifo = 1;              
//              next_state = STATE_WRITE_REGISTER;
              next_state = STATE_DONE_REGISTER;
              first = 1;              
           end else begin
              next_state = STATE_WAIT_DATA;              
           end                      
           
        end
        
        STATE_WRITE_REGISTER: begin
//           data_write = data_rd;
           read_fifo = 1;
           write = 1;          
           if (nCS == 1) begin
              terminate_transaction = 1;              
           end
           first = 1;  
           next_state = STATE_DONE_REGISTER;
        end        

        STATE_DONE_REGISTER:begin
           write = 0;
           read_fifo = 0;
           if (nCS == 1) begin
              terminate_transaction = 1;              
           end 
           first = 1;              
           next_state = STATE_INCREMENT_ADDRESS;
        end

        STATE_INCREMENT_ADDRESS: begin
           if (first ) begin
              write = 0;
              read_fifo = 0;
              address = address + 1;  
              spi_data_out = data_read;             
              first = 0;              
           end
           if (terminate_transaction || nCS) begin
              next_state = STATE_FINISH;              
           end else begin
              if (`ADXL362_COMMAND_WRITE == command) next_state = STATE_WAIT_DATA;           
              else if (`ADXL362_COMMAND_READ == command)  next_state = STATE_READ_DATA;
              else if (`ADXL362_COMMAND_FIFO == command)  next_state = STATE_READ_FIFO;
              else next_state = STATE_FINISH;  
           end
        end // case: STATE_INCREMENT_ADDRESS
               
        STATE_FINISH: begin
           write = 0;
           read_fifo = 0;
           first = 0;           
           flush_fifo = 1;
           terminate_transaction = 0;           
/* -----\/----- EXCLUDED -----\/-----
           if (finish == 0) begin
              finish = 1;              
              next_state = STATE_FINISH;     
           end else begin
 -----/\----- EXCLUDED -----/\----- */
              next_state = STATE_IDLE;
           //end
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
       STATE_DONE_COMMAND: state_name = "Read Command Done";
       STATE_WAIT_ADDRESS: state_name = "Wait Address";       
       STATE_READ_ADDRESS: state_name = "Read Address";
       STATE_DONE_ADDRESS: state_name = "Done Address";
       STATE_WAIT_DATA: state_name = "Wait Data";              
       STATE_READ_DATA: state_name = "Read Data";
       STATE_READ_REGISTER: state_name = "Read Register";
       STATE_READ_FIFO: state_name = "Read FIFO";
       STATE_WRITE_REGISTER: state_name = "Write Register";
       STATE_DONE_REGISTER: state_name = "Write Done Register";
       STATE_INCREMENT_ADDRESS: state_name = "Increment Address";
       STATE_FINISH: state_name = "State Finish";  
       STATE_RESPOND_DATA: state_name = "Respond Data";       
       default: state_name = "DEFAULT!";
       
     endcase // case (state)
   
   
endmodule // adxl362_spi
