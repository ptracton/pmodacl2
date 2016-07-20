
`include "simulation_includes.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/31/2015 10:08:26 PM
// Design Name: 
// Module Name: testbench
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


module soc_testbench;
`include "test_management.v"

   reg [31:0] read_word;


   //
   // Display
   //
   wire [3:0] anode;                  // From dut of display.v
   wire [7:0] cathode;                // From dut of display.v

   wire [15:0] leds;
   reg [15:0]  switches_reg = 16'h0000;
   wire [15:0] switches = switches_reg;
   reg [3:0]   push_buttons_regs = 4'h0;   
   wire [3:0]  push_buttons = push_buttons_regs;

   wire        sck_o;
   wire        ncs_o;
   wire        mosi_o;
   wire        miso_i;

   wire wb_clk = clk;
   wire wb_rst = reset;
   
   soc dut(
           // Outputs
           .leds(leds), 
           .TX(TX), 
           .anode(anode), 
           .cathode(cathode),
           .sck_o(sck_o),
           .ncs_o(ncs_o),
           .mosi_o(mosi_o),
           
           // Inputs
           .miso_i(miso_i),
           .int1(int1),
           .int2(int2),
           .clk_in(clk), 
           .reset_in(reset), 
           .switches(switches),
           .push_buttons(push_buttons), 
           .RX(RX)            
           );   
   
   /****************************************************************************
    UART 0 

    The WB UART16550 from opencores is used here to simulate a UART on the other end
    of the cable.  It will allow us to send/receive characters to the NGMCU firmware
    ***************************************************************************/

   wire [31:0] uart0_adr;
   wire [31:0] uart0_dat_o;
   wire [31:0] uart0_dat_i;
   wire [3:0]  uart0_sel;
   wire        uart0_cyc;
   wire        uart0_stb;
   wire        uart0_we;
   wire        uart0_ack;
   wire        uart0_int;

   assign      uart0_dat_o[31:8] = 'b0;

   uart_top uart0(
                  .wb_clk_i(clk),
                  .wb_rst_i(reset),

                  .wb_adr_i(uart0_adr[4:0]),
                  .wb_dat_o(uart0_dat_o),
                  .wb_dat_i(uart0_dat_i),
                  .wb_sel_i(uart0_sel),
                  .wb_cyc_i(uart0_cyc),
                  .wb_stb_i(uart0_stb),
                  .wb_we_i(uart0_we),
                  .wb_ack_o(uart0_ack),
                  .int_o(uart0_int),
                  .stx_pad_o(RX),
                  .srx_pad_i(TX),

                  .rts_pad_o(),
                  .cts_pad_i(1'b0),
                  .dtr_pad_o(),
                  .dsr_pad_i(1'b0),
                  .ri_pad_i(1'b0),
                  .dcd_pad_i(1'b0),

                  .baud_o()
                  );


   wb_mast uart_master0(
                        .clk (clk),
                        .rst (reset),
                        .adr (uart0_adr),
                        .din (uart0_dat_o),
                        .dout(uart0_dat_i),
                        .cyc (uart0_cyc),
                        .stb (uart0_stb),
                        .sel (uart0_sel),
                        .we  (uart0_we ),
                        .ack (uart0_ack),
                        .err (1'b0),
                        .rty (1'b0)
                        );

   uart_tasks uart_tasks();   

   /****************************************************************************
    
    ADXL362 SPI Accelerometer
    
    ***************************************************************************/
   adxl362 adxl362(
                   .SCLK(sck),
                   .MOSI(mosi),
                   .nCS(ncs),
                   .MISO(miso),
                   .INT1(int1),
                   .INT2(int2)                         
                   );
   
   /****************************************************************************
    
    TEST SUPPORT
    
    ***************************************************************************/

   //
   // Tasks used to interface with ADXL362
   //
   spi_tasks spi_tasks();
     
   
   //
   // Tasks used to help test cases
   //
   test_tasks test_tasks();
   
   //
   // The actual test cases that are being tested
   //
   test_case test_case();   
   
/* -----\/----- EXCLUDED -----\/-----
   
   reg         uart_passed = 0;
   reg         leds_passed = 0;
   reg         buttons_passed = 0;
   
   always @(*)
     test_passed <= uart_passed & leds_passed & buttons_passed;
      
   

   initial begin
      @(posedge reset);
      @(negedge reset);

      #100;
      `UART_CONFIG;
      `UART_WRITE_CHAR(8'h30);
      `UART_WRITE_CHAR(8'h31);
      `UART_WRITE_CHAR(8'h32);
      `UART_WRITE_CHAR(8'h33);
      `UART_WRITE_CHAR(8'h34);
      `UART_WRITE_CHAR(8'h35);

      `UART_WRITE_CHAR(8'h36);
      `UART_WRITE_CHAR(8'h37);
      `UART_WRITE_CHAR(8'h38);
      `UART_WRITE_CHAR(8'h39);

   end // initial begin

   initial begin
      @(posedge reset);
      @(negedge reset);

      #100;

      //`UART_READ_CHAR(8'h30);
      `UART_READ_CHAR(8'h31);
      `UART_READ_CHAR(8'h32);
      `UART_READ_CHAR(8'h33);
      `UART_READ_CHAR(8'h34);
      `UART_READ_CHAR(8'h35);
      `UART_READ_CHAR(8'h36);
      `UART_READ_CHAR(8'h37);
      `UART_READ_CHAR(8'h38);
      `UART_READ_CHAR(8'h39);

      push_buttons_regs[0] = 1;
      @(posedge dut.interrupt);
      push_buttons_regs[0] = 0;
      
      `UART_READ_CHAR("U");
      `UART_READ_CHAR("p");
      `UART_READ_CHAR("U");
      `UART_READ_CHAR("p");
      `UART_READ_CHAR("U");
      `UART_READ_CHAR("p");
      
      repeat (3000) @(posedge clk);

      push_buttons_regs[1] = 1;
      @(posedge dut.interrupt);
      push_buttons_regs[1] = 0;
      `UART_READ_CHAR("R");
      `UART_READ_CHAR("i");
      `UART_READ_CHAR("g");
      `UART_READ_CHAR("h");
      `UART_READ_CHAR("t");

      repeat (3000) @(posedge clk);
      push_buttons_regs[2] = 1;
      @(posedge dut.interrupt);
      push_buttons_regs[2] = 0;
      `UART_READ_CHAR("D");
      `UART_READ_CHAR("o");
      `UART_READ_CHAR("w");
      `UART_READ_CHAR("n");

      repeat (3000) @(posedge clk);
      push_buttons_regs[3] = 1;
      @(posedge dut.interrupt);
      push_buttons_regs[3] = 0;
      `UART_READ_CHAR("L");
      `UART_READ_CHAR("e");
      `UART_READ_CHAR("f");
      `UART_READ_CHAR("t");
      
      #100;
      uart_passed <= 1'b1;      
   end


   initial begin
      @(posedge reset);
      @(negedge reset);
      #20000;

      switches_reg <= 16'hFFFF;
      @(leds == 16'hFFFF);

      #100;
      switches_reg <= 16'h0000;
      @(leds == 16'h0000);

      #100;
      switches_reg <= 16'h5555;
      @(leds == 16'h5555);
      
      #100;
      switches_reg <= 16'hAAAA;
      @(leds == 16'hAAAA); 

      leds_passed <= 1;      
     
   end
   
   initial begin
      #10000000;
      test_failed <= 1'b1;      
   end   
 -----/\----- EXCLUDED -----/\----- */

/* -----\/----- EXCLUDED -----\/-----
   initial begin
      @(posedge reset);
      @(negedge reset);
      #2000;
      push_buttons_regs[0] = 1;
      repeat (300) @(posedge clk);
      push_buttons_regs[0] = 0;
      repeat (20) @(posedge clk);

      repeat (3000) @(posedge clk);
      
      push_buttons_regs[1] = 1;
      repeat (300) @(posedge clk);
      push_buttons_regs[1] = 0;
      repeat (20) @(posedge clk);

      repeat (3000) @(posedge clk);
      
      push_buttons_regs[2] = 1;
      repeat (300) @(posedge clk);
      push_buttons_regs[2] = 0;
      repeat (20) @(posedge clk);

      repeat (3000) @(posedge clk);
      
      push_buttons_regs[3] = 1;
      repeat (300) @(posedge clk);
      push_buttons_regs[3] = 0;
      repeat (20) @(posedge clk);
      
      buttons_passed = 1;
      
   end
 -----/\----- EXCLUDED -----/\----- */
   
endmodule
