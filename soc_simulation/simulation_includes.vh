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

`define TB          soc_testbench
`define testbench   `TB
`define WB_RST      `TB.wb_rst
`define WB_CLK      `TB.wb_clk

`define LEDS         `TB.leds
`define SWITCHES     `TB.switches_reg
`define PUSH_BUTTONS `TB.push_buttons_reg
`define ANODE        `TB.anode
`define CATHODE      `TB.cathode

`define DUT `TB.dut
`define CPU `DUT.picoblaze
`define PROCESSOR `CPU.processor
`define PROGRAM_ROM `CPU.program_rom


`define ADXL362     `TB.adxl362
`define ADXL362_ACCELEROMETER `ADXL362.accelerometer
`define ADXL362_SPI_FIFO `ADXL362.spi.fifo
`define ADXL362_RESET `ADXL362.rst

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
`define ADXL362_INT1   `TB.int1
`define ADXL362_INT2   `TB.int2
`define ADXL362_WRITE_REGISTER `ADXL362_TASKS.write_single_register
`define ADXL362_READ_REGISTER `ADXL362_TASKS.read_single_register
`define ADXL362_CHECK_REGISTER `ADXL362_TASKS.check_single_register
`define ADXL362_CHECK_DOUBLE_REGISTER `ADXL362_TASKS.check_double_register
`define ADXL362_WRITE_DOUBLE_REGISTER `ADXL362_TASKS.write_double_register
`define ADXL362_WRITE_BURST_REGISTERS `ADXL362_TASKS.write_burst_registers
`define ADXL362_READ_BURST_REGISTERS `ADXL362_TASKS.read_burst_registers
`define ADXL362_READ_BURST_FIFO `ADXL362_TASKS.read_burst_fifo
`define SIMPLE_SPI_INIT  `ADXL362_TASKS.init_simple_spi
`define SIMPLE_SPI_IRQ `TB.simple_spi_int

`define TEST_TASKS  `TB.test_tasks
`define TEST_PASSED `TEST_TASKS.test_passed
`define TEST_FAILED `TEST_TASKS.test_failed
`define TEST_COMPARE  `TEST_TASKS.compare_values
`define TEST_COMPLETE `TEST_TASKS.all_tests_completed

`define UART_MASTER0      `testbench.uart_master0
`define UART_CLK          `testbench.clk

`define UART_CONFIG     `testbench.uart_tasks.uart_config
`define UART_WRITE_CHAR `testbench.uart_tasks.uart_write_char
`define UART_READ_CHAR  `testbench.uart_tasks.uart_read_char

// general defines
`define mS *1000000
`define nS *1
`define uS *1000
`define Wait #
`define wait #
`define khz *1000



// Taken from http://asciitable.com/
//
`define LINE_FEED       8'h0A
`define CARRIAGE_RETURN 8'h0D
`define SPACE_CHAR      8'h20
`define NUMBER_0        8'h30
`define NUMBER_9        8'h39
`define LETTER_A        8'h41
`define LETTER_Z        8'h5A
`define LETTER_a        8'h61
`define LETTER_f        8'h66
`define LETTER_z        8'h7a
