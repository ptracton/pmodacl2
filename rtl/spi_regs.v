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
   temperature, data_out, wfwe, rfre, wr_spsr, clear_spif, clear_wcol,
   wfdin, ncs_o, spcr, sper,
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
   output reg [15:0] temperature;
 
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
   output reg       wfwe; //Write FIFO     
   output reg       rfre; //Read FIFO
   output reg       wr_spsr; // Write SPSR
   output reg       clear_spif; //Clear the SPIF bit
   output reg       clear_wcol; //Clear the WCOL bit
   output reg [7:0] wfdin;  // Write FIFO Data In
   output reg       ncs_o;
   
   //
   // Registers
   //
   output reg [7:0]       spcr;
   output reg [7:0]       sper;
   input wire [7:0]       spsr;
   


   //
   // Address Decode
   //
   wire                   spcr_enable = (port_id == (BASE_ADDRESS + 8'h00));
   wire                   spsr_enable = (port_id == (BASE_ADDRESS + 8'h01));
   wire                   spdr_enable = (port_id == (BASE_ADDRESS + 8'h02));
   wire                   sper_enable = (port_id == (BASE_ADDRESS + 8'h03));
   wire                   ncso_enable = (port_id == (BASE_ADDRESS + 8'h04));
   wire                   temperature_low_enable  = (port_id == (BASE_ADDRESS + 8'h05));
   wire                   temperature_high_enable = (port_id == (BASE_ADDRESS + 8'h06));
   
   //
   // Register Writing
   //
   always @(posedge clk)
     if (reset) begin
        spcr <= 0;
        sper <= 0; 
        wfdin <= 0;     
        wfwe <= 0; 
        clear_spif <= 0;
        clear_wcol <= 0;   
        wr_spsr <= 0; 
        ncs_o <=1; 
        temperature <= 0;
       
     end else begin
        if (write_strobe) begin
           if (ncso_enable) begin
              ncs_o <= data_in[0];              
           end
           
           if (spsr_enable) begin
              clear_spif <= data_in[7];
              clear_wcol <= data_in[6];
              wr_spsr <= 1;              
           end else begin
              clear_spif <= 0;
              clear_wcol <= 0;
              wr_spsr <= 0;        
           end
           if (temperature_low_enable) begin
              temperature[7:0] <= data_in;              
           end
           if (temperature_high_enable) begin
              temperature[15:8] <= data_in;              
           end
           
           if (spcr_enable) begin
              spcr <= data_in;              
           end
           if (sper_enable) begin
              sper <= data_in;              
           end
           if (spdr_enable) begin
              wfdin <= data_in;
              wfwe <= 1;              
           end else begin
              wfwe <= 0;              
           end
           
        end // if (write_strobe)
        else begin
           clear_spif <= 0;
           clear_wcol <= 0;                   
           wfwe <= 0; 
           wr_spsr <= 0;                  
        end
     end // else: !if(reset)   

   //
   // Register Read
   //
   always @(posedge clk)
     if (reset) begin
        data_out <= 0;  
        rfre <= 0;        
     end else begin
        if (temperature_low_enable) begin
           data_out <= temperature[7:0];              
        end
        if (temperature_high_enable) begin
           data_out <= temperature[15:8];              
        end        
        if (spcr_enable) begin
           data_out <= spcr;           
        end
        if (sper_enable) begin
           data_out <= sper;           
        end
        if (spsr_enable) begin
           data_out <= spsr;           
        end
        if (spdr_enable) begin
           data_out <= rfdout;
           rfre <= 1;           
        end else begin
           rfre <= 0;           
        end
     end
   
endmodule // spi_regs
