//                              -*- Mode: Verilog -*-
// Filename        : soc.v
// Description     : SPI Test SoC
// Author          : Philip Tracton
// Created On      : Tue Jul 19 21:09:30 2016
// Last Modified By: Philip Tracton
// Last Modified On: Tue Jul 19 21:09:30 2016
// Update Count    : 0
// Status          : Unknown, Use with caution!


module soc (/*AUTOARG*/
   // Outputs
   TX, anode, cathode, sck_o, ncs_o, mosi_o,
   // Inouts
   switches, leds, push_buttons,
   // Inputs
   clk_in, reset_in, RX, miso_i, int1, int2
   ) ;
   
   input clk_in;
   input reset_in;
   
   inout [15:0] switches;
   inout [15:0] leds;
   inout [3:0]  push_buttons;
   
   input        RX;
   output       TX;
   
   output [3:0] anode;
   output [7:0] cathode;

   output wire  sck_o;
   output wire  ncs_o;
   output wire  mosi_o;
   input wire   miso_i;
   input wire   int1;
   input wire   int2;
   
   wire [3:0]   anode;
   wire [7:0]   cathode;
   wire         TX;
   wire [15:0]  leds;
   wire [15:0]  switches;
   wire         clk_sys;                // From sys_con of system_controller.v
   wire         interrupt_ack;          // From picoblaze_cpu of cpu.v
   wire         locked;                 // From sys_con of system_controller.v
   wire [7:0]   out_port;               // From picoblaze_cpu of cpu.v
   wire [7:0]   port_id;                // From picoblaze_cpu of cpu.v
   wire         read_strobe;            // From picoblaze_cpu of cpu.v
   wire         reset_sys;              // From sys_con of system_controller.v
   wire         write_strobe;           // From picoblaze_cpu of cpu.v
   wire [7:0]   in_port;

   //
   // Peripheral's Data Bus
   //
   wire [7:0]   sw0_out_port;
   wire [7:0]   sw1_out_port;
   wire [7:0]   led0_out_port;
   wire [7:0]   led1_out_port;
   wire [7:0]   uart_data_out;   
   wire [7:0]   display_data_out;
   wire [7:0]   buttons_out_port;
   wire [7:0]   spi_out_port;

   //
   // Interrupts
   // 
   wire         spi_interrupt;
   wire         uart_interrupt;
   wire         button_interrupt;
   
   //
   // Clock and Reset System Controller
   //

   system_controller sys_con(
                             // Outputs
                             .reset_sys(reset_sys), 
                             .clk_sys(clk_sys), 
                             .locked(locked),
                             // Inputs
                             .clk_in(clk_in), 
                             .reset_in(reset_in)
                             );

   assign interrupt = uart_interrupt | button_interrupt | spi_interrupt;
   assign kcpsm6_sleep = 1'b0;   
   cpu picoblaze(
                 // Outputs
                 .port_id(port_id), 
                 .out_port(out_port), 
                 .write_strobe(write_strobe), 
                 .read_strobe(read_strobe), 
                 .interrupt_ack(interrupt_ack),
                 // Inputs
                 .clk_sys(clk_sys), 
                 .in_port(in_port), 
                 .interrupt(interrupt), 
                 .kcpsm6_sleep(kcpsm6_sleep), 
                 .reset_sys(reset_sys)
                 ) ;

   assign in_port = sw0_out_port | sw1_out_port | led0_out_port | led1_out_port | uart_data_out |  display_data_out | buttons_out_port | spi_out_port;
   
   
   pb_gpio #(.GPIO_BASE_ADDRESS(8'h00))
   sw0(
       // Outputs
       .data_out(sw0_out_port), 
       .interrupt(),
       // Inouts
       .gpio(switches[7:0]),
       // Inputs
       .clk(clk_sys), 
       .reset(reset_sys), 
       .port_id(port_id), 
       .data_in(out_port), 
       .read_strobe(read_strobe), 
       .write_strobe(write_strobe)
       ) ;
   
   pb_gpio #(.GPIO_BASE_ADDRESS(8'h10))
   sw1(
       // Outputs
       .data_out(sw1_out_port), 
       .interrupt(),
       // Inouts
       .gpio(switches[15:8]),
       // Inputs
       .clk(clk_sys), 
       .reset(reset_sys), 
       .port_id(port_id), 
       .data_in(out_port), 
       .read_strobe(read_strobe), 
       .write_strobe(write_strobe)
       ) ;
   
   pb_gpio #(.GPIO_BASE_ADDRESS(8'h20))
   led0(
        // Outputs
        .data_out(led0_out_port), 
        .interrupt(),
        // Inouts
        .gpio(leds[7:0]),
        // Inputs
        .clk(clk_sys), 
        .reset(reset_sys), 
        .port_id(port_id), 
        .data_in(out_port), 
        .read_strobe(read_strobe), 
        .write_strobe(write_strobe)
        ) ;
   
   pb_gpio #(.GPIO_BASE_ADDRESS(8'h30))
   led1(
        // Outputs
        .data_out(led1_out_port), 
        .interrupt(),
        // Inouts
        .gpio(leds[15:8]),
        // Inputs
        .clk(clk_sys), 
        .reset(reset_sys), 
        .port_id(port_id), 
        .data_in(out_port), 
        .read_strobe(read_strobe), 
        .write_strobe(write_strobe)
        ) ;

   pb_uart #(.BASE_ADDRESS(8'h40))
   uart(
        // Outputs
        .TX(TX), 
        .data_out(uart_data_out), 
        .interrupt(uart_interrupt),
        // Inputs
        .clk(clk_sys), 
        .reset(reset_sys), 
        .RX(RX), 
        .port_id(port_id), 
        .data_in(out_port), 
        .read_strobe(read_strobe), 
        .write_strobe(write_strobe)
        ) ;

   //
   // Display
   //
   pb_display #(.BASE_ADDRESS(8'h50))
   seven_segments(
                  // Outputs
                  .data_out(display_data_out), 
                  .anode(anode), 
                  .cathode(cathode),
                  // Inputs
                  .clk(clk_sys), 
                  .reset(reset_sys), 
                  .port_id(port_id), 
                  .data_in(out_port), 
                  .read_strobe(read_strobe), 
                  .write_strobe(write_strobe)
                  ) ;  

   wire [3:0]   button_disconnect;
   
   pb_gpio #(.GPIO_BASE_ADDRESS(8'h60))
   buttons(
           // Outputs
           .data_out(buttons_out_port), 
           .interrupt(button_interrupt),
           // Inouts
           .gpio({button_disconnect, push_buttons}),
           // Inputs
           .clk(clk_sys), 
           .reset(reset_sys), 
           .port_id(port_id), 
           .data_in(out_port), 
           .read_strobe(read_strobe), 
           .write_strobe(write_strobe)
           ) ; 
   
   pb_spi #(.BASE_ADDRESS(8'h70)) spi(
                                      // Outputs
                                      .data_out(spi_out_port), 
                                      .interrupt(spi_interrupt), 
                                      .sck_o(sck_o), 
                                      .ncs_o(ncs_o), 
                                      .mosi_o(mosi_o),
                                      
                                      // Inputs
                                      .clk(clk_sys), 
                                      .reset(reset_sys), 
                                      .port_id(port_id), 
                                      .data_in(out_port), 
                                      .read_strobe(read_strobe), 
                                      .write_strobe(write_strobe), 
                                      .miso_i(miso_i)
                                      );
   
endmodule // soc
