//                              -*- Mode: Verilog -*-
// Filename        : adxl362_fifo.v
// Description     : ADXL362 512 element FIFO
// Author          : Philip Tracton
// Created On      : Thu Jun 23 20:54:03 2016
// Last Modified By: Philip Tracton
// Last Modified On: Thu Jun 23 20:54:03 2016
// Update Count    : 0
// Status          : Unknown, Use with caution!

module adxl362_fifo (/*AUTOARG*/
   // Outputs
   data_rd, fifo_empty,
   // Inputs
   read, write, flush, data_wr, clk_read, enable
   ) ;
   parameter WIDTH = 16;
   parameter DEPTH = 512;
   parameter INDEX_WIDTH = $clog2(DEPTH);
   
   input wire read;
   input wire write;
   input wire flush;   
   input wire [WIDTH-1:0] data_wr;
   output wire [WIDTH-1:0] data_rd;
   output wire             fifo_empty;
   input wire              clk_read;
   input wire              enable;
   
   
   reg [WIDTH-1:0]         fifo [0:DEPTH-1];
   reg [INDEX_WIDTH-1:0]   read_ptr = 0;
   reg [INDEX_WIDTH-1:0]   write_ptr = 0;
   
   //
   // If the pointers are the same the FIFO is empty.
   // Outside blocks should operate on this signal going low
   // which will indicate there is data in FIFO.
   //
   assign fifo_empty = (read_ptr == write_ptr);

   //
   // Always present the read data as soon as the pointer
   // is updated.  This allows the outside blocks to read when
   // easy for them.
   //
   assign data_rd = fifo[read_ptr];

   //
   // Write the data into the FIFO
   // Increment pointer.  The pointer will automatically wrap
   // around since it is a 32 element fifo with a 5 bit pointer
   //
   always @(posedge write) begin
      if (enable) begin
         fifo[write_ptr] <= data_wr;
         write_ptr <= write_ptr + 1;
      end
   end

   //
   // Read pointer increment
   // Increment pointer.  The pointer will automatically wrap
   // around since it is a 32 element fifo with a 5 bit pointer
   //   
   always @(posedge clk_read) begin
      if (read & !flush & enable) begin
         read_ptr <= read_ptr + 1;
      end
   end


   //
   // Flush FIFO
   //
   // Dumps all data and resets the pointers
   //
   always @(posedge flush) begin
      read_ptr <= 0;
      write_ptr <= 0;      
   end
endmodule // adxl362_fifo
