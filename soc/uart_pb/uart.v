//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/22/2015 09:18:13 PM
// Design Name: 
// Module Name: uart
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart(/*AUTOARG*/
   // Outputs
   serial_out, receive_data, receive_data_preset, receive_half_full,
   receive_full, transmit_data_preset, transmit_half_full,
   transmit_full,
   // Inputs
   clk, reset, serial_in, buffer_read, transmit_data, buffer_write
   );
   
   input clk;
   input reset;
   input serial_in;
   output serial_out;

   //
   // Receive Signals
   //
   output [7:0] receive_data;
   input        buffer_read;
   output       receive_data_preset;
   output       receive_half_full;
   output       receive_full;

   //
   // Transmit Signals
   // 
   input [7:0]  transmit_data;
   input        buffer_write;
// input        buffer_write_delay;   
   output       transmit_data_preset;
   output       transmit_half_full;
   output       transmit_full;

   wire [7:0]            receive_data;
   wire                  receive_data_preset;
   wire                  receive_full;
   wire                  receive_half_full;
   wire                  serial_out;
   wire                  transmit_data_preset;
   wire                  transmit_full;
   wire                  transmit_half_full;
   wire                  baud_rate;
   
   /*AUTOWIRE*/
   /*AUTOREG*/
      
   uart_baud_generator baud_generator(
                                      // Outputs
                                      .baud_rate(baud_rate),
                                      // Inputs
                                      .clk(clk), 
                                      .reset(reset), 
                                      .enable(1'b1), 
                                      .clock_divide(8'h35)
                                      ) ;

   uart_tx6 transmit(
                     .data_in(transmit_data),
                     .buffer_write(buffer_write),
                     .buffer_reset(reset),
                     .en_16_x_baud(baud_rate),
                     .serial_out(serial_out),
                     .buffer_data_present(transmit_data_preset),
                     .buffer_half_full(transmit_half_full),
                     .buffer_full(transmit_full),
                     .clk(clk) 
                     );

   uart_rx6 receive(
                    .serial_in(serial_in),
                    .en_16_x_baud(baud_rate),
                    .data_out(receive_data),
                    .buffer_read(buffer_read),
                    .buffer_data_present(receive_data_preset),
                    .buffer_half_full(receive_half_full),
                    .buffer_full(receive_full),        
                    .buffer_reset(reset),
                    .clk(clk) );
   
endmodule // uart

