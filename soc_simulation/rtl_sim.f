+libext+.v
+define+VERBOSE
+define+SIM
+define+RTL_SIM
      
+incdir+../testbench
+incdir+../rtl_simulation
+incdir+../rtl
+incdir+../soc
+incdir+../soc/wb_master/
+incdir+../soc/tasks/
+incdir+../soc/wb_uart/
+incdir+../behavioral/verilog_utils/
+incdir+../behavioral/adxl362/
+incdir+$XILINX_VIVADO/data/verilog/src/
+incdir+$XILINX_VIVADO/data/verilog/src/unisims/

//$XILINX_VIVADO/data/verilog/src/glbl.v
//$XILINX_VIVADO/data/verilog/src/unisims/LUT6_2.v
//$XILINX_VIVADO/data/verilog/src/unisims/LUT6.v
//$XILINX_VIVADO/data/verilog/src/unisims/MUXCY.v
//$XILINX_VIVADO/data/verilog/src/unisims/XORCY.v
//$XILINX_VIVADO/data/verilog/src/unisims/RAM32M.v
//$XILINX_VIVADO/data/verilog/src/unisims/FDRE.v
//$XILINX_VIVADO/data/verilog/src/unisims/SRL16E.v
//$XILINX_VIVADO/data/verilog/src/unisims/RAMB18E1.v
//$XILINX_VIVADO/data/verilog/src/unisims/RAM64M.v


/cadtools/apps/Vivado/2015.1/data/verilog/src/glbl.v
/cadtools/apps/Vivado/2015.1/data/verilog/src/unisims/LUT6_2.v
/cadtools/apps/Vivado/2015.1/data/verilog/src/unisims/LUT6.v
/cadtools/apps/Vivado/2015.1/data/verilog/src/unisims/MUXCY.v
/cadtools/apps/Vivado/2015.1/data/verilog/src/unisims/XORCY.v
/cadtools/apps/Vivado/2015.1/data/verilog/src/unisims/RAM32M.v
/cadtools/apps/Vivado/2015.1/data/verilog/src/unisims/FDRE.v
/cadtools/apps/Vivado/2015.1/data/verilog/src/unisims/SRL16E.v
/cadtools/apps/Vivado/2015.1/data/verilog/src/unisims/RAMB18E1.v
/cadtools/apps/Vivado/2015.1/data/verilog/src/unisims/RAM64M.v
      
../testbench/soc_testbench.v
../testbench/test_tasks.v
../testbench/spi_tasks.v      
../testbench/dump.v
../soc/tasks/uart_tasks.v

//
// Simulation Tools
//
../soc/wb_master/wb_mast_model.v
../soc/wb_uart/raminfr.v
../soc/wb_uart/uart_debug_if.v
../soc/wb_uart/uart_defines.v
../soc/wb_uart/uart_receiver.v
../soc/wb_uart/uart_regs.v
../soc/wb_uart/uart_rfifo.v
../soc/wb_uart/uart_sync_flops.v
../soc/wb_uart/uart_tfifo.v
../soc/wb_uart/uart_top.v
../soc/wb_uart/uart_transmitter.v
../soc/wb_uart/uart_wb.v


//
// ADXL362 Accelerometer
//
../behavioral/adxl362/adxl362.v
../behavioral/adxl362/adxl362_system_controller.v
../behavioral/adxl362/adxl362_spi.v
../behavioral/adxl362/adxl362_regs.v      
../behavioral/adxl362/adxl362_fifo.v
../behavioral/adxl362/adxl362_accelerometer.v      

//
// SPI
//
../rtl/simple_spi_top_modified.v
../rtl/fifo4.v
../rtl/pb_spi.v
../rtl/spi_regs.v

//
// Display
//
../soc/display/display_regs.v
../soc/display/display.v
../soc/display/pb_display.v
../soc/display/timer.v

//
// GPIO
//
../soc/gpio/gpio_bit.v
../soc/gpio/gpio_regs.v
../soc/gpio/gpio.v
../soc/gpio/pb_gpio.v

//
// Picoblaze
//

../soc/picoblaze/cpu.v
../soc/picoblaze/kcpsm6.v
boot_rom.v

//
// System Controller
//
../soc/system_controller/system_controller.v

//
// UART
//
../soc/uart_pb/pb_uart_regs.v
../soc/uart_pb/pb_uart.v
../soc/uart_pb/uart_baud_generator.v
../soc/uart_pb/uart_rx6.v
../soc/uart_pb/uart_tx6.v
../soc/uart_pb/uart.v


//
// FPGA SoC Top
//
../soc/soc.v
../soc/xilinx_wrappers.v
