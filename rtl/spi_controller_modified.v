//                              -*- Mode: Verilog -*-
// Filename        : spi_controller.v
// Description     : State Machine to control SPI interface
// Author          : Philip Tracton
// Created On      : Fri Jul  8 20:59:53 2016
// Last Modified By: Philip Tracton
// Last Modified On: Fri Jul  8 20:59:53 2016
// Update Count    : 0
// Status          : Unknown, Use with caution!
module spi_controller_modified (/*AUTOARG*/
   // Outputs
   wfdin, spcr, sper, wfwe, rfre, wr_spsr, clear_spif, clear_wcol,
   ncs_o, temperature,
   // Inputs
   clk, rst, rfdout, inta_o, spsr
   ) ;

   //
   // System Interface
   //
   input wire clk;
   input wire rst;

   output reg [7:0] wfdin;
   input wire [7:0] rfdout;
   

   //
   // SPI Device Interface
   //
   input wire       inta_o;
   input wire [7:0] spsr; // Serial Peripheral Status register ('HC11 naming)
   
   output reg [7:0] spcr; // Serial Peripheral Control Register ('HC11 naming)
   output reg [7:0] sper; // Serial Peripheral Extension register
   output reg       wfwe; //Write FIFO     
   output reg       rfre; //Read FIFO
   output reg       wr_spsr; // Write SPSR
   output reg       clear_spif; //Clear the SPIF bit
   output reg       clear_wcol; //Clear the WCOL bit
   
   //    
   //
   // SPI Interface
   //
   output reg       ncs_o;
   output reg [15:0] temperature =0;
   
   parameter STATE_IDLE           = 4'h0;
   parameter STATE_SPI_INIT       = 4'h1;
   parameter STATE_SPI_INIT_DONE  = 4'h2;   
   parameter STATE_COMMAND_WRITE  = 4'h3;
   parameter STATE_COMMAND_DONE   = 4'h4;
   parameter STATE_ADDRESS_WRITE  = 4'h5;
   parameter STATE_ADDRESS_DONE    = 4'h6;
   parameter STATE_READ_TEMP_LOW       = 4'h7;
   parameter STATE_READ_TEMP_LOW_DONE  = 4'h8;
   parameter STATE_READ_TEMP_HIGH      = 4'h9;
   parameter STATE_READ_TEMP_HIGH_DONE = 4'hA;
   parameter STATE_READ_TEMP_LOW_FIFO  = 4'hB;
   parameter STATE_READ_TEMP_LOW_FIFO_DONE  = 4'hC;
   parameter STATE_READ_TEMP_HIGH_FIFO  = 4'hD;
   parameter STATE_READ_TEMP_HIGH_FIFO_DONE  = 4'hE;

   
   reg [3:0]    state;
   reg [3:0]    next_state;

   reg [31:0]   count;
   wire         count_done;
   
   assign count_done = (count == 32'd10000);
   
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

   reg [7:0] address;
   reg       first_pass;
   
   always @(*) begin
      case (state)
        STATE_IDLE: begin
           spcr = 8'h10;
           sper = 8'h00;           
           wfwe = 0;
           rfre = 0;
           wr_spsr = 0;
           clear_spif = 0;
           clear_wcol = 0; 
           wfdin = 0;
           address = 8'h14; 
           first_pass = 1;  
           ncs_o = 1;           
           if (count_done) begin
              next_state = STATE_SPI_INIT;              
           end else begin
              next_state = STATE_IDLE;              
           end
        end

        STATE_SPI_INIT:begin
           spcr = 8'hD2;
           sper = 8'h00;
           clear_spif = 1;
           clear_wcol = 1;           
           wr_spsr = 1;
           next_state = STATE_SPI_INIT_DONE;           
        end

        STATE_SPI_INIT_DONE:begin
           clear_spif = 0;
           clear_wcol = 0;           
           wr_spsr = 0;
           ncs_o = 0;           
           next_state = STATE_COMMAND_WRITE;           
        end

        STATE_COMMAND_WRITE:begin
           wfdin = 8'h0B; //Command to READ Data
           wfwe = 1;
           next_state = STATE_COMMAND_DONE;           
        end
        
        STATE_COMMAND_DONE:begin
           wfwe = 0;
           if (inta_o) begin
              next_state = STATE_ADDRESS_WRITE;
              clear_spif = 1;
              clear_wcol = 1;           
              wr_spsr = 1;
              rfre = 1;              
           end else begin
              next_state = STATE_COMMAND_DONE;              
           end
        end
        

        STATE_ADDRESS_WRITE:begin
           clear_spif = 0;
           clear_wcol = 0;           
           wr_spsr = 0;
           rfre = 0;           
           wfdin = address;           
           wfwe = 1;
           next_state = STATE_ADDRESS_DONE;           
        end
        
        STATE_ADDRESS_DONE:begin
           clear_spif = 0;
           clear_wcol = 0;           
           wr_spsr = 0;                             
           wfwe = 0;
           rfre = 0;           
           if (inta_o) begin
              clear_spif = 1;
              clear_wcol = 1;           
              wr_spsr = 1; 
              rfre = 1;              
              next_state = STATE_READ_TEMP_LOW; 
           end else begin
              next_state = STATE_ADDRESS_DONE;             
           end                         
        end

        STATE_READ_TEMP_LOW:begin
           rfre = 0;           
           clear_spif = 0;
           clear_wcol = 0;           
           wr_spsr = 0;             
           wfwe = 1;
           wfdin = 0;    
           next_state = STATE_READ_TEMP_LOW_DONE;           
        end
        
        STATE_READ_TEMP_LOW_DONE:begin
           clear_spif = 0;
           clear_wcol = 0;           
           wr_spsr = 0;               
           wfwe = 0;
           if (inta_o) begin
              clear_spif = 1;
              clear_wcol = 1;           
              wr_spsr = 1;
              next_state = STATE_READ_TEMP_HIGH;                                  
           end else begin
              next_state = STATE_READ_TEMP_LOW_DONE;            
           end
        end

        STATE_READ_TEMP_HIGH:begin
           clear_spif = 0;
           clear_wcol = 0;           
           wr_spsr = 0;                    
           wfwe = 1;
           wfdin = 0;           
           next_state = STATE_READ_TEMP_HIGH_DONE;           
        end // case: STATE_READ_TEMP_HIGH
        
        STATE_READ_TEMP_HIGH_DONE:begin
           clear_spif = 0;
           clear_wcol = 0;           
           wr_spsr = 0;             
           wfwe = 0;
           if (inta_o) begin
              clear_spif = 1;
              clear_wcol = 1;           
              wr_spsr = 1;               
              next_state = STATE_READ_TEMP_LOW_FIFO;            
           end else begin
              next_state = STATE_READ_TEMP_HIGH_DONE;              
           end                       
        end

        STATE_READ_TEMP_LOW_FIFO:begin
           clear_spif = 0;
           clear_wcol = 0;           
           wr_spsr = 0;  
           rfre = 1;
           temperature[7:0] = rfdout;            
           next_state = STATE_READ_TEMP_LOW_FIFO_DONE;           
        end

        STATE_READ_TEMP_LOW_FIFO_DONE:begin
           rfre = 0;     
           next_state = STATE_READ_TEMP_HIGH_FIFO;           
        end

        STATE_READ_TEMP_HIGH_FIFO:begin
           rfre = 1;
           temperature[15:8] = rfdout;
           next_state = STATE_READ_TEMP_HIGH_FIFO_DONE;           
        end

        STATE_READ_TEMP_HIGH_FIFO_DONE:begin
           rfre = 0;
           next_state = STATE_IDLE;           
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
       STATE_SPI_INIT      : spi_controller_state_name ="SPI INIT";
       STATE_SPI_INIT_DONE : spi_controller_state_name ="SPI INIT DONE";
       STATE_COMMAND_WRITE : spi_controller_state_name ="COMMAND WRITE";
       STATE_COMMAND_DONE  : spi_controller_state_name ="COMMAND WRITE DONE";
       STATE_ADDRESS_WRITE : spi_controller_state_name ="ADDRESS WRITE";
       STATE_ADDRESS_DONE   : spi_controller_state_name ="ADDRESS WRITE DONE";
       STATE_READ_TEMP_LOW      : spi_controller_state_name ="READ TEMP LOW";
       STATE_READ_TEMP_LOW_DONE : spi_controller_state_name ="READ TEMP LOW DONE";
       STATE_READ_TEMP_HIGH     : spi_controller_state_name ="READ TEMP HIGH";
       STATE_READ_TEMP_HIGH_DONE: spi_controller_state_name ="READ TEMP HIGH DONE";
       STATE_READ_TEMP_LOW_FIFO : spi_controller_state_name ="READ TEMP LOW FIFO";
       STATE_READ_TEMP_LOW_FIFO_DONE : spi_controller_state_name ="READ TEMP LOW FIFO DONE";
       STATE_READ_TEMP_HIGH_FIFO : spi_controller_state_name ="READ TEMP HIGH FIFO";
       STATE_READ_TEMP_HIGH_FIFO_DONE : spi_controller_state_name ="READ TEMP HIGH FIFO DONE";
       default: spi_controller_state_name = "Default";       
     endcase // case (state)
   
endmodule // spi_controller
