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
   clk
   ) ;

   output reg clk;
   
   
   //
   // Free Running 51.2 KHz clock
   //
   initial begin
      clk <= 1'b0;
      forever begin
         #976 clk <= ~clk;         
      end
   end
endmodule // adxl362_system_controller
