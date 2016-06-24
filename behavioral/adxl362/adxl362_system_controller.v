//                              -*- Mode: Verilog -*-
// Filename        : adxl362_system_controller.v
// Description     : ADXL362 System Controller
// Author          : Philip Tracton
// Created On      : Thu Jun 23 20:54:55 2016
// Last Modified By: Philip Tracton
// Last Modified On: Thu Jun 23 20:54:55 2016
// Update Count    : 0
// Status          : Unknown, Use with caution!

module adxl362_system_controller (/*AUTOARG*/
   // Outputs
   clk, clk_16mhz, reset,
   // Inputs
   soft_reset
   ) ;

   output reg clk;
   output reg clk_16mhz;
   output wire reset;
   input wire soft_reset;

   //
   // Reset Logic
   //
   reg [5:0]  reset_count = 0;
   reg        por = 1;
   assign reset = |reset_count;
   
   always @(posedge clk_16mhz)
     if (por || soft_reset) begin
        reset_count <= 1;
        por <= 0;        
     end else begin
        if (reset)
          reset_count <= reset_count + 1;        
     end
     
   //
   // Free Running 51.2 KHz clock
   //
   initial begin
      clk <= 1'b0;
      forever begin
         #9803 clk <= ~clk;         
      end
   end

   //
   // Free Running 16MHz clock
   //
   // Added this in to work out SPI/Register access
   //
   initial begin
      clk_16mhz <= 1'b0;
      forever begin
         #31 clk_16mhz <= ~clk_16mhz;         
      end
   end
endmodule // adxl362_system_controller
