//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/22/2015 09:29:50 PM
// Design Name: 
// Module Name: system_controller
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

module system_controller(/*AUTOARG*/
   // Outputs
   clk_sys, reset_sys, locked,
   // Inputs
   clk_in, reset_in
   );
   input clk_in;
   output clk_sys;
   input  reset_in;
   output reset_sys;   
   output locked;
   
    
   //
   // Input buffer to make sure the XCLK signal is routed
   // onto the low skew clock lines
   //
   wire                         xclk_buf;
   IBUFG xclk_ibufg(.I(clk_in), .O(xclk_buf));
   
   
   wire                         locked;

   assign reset_sys = reset_in | ~locked | |reset_count;   
   
   reg [5:0]                    reset_count = 6'h0;
   always @(posedge xclk_buf)
     if (reset_in | ~locked) begin
        reset_count <= 6'h1;        
     end else begin
        if (reset_count) begin
           reset_count <= reset_count + 1;           
        end
     end
   
   //   
   // Clock buffer that ensures the clock going out to the hardware is on a low skew line
   //

   BUFG clk_bug (
                 .O(clk_sys), // 1-bit output Clock buffer output
                 .I(CLKFBOUT) // 1-bit input Clock buffer input (S=0)
                 );

   clk_wiz_0 lab9_clocks
     (
      // Clock in ports
      .clk_in1(xclk_buf),      // input clk_in1
      // Clock out ports
      .clk_out1(CLKFBOUT),     // output clk_out1
      // Status and control signals
      .reset(reset_in), // input reset
      .locked(locked));      // output locked
   
endmodule // system_controller

