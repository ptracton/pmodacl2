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

   reg [7:0]       spi_data_in;
   reg [7:0]       spi_data_out;   
   reg [2:0]       bit_count;
   reg [2:0]       bit_count_previous;
   reg [7:0]       command;
   reg             read_fifo;
   wire [7:0]      data_rd;
   
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

   adxl362_fifo spi_data_received_fifo(
                                       // Outputs
                                       .data_rd         (data_rd[7:0]),
                                       .fifo_empty      (fifo_empty),
                                       // Inputs
                                       .clk_read        (clk_16mhz),
                                       .read            (read_fifo),
                                       .write           (write_fifo),
                                       .data_wr         (spi_data_in[7:0]));
   
   

   parameter STATE_IDLE           = 4'h0;
   parameter STATE_READ_ADDRESS   = 4'h1;
   parameter STATE_READ_DATA      = 4'h2;
   parameter STATE_READ_REGISTER  = 4'h3;   
   parameter STATE_WRITE_REGISTER = 4'h4;
   parameter STATE_READ_FIFO      = 4'h5;
   
   reg [3:0] state;
   reg [3:0] next_state;
   
   always @(posedge clk_16mhz)
     if (nCS == 0) begin
        state <= next_state;        
     end else begin
        state <= STATE_IDLE;        
     end

   always @(*) begin
      case (state)
        STATE_IDLE: begin
           address = 0;
           data_write = 0;
           write = 0;
           command = 0;  
           read_fifo = 0; 
           spi_data_out = 0;           
           if (!fifo_empty) begin
              read_fifo = 1;              
              command = data_rd;
              next_state = STATE_READ_ADDRESS;              
           end else begin
              next_state = STATE_IDLE;              
           end
        end

        STATE_READ_ADDRESS: begin
           read_fifo = 0;           
           if (!fifo_empty) begin
              read_fifo = 1;              
              address = data_rd;
              if (command == `ADXL362_COMMAND_WRITE) next_state = STATE_READ_DATA;
              if (command == `ADXL362_COMMAND_READ)  begin next_state = STATE_READ_REGISTER; spi_data_out = data_read; end
              if (command == `ADXL362_COMMAND_FIFO)  next_state = STATE_READ_FIFO;              
           end else begin
              next_state = STATE_READ_ADDRESS;              
           end
        end
        
        STATE_READ_DATA: begin
           read_fifo = 0;           
           if (!fifo_empty) begin
              read_fifo = 1;              
              data_write = data_rd;
              write = 1;
              next_state = STATE_WRITE_REGISTER;
           end else begin
              write = 0;              
              next_state = STATE_READ_DATA;
           end
        end        
        
        STATE_WRITE_REGISTER: begin
           read_fifo = 0;           
           write = 0;                           
           if (nCS == 0)begin
              address = address + 1;
              next_state = STATE_READ_DATA;              
           end else begin
              next_state = STATE_IDLE;              
           end
        end
           
        STATE_READ_REGISTER:begin
           //spi_data_out = data_read;
           if (nCS == 0)begin
              address = address + 1;
              next_state = STATE_READ_REGISTER;              
           end else begin
              next_state = STATE_IDLE;              
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
       STATE_READ_ADDRESS: state_name = "Read Address";
       STATE_READ_DATA: state_name = "Read Data";
       STATE_READ_REGISTER: state_name = "Read Register";
       STATE_READ_FIFO: state_name = "Read FIFO";
       STATE_WRITE_REGISTER: state_name = "Write Register";
       default: state_name = "DEFAULT!";
       
     endcase // case (state)
   
   
endmodule // adxl362_spi
