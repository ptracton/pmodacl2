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
   data_read, full, empty,
   // Inputs
   data_write, clk, rst, flush, read, write
   ) ;
   parameter WIDTH = 16;
   parameter DEPTH = 512;
   parameter INDEX_WIDTH = $clog2(DEPTH);

   output wire [WIDTH-1:0] data_read;
   output wire             full;
   output wire             empty;
   
   input wire [WIDTH-1:0]  data_write;
   input wire              clk;
   input wire              rst;
   input wire              flush;
   input wire              read;
   input wire              write;   
   
   

   //
   // This is the memory that holds the data
   //
   reg [WIDTH-1:0]         fifo [0:DEPTH-1];

   //
   // Pointer of where to read from the fifo memory
   //
   reg [INDEX_WIDTH-1:0]   read_ptr;
   wire [INDEX_WIDTH-1:0]  read_ptr1;

   //
   // Pointer to where to write to the fifo memory
   //    
   reg [INDEX_WIDTH-1:0]   write_ptr;
   wire [INDEX_WIDTH-1:0]  write_ptr1;

   //
   // Guarding bit for the empty/full wrap around situation
   //
   reg                     guard;

   //
   // On reset or flush, put the write pointer back to 0
   // On a write register the pointer's next address
   //
   always @(posedge clk)
     if (rst) begin
        write_ptr <= 0;        
     end else if (flush) begin
        write_ptr <= 0;        
     end else if (write) begin
        write_ptr <= write_ptr1;        
     end

   //
   // On a write this becomes the new write ptr
   //
   assign write_ptr1 = write_ptr + 1;

   //
   // Store data in the FIFO
   //
   always @(posedge write)
     if (write) begin
        fifo[write_ptr] <= data_write;        
     end
   
   //
   // On reset or flush, put the write pointer back to 0
   // On a read register the pointer's next address
   //
   always @(posedge clk)
     if (rst) begin
        read_ptr <= 0;        
     end else if (flush) begin
        read_ptr <= 0;        
     end else if (read) begin
        read_ptr <= read_ptr1;        
     end

   //
   // Pointer to the next read location
   //
   assign read_ptr1 = read_ptr + 1;

   //
   // Always present the latest data to be read by the next block
   //
   assign data_read = fifo[read_ptr];

   //
   // Guard Bit Logic
   //
   always @(posedge clk)
     if (rst) begin
        guard <= 0;        
     end else if (flush) begin
        guard <= 0;        
     end else if ((write_ptr1 == read_ptr) && write) begin
        guard <= 1;        
     end else if (read) begin
        guard <= 0;        
     end

   //
   // Read the last element and we are now empty
   //
   assign empty = (write_ptr == read_ptr) & !guard;

   //
   // Wrote the last available location, now full
   //
   assign full = (write_ptr == read_ptr) & guard;
   
endmodule // adxl362_fifo
