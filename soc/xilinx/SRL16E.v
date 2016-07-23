///////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995/2014 Xilinx, Inc.
// All Right Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor : Xilinx
// \   \   \/     Version : Version : 2014.4
//  \   \         Description : Xilinx Unified Simulation Library Component
//  /   /                  16-Bit Shift Register Look-Up-Table with Clock Enable
// /___/   /\     Filename : SRL16E.v
// \   \  /  \
//  \___\/\___\
//
///////////////////////////////////////////////////////////////////////////////
// Revision:
//    03/23/04 - Initial version.
//    03/11/05 - Add LOC paramter;
//    05/07/08 - Add negative setup/hold support (CR468872)
//    12/13/11 - Added `celldefine and `endcelldefine (CR 524859).
//    04/16/13 - PR683925 - add invertible pin support.
// End Revision
///////////////////////////////////////////////////////////////////////////////

`timescale 1 ps/1 ps

`celldefine

module SRL16E #(
  `ifdef XIL_TIMING
  parameter LOC = "UNPLACED",
  `endif
  parameter [15:0] INIT = 16'h0000,
  parameter [0:0] IS_CLK_INVERTED = 1'b0
)(
  output Q,
  
  input A0,
  input A1,
  input A2,
  input A3,
  input CE,
  input CLK,
  input D
);
  
  wire IS_CLK_INVERTED_BIN;

  wire [3:0] A_in;
  wire CE_in;
  wire CLK_in;
  wire D_in;

`ifdef XIL_TIMING
  wire CE_dly;
  wire CLK_dly;
  wire D_dly;

  assign CE_in = CE_dly;
  assign CLK_in = IS_CLK_INVERTED_BIN ^ CLK_dly;
  assign D_in = D_dly;

  reg notifier;
    
  wire sh_clk_en_p;
  wire sh_clk_en_n;
  wire sh_ce_clk_en_p;
  wire sh_ce_clk_en_n;
`else
  assign CE_in = CE ;
  assign CLK_in = IS_CLK_INVERTED_BIN ^ CLK;
  assign D_in = D ;
`endif

  assign A_in = {A3, A2, A1, A0};
  assign IS_CLK_INVERTED_BIN = IS_CLK_INVERTED;

  reg  [15:0] data;
  reg first_time = 1'b1;

  initial
  begin
    assign  data = INIT;
    first_time <= #100000 1'b0;
    while ((CLK_in !== 1'b0) && (first_time == 1'b1)) #1000;
    deassign data;
  end

  always @(posedge CLK_in) 
    if (CE_in == 1'b1) 
      data[15:0] <=  #100 {data[14:0], D_in};

  assign Q = data[A_in];

`ifdef XIL_TIMING

  always @(notifier) 
    data[0] = 1'bx;

  assign sh_clk_en_p = ~IS_CLK_INVERTED_BIN;
  assign sh_clk_en_n = IS_CLK_INVERTED_BIN;
  assign sh_ce_clk_en_p = CE_in && ~IS_CLK_INVERTED_BIN;
  assign sh_ce_clk_en_n = CE_in && IS_CLK_INVERTED_BIN;

  specify
    (A0 => Q) = (0:0:0, 0:0:0);
    (A1 => Q) = (0:0:0, 0:0:0);
    (A2 => Q) = (0:0:0, 0:0:0);
    (A3 => Q) = (0:0:0, 0:0:0);
    (CLK => Q) = (0:0:0, 0:0:0);
    $period (negedge CLK, 0:0:0, notifier);
    $period (posedge CLK, 0:0:0, notifier);
    $setuphold (negedge CLK, negedge CE, 0:0:0, 0:0:0, notifier,sh_clk_en_n,sh_clk_en_n,CLK_dly,CE_dly);
    $setuphold (negedge CLK, negedge D, 0:0:0, 0:0:0, notifier,sh_ce_clk_en_n,sh_ce_clk_en_n,CLK_dly,D_dly);
    $setuphold (negedge CLK, posedge CE, 0:0:0, 0:0:0, notifier,sh_clk_en_n,sh_clk_en_n,CLK_dly,CE_dly);
    $setuphold (negedge CLK, posedge D, 0:0:0, 0:0:0, notifier,sh_ce_clk_en_n,sh_ce_clk_en_n,CLK_dly,D_dly);
    $setuphold (posedge CLK, negedge CE, 0:0:0, 0:0:0, notifier,sh_clk_en_p,sh_clk_en_p,CLK_dly,CE_dly);
    $setuphold (posedge CLK, negedge D, 0:0:0, 0:0:0, notifier,sh_ce_clk_en_p,sh_ce_clk_en_p,CLK_dly,D_dly);
    $setuphold (posedge CLK, posedge CE, 0:0:0, 0:0:0, notifier,sh_clk_en_p,sh_clk_en_p,CLK_dly,CE_dly);
    $setuphold (posedge CLK, posedge D, 0:0:0, 0:0:0, notifier,sh_ce_clk_en_p,sh_ce_clk_en_p,CLK_dly,D_dly);
    $width (negedge CLK, 0:0:0, 0, notifier);
    $width (posedge CLK, 0:0:0, 0, notifier);
    specparam PATHPULSE$ = 0;
  endspecify
`endif

endmodule

`endcelldefine
