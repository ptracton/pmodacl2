//                              -*- Mode: Verilog -*-
// Filename        : pb_display.v
// Description     : Seven Segment Display
// Author          : Philip Tracton
// Created On      : Thu May 28 23:25:10 2015
// Last Modified By: Philip Tracton
// Last Modified On: Thu May 28 23:25:10 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

module pb_display (/*AUTOARG*/
   // Outputs
   data_out, anode, cathode,
   // Inputs
   clk, reset, port_id, data_in, read_strobe, write_strobe,
   temperature, display_temperature
   ) ;

   parameter BASE_ADDRESS = 8'h00;
   
   input clk;
   input reset;

   input [7:0]            port_id;
   input [7:0]            data_in;
   output [7:0]           data_out;
   input                  read_strobe;
   input                  write_strobe;

   output [3:0]           anode;
   output [7:0]           cathode;

   input wire [15:0]      temperature;
   input wire             display_temperature;
   
   
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [7:0]           segment0;               // From regs of display_regs.v
   wire [7:0]           segment1;               // From regs of display_regs.v
   wire [7:0]           segment2;               // From regs of display_regs.v
   wire [7:0]           segment3;               // From regs of display_regs.v
   // End of automatics
   /*AUTOREG*/

   wire [7:0]           display_segment0 = (display_temperature) ? {4'b0, temperature[03:00]} : segment0;
   wire [7:0]           display_segment1 = (display_temperature) ? {4'b0, temperature[07:04]} : segment1;
   wire [7:0]           display_segment2 = (display_temperature) ? {4'b0, temperature[11:08]} : segment2;
   wire [7:0]           display_segment3 = (display_temperature) ? {4'b0, temperature[15:12]} : segment3;

   
   //
   // Registers
   //
   display_regs #(.BASE_ADDRESS(BASE_ADDRESS))
     regs (/*AUTOINST*/
           // Outputs
           .data_out                    (data_out[7:0]),
           .segment0                    (display_segment0[7:0]),
           .segment1                    (display_segment1[7:0]),
           .segment2                    (display_segment2[7:0]),
           .segment3                    (display_segment3[7:0]),
           // Inputs
           .clk                         (clk),
           .reset                       (reset),
           .port_id                     (port_id[7:0]),
           .data_in                     (data_in[7:0]),
           .read_strobe                 (read_strobe),
           .write_strobe                (write_strobe));
   

   //
   // Displays
   //
   display seven_segments(/*AUTOINST*/
                          // Outputs
                          .anode                (anode[3:0]),
                          .cathode              (cathode[7:0]),
                          // Inputs
                          .clk                  (clk),
                          .reset                (reset),
                          .segment0             (segment0[3:0]),
                          .segment1             (segment1[3:0]),
                          .segment2             (segment2[3:0]),
                          .segment3             (segment3[3:0]));
   
   
endmodule // pb_display
