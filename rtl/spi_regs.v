//                              -*- Mode: Verilog -*-
// Filename        : spi_regs.v
// Description     : SPI Registers
// Author          : Philip Tracton
// Created On      : Tue Jul 19 21:20:13 2016
// Last Modified By: Philip Tracton
// Last Modified On: Tue Jul 19 21:20:13 2016
// Update Count    : 0
// Status          : Unknown, Use with caution!

module spi_regs (/*AUTOARG*/
   // Outputs
   data_out, wfwe, rfre, wr_spsr, clear_spif, clear_wcol, wfdin, spcr,
   sper,
   // Inputs
   clk, reset, port_id, data_in, read_strobe, write_strobe, rfdout,
   spsr
   ) ;
   parameter BASE_ADDRESS = 8'h00;   

   //
   // System Interface
   //
   input clk;
   input reset;

   //
   // Picoblaze Bus Interface
   //
   input wire [7:0] port_id;
   input wire [7:0] data_in;
   output reg [7:0] data_out;
   input            read_strobe;
   input            write_strobe;
   
   //
   // Spi Device Interface
   //
   input wire [7:0] rfdout; //Read FIFO Output 
   output wire      wfwe; //Write FIFO     
   output wire      rfre; //Read FIFO
   output wire      wr_spsr; // Write SPSR
   output wire      clear_spif; //Clear the SPIF bit
   output wire      clear_wcol; //Clear the WCOL bit
   output wire [7:0] wfdin;  // Write FIFO Data In
   
   //
   // Registers
   //
   output reg [7:0]       spcr;
   output reg [7:0]       sper;
   input wire [7:0]       spsr;
   


   //
   // Address Decode
   //
   wire                   spcr_enable = (port_id == (BASE_ADDRESS + 0));
   wire                   sper_enable = (port_id == (BASE_ADDRESS + 1));
   wire                   spsr_enable = (port_id == (BASE_ADDRESS + 2));
   
   //
   // Register Writing
   //
   always @(posedge clk)
     if (reset) begin
        spcr <= 0;
        sper <= 0;        
     end else begin
        if (write_strobe) begin
           if (spcr_enable) begin
              spcr <= data_in;              
           end
           if (sper_enable) begin
              sper <= data_in;              
           end
        end
     end // else: !if(reset)   

   //
   // Register Read
   //
   always @(posedge clk)
     if (reset) begin
        data_out <= 0;        
     end else begin
        if (spcr_enable) begin
           data_out <= spcr;           
        end
        if (sper_enable) begin
           data_out <= sper;           
        end
        if (spsr_enable) begin
           data_out <= spsr;           
        end
        
     end
   
endmodule // spi_regs
