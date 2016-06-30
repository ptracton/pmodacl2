//                              -*- Mode: Verilog -*-
// Filename        : wb_dsp_includes.vh
// Description     : Include file for WB DSP Testing
// Author          : Philip Tracton
// Created On      : Wed Dec  2 13:38:15 2015
// Last Modified By: Philip Tracton
// Last Modified On: Wed Dec  2 13:38:15 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

`include "adxl362_registers.vh"

`define TB          adxl362_testbench
`define WB_RST      `TB.wb_rst
`define WB_CLK      `TB.wb_clk

`define ADXL362     `TB.adxl362
`define ADXL362_ACCELEROMETER `ADXL362.accelerometer

`define TEST_CASE       `TB.test_case
`define SIMULATION_NAME `TEST_CASE.simulation_name
`define NUMBER_OF_TESTS `TEST_CASE.number_of_tests

`define SPI_BASE_ADDRESS            32'h1000_0000
`define SPI_CONTROL_REG_ADDRESS     `SPI_BASE_ADDRESS + 32'h0000_0000
`define SPI_STATUS_REG_ADDRESS      `SPI_BASE_ADDRESS + 32'h0000_0004
`define SPI_DATA_REG_ADDRESS        `SPI_BASE_ADDRESS + 32'h0000_0008
`define SPI_EXTENSION_REG_ADDRESS   `SPI_BASE_ADDRESS + 32'h0000_000C



`define ADXL362_TASKS `TB.adxl362_tasks
`define ADXL362_NCS   `TB.ncs
`define ADXL362_WRITE_REGISTER `ADXL362_TASKS.write_single_register
`define ADXL362_READ_REGISTER `ADXL362_TASKS.read_single_register
`define ADXL362_CHECK_REGISTER `ADXL362_TASKS.check_single_register
`define ADXL362_CHECK_DOUBLE_REGISTER `ADXL362_TASKS.check_double_register
`define ADXL362_WRITE_DOUBLE_REGISTER `ADXL362_TASKS.write_double_register
`define ADXL362_WRITE_BURST_REGISTERS `ADXL362_TASKS.write_burst_registers
`define ADXL362_READ_BURST_REGISTERS `ADXL362_TASKS.read_burst_registers
`define SIMPLE_SPI_INIT  `ADXL362_TASKS.init_simple_spi
`define SIMPLE_SPI_IRQ `TB.simple_spi_int

`define TEST_TASKS  `TB.test_tasks
`define TEST_PASSED `TEST_TASKS.test_passed
`define TEST_FAILED `TEST_TASKS.test_failed
`define TEST_COMPARE  `TEST_TASKS.compare_values
`define TEST_COMPLETE `TEST_TASKS.all_tests_completed
