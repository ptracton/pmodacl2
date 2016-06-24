//                              -*- Mode: Verilog -*-
// Filename        : wb_dsp_includes.vh
// Description     : Include file for WB DSP Testing
// Author          : Philip Tracton
// Created On      : Wed Dec  2 13:38:15 2015
// Last Modified By: Philip Tracton
// Last Modified On: Wed Dec  2 13:38:15 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!



`define TB          adxl362_testbench
`define WB_RST      `TB.wb_rst
`define WB_CLK      `TB.wb_clk

`define TEST_CASE       `TB.test_case
`define SIMULATION_NAME `TEST_CASE.simulation_name
`define NUMBER_OF_TESTS `TEST_CASE.number_of_tests

`define SPI_BASE_ADDRESS            32'h1000_0000
`define SPI_CONTROL_REG_ADDRESS     `SPI_BASE_ADDRESS + 32'h0000_0000
`define SPI_STATUS_REG_ADDRESS      `SPI_BASE_ADDRESS + 32'h0000_0004
`define SPI_DATA_REG_ADDRESS        `SPI_BASE_ADDRESS + 32'h0000_0008
`define SPI_EXTENSION_REG_ADDRESS   `SPI_BASE_ADDRESS + 32'h0000_000C

`define ADXL362_DEVID_AD          8'h00
`define ADXL362_DEVID_MST         8'h01
`define ADXL362_PARTID            8'h02
`define ADXL362_REVID             8'h03
`define ADXL362_XDATA             8'h08
`define ADXL362_YDATA             8'h09
`define ADXL362_ZDATA             8'h0A
`define ADXL362_STATUS            8'h0B
`define ADXL362_FIFO_ENTRIES_LOW  8'h0C
`define ADXL362_FIFO_ENTRIES_HIGH 8'h0D
`define ADXL362_XDATA_LOW         8'h0E
`define ADXL362_XDATA_HIGH        8'h0F
`define ADXL362_YDATA_LOW         8'h10
`define ADXL362_YDATA_HIGH        8'h11
`define ADXL362_ZDATA_LOW         8'h12
`define ADXL362_ZDATA_HIGH        8'h13
`define ADXL362_TEMP_LOW          8'h14
`define ADXL362_TEMP_HIGH         8'h15
`define ADXL362_SOFT_RESET        8'h1F
`define ADXL362_THRESH_ACT_LOW    8'h20
`define ADXL362_THRESH_ACT_HIGH   8'h21
`define ADXL362_TIME_ACT          8'h22
`define ADXL362_THRESH_INACT_LOW  8'h23
`define ADXL362_THRESH_INACT_HIGH 8'h24
`define ADXL362_TIME_INACT_LOW    8'h25
`define ADXL362_TIME_INACT_HIGH   8'h26
`define ADXL362_ACT_INACT_CTL     8'h27
`define ADXL362_FIFO_CONTROL      8'h28
`define ADXL362_FIFO_SAMPLES      8'h29
`define ADXL362_INTMAP1           8'h2A
`define ADXL362_INTMAP2           8'h2B
`define ADXL362_FILTER_CTL        8'h2C
`define ADXL362_POWER_CTL         8'h2D
`define ADXL362_SELF_TEST         8'h2E

`define ADXL362_COMMAND_WRITE     8'h0A
`define ADXL362_COMMAND_READ      8'h0B
`define ADXL362_COMMAND_FIFO      8'h0D

`define ADXL362_TASKS `TB.adxl362_tasks
`define ADXL362_NCS   `TB.ncs
`define ADXL362_WRITE_REGISTER `ADXL362_TASKS.write_single_register
`define SIMPLE_SPI_INIT  `ADXL362_TASKS.init_simple_spi

`define TEST_TASKS  `TB.test_tasks
`define TEST_PASSED `TEST_TASKS.test_passed
`define TEST_FAILED `TEST_TASKS.test_failed
`define TEST_COMPARE  `TEST_TASKS.compare_values
`define TEST_COMPLETE `TEST_TASKS.all_tests_completed
