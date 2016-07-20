+define+VERBOSE
+define+SIM
+define+RTL_SIM
      
+incdir+../testbench
+incdir+../rtl_simulation
+incdir+../rtl
+incdir+../soc      
+incdir+../behavioral/verilog_utils/
+incdir+../behavioral/adxl362/


../testbench/soc_testbench.v
../testbench/test_tasks.v
../testbench/spi_tasks.v      
../testbench/dump.v


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
