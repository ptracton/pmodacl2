//                              -*- Mode: Verilog -*-
// Filename        : adxl362_testbench.v
// Description     : Testbench for proving ADXL362 Model works
// Author          : Philip Tracton
// Created On      : Wed Jun 22 21:42:09 2016
// Last Modified By: Philip Tracton
// Last Modified On: Wed Jun 22 21:42:09 2016
// Update Count    : 0
// Status          : Unknown, Use with caution!

`include "timescale.v"
`include "simulation_includes.vh"

module adxl362_testbench (/*AUTOARG*/ ) ;

   //
   // Creates a clock, reset, a timeout in case the sim never stops,
   // and pass/fail managers
   //

`include "test_management.v"


   wire wb_clk;
   wire wb_rst;

   //
   // Bus matrix between masters and slaves
   //
`include "testbench_intercon.vh"   
   assign wb_clk = clk;
   assign wb_rst = reset;
   
   
   //
   // Bus Master
   //
   wb_bfm_master master_bfm(
                            .wb_clk_i(wb_clk),
                            .wb_rst_i(wb_rst),
                            .wb_adr_o(wb_m2s_bfm_adr),
                            .wb_dat_o(wb_m2s_bfm_dat),
                            .wb_sel_o(wb_m2s_bfm_sel),
                            .wb_we_o (wb_m2s_bfm_we ),
                            .wb_cyc_o(wb_m2s_bfm_cyc),
                            .wb_stb_o(wb_m2s_bfm_stb),
                            .wb_cti_o(wb_m2s_bfm_cti),
                            .wb_bte_o(wb_m2s_bfm_bte),
                            .wb_dat_i(wb_s2m_bfm_dat),
                            .wb_ack_i(wb_s2m_bfm_ack),
                            .wb_err_i(wb_s2m_bfm_err),
                            .wb_rty_i(wb_s2m_bfm_rty));   


   wire sclk;
   wire miso;
   wire mosi;
   reg  ncs = 1;
   wire int1;
   wire int2;   
   wire simple_spi_int;
   
   simple_spi_top spi(
                      // 8bit WISHBONE bus slave interface
                      .clk_i(wb_clk), // clock
                      .rst_i(!wb_rst), // reset (asynchronous active low)
                      .cyc_i(wb_m2s_spi_cyc), // cycle
                      .stb_i(wb_m2s_spi_stb), // strobe
                      .adr_i(wb_m2s_spi_adr[1:0]), // address
                      .we_i (wb_m2s_spi_we), // write enable
                      .dat_i(wb_m2s_spi_dat), // data input
                      .dat_o(wb_s2m_spi_dat), // data output
                      .ack_o(wb_s2m_spi_ack), // normal bus termination
                      .inta_o(simple_spi_int), // interrupt output

                      // SPI port
                      .sck_o(sck), // serial clock output
                      .mosi_o(mosi), // MasterOut SlaveIN
                      .miso_i(miso)   // MasterIn SlaveOut
                      );
   
   adxl362 accelerometer(
                         .SCLK(sck),
                         .MOSI(mosi),
                         .nCS(ncs),
                         .MISO(miso),
                         .INT1(int1),
                         .INT2(int2)                         
                         );
   

   //
   // Tasks used to interface with ADXL362
   //
   adxl362_tasks adxl362_tasks();
      
   //
   // Tasks used to help test cases
   //
   test_tasks test_tasks();
   
   //
   // The actual test cases that are being tested
   //
   test_case test_case();
   
endmodule // adxl362_testbench
