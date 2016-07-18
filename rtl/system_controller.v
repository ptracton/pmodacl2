//                              -*- Mode: Verilog -*-
// Filename        : system_controller.v
// Description     : Prototype System Controller for SPI FPGA
// Author          : Philip Tracton
// Created On      : Fri Jul  8 20:54:44 2016
// Last Modified By: Philip Tracton
// Last Modified On: Fri Jul  8 20:54:44 2016
// Update Count    : 0
// Status          : Unknown, Use with caution!

module system_controller (/*AUTOARG*/
   // Outputs
   clk, rst, nrst,
   // Inputs
   clk_i, rst_i
   ) ;
   input wire clk_i;
   input wire rst_i;

   output wire clk;
   output wire rst;
   output wire nrst;
   
`ifdef XILINX
   //
   // Input buffer the clk pin
   //
   wire        clk_ibuf;
   IBUF xclk_ibufg(.I(clk_i), .O(clk_ibuf));
`else

   assign clk = clk_i;

   


   
   reg [4:0] reset_count =0;
   assign rst = |reset_count; 
   assign nrst = ~rst;
   
   always @(posedge clk_i or posedge rst_i)
     if (rst_i) begin
        reset_count <= 1;        
     end else begin
        if (reset_count)
          reset_count <= reset_count + 1;
     end
   
`endif
   
endmodule // system_controller
