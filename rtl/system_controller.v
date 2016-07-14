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
   clk, rst, sclk_o,
   // Inputs
   clk_i, rst_i, clk_enable
   ) ;
   input wire clk_i;
   input wire rst_i;
   input wire clk_enable;

   output wire clk;
   output wire rst;
   output wire sclk_o;

`ifdef XILINX
   //
   // Input buffer the clk pin
   //
   wire        clk_ibuf;
   IBUF xclk_ibufg(.I(clk_i), .O(clk_ibuf));
`else

   assign clk = clk_i;

   
   reg [2:0]   clk_count = 0;
   reg         sclk_free = 0;   
   assign sclk_o = (clk_enable) ? sclk_free: 1'b0;
   
   always @(posedge clk_i) begin
      if (rst_i) begin
         clk_count <=0;
         sclk_free <= 0;         
      end else begin
         clk_count <= clk_count + 1;
         if (&clk_count)begin
            sclk_free <= ~sclk_free;         
         end         
      end
   end
   
   reg [4:0] reset_count =0;
   assign rst = |reset_count;   
   always @(posedge clk_i or posedge rst_i)
     if (rst_i) begin
        reset_count <= 1;        
     end else begin
        if (reset_count)
          reset_count <= reset_count + 1;
     end
   
`endif
   
endmodule // system_controller
