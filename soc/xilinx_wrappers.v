//                              -*- Mode: Verilog -*-
// Filename        : xilinx_wrappers.v
// Description     : Wrapper around some Xilinx primitives
// Author          : Philip Tracton
// Created On      : Fri Jul 22 11:32:06 2016
// Last Modified By: Philip Tracton
// Last Modified On: Fri Jul 22 11:32:06 2016
// Update Count    : 0
// Status          : Unknown, Use with caution!


module FD (/*AUTOARG*/
   // Outputs
   Q,
   // Inputs
   C, D
   ) ;
   input C;
   input D;
   output reg Q;

   always @(posedge C)
     Q <= D;      
endmodule // FD


module FDR (/*AUTOARG*/
   // Outputs
   Q,
   // Inputs
   C, R, D
   ) ;
   input C;
   input R;
   input D;
   output reg Q;

   always @(posedge C or posedge R)
     if (R) begin
        Q <= 0;        
     end else begin
        Q <= D;        
     end
   
endmodule // FDR
