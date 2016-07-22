vlib work

vlog ../testbench/soc_testbench.v +incdir+../behavioral/adxl362/ +incdir+../testbench/
vlog ../testbench/test_tasks.v +incdir+../behavioral/adxl362/  +incdir+../testbench/
vlog ../testbench/spi_tasks.v +incdir+../behavioral/adxl362/ 
vlog ../testbench/dump.v +incdir+../behavioral/adxl362/ 
vlog ../soc/tasks/uart_tasks.v  +incdir+../behavioral/adxl362/  +incdir+../soc/tasks/


vlog ../soc/wb_master/wb_mast_model.v
vlog ../soc/wb_uart/raminfr.v
vlog ../soc/wb_uart/uart_debug_if.v +incdir+../testbench/
vlog ../soc/wb_uart/uart_defines.v 
vlog ../soc/wb_uart/uart_receiver.v +incdir+../testbench/ 
vlog ../soc/wb_uart/uart_regs.v  +incdir+../testbench/
vlog ../soc/wb_uart/uart_rfifo.v  +incdir+../testbench/
vlog ../soc/wb_uart/uart_sync_flops.v  +incdir+../testbench/
vlog ../soc/wb_uart/uart_tfifo.v  +incdir+../testbench/
vlog ../soc/wb_uart/uart_top.v  +incdir+../testbench/
vlog ../soc/wb_uart/uart_transmitter.v  +incdir+../testbench/
vlog ../soc/wb_uart/uart_wb.v  +incdir+../testbench/



vlog ../behavioral/adxl362/adxl362.v
vlog ../behavioral/adxl362/adxl362_system_controller.v +incdir+../testbench/
vlog ../behavioral/adxl362/adxl362_spi.v
vlog ../behavioral/adxl362/adxl362_regs.v +incdir+../behavioral/adxl362/ 
vlog ../behavioral/adxl362/adxl362_fifo.v
vlog ../behavioral/adxl362/adxl362_accelerometer.v      


vlog ../rtl/simple_spi_top_modified.v +incdir+../testbench/
vlog ../rtl/fifo4.v +incdir+../testbench/
vlog ../rtl/pb_spi.v
vlog ../rtl/spi_regs.v


vlog ../soc/display/display_regs.v
vlog ../soc/display/display.v
vlog ../soc/display/pb_display.v
vlog ../soc/display/timer.v


vlog ../soc/gpio/gpio_bit.v
vlog ../soc/gpio/gpio_regs.v
vlog ../soc/gpio/gpio.v
vlog ../soc/gpio/pb_gpio.v



vlog ../soc/picoblaze/cpu.v +incdir+../testbench/
vlog ../soc/picoblaze/kcpsm6.v +incdir+../testbench/
vlog boot_rom.v +incdir+../testbench/


vlog ../soc/system_controller/system_controller.v


vlog ../soc/uart_pb/pb_uart_regs.v
vlog ../soc/uart_pb/pb_uart.v
vlog ../soc/uart_pb/uart_baud_generator.v
vlog ../soc/uart_pb/uart_rx6.v
vlog ../soc/uart_pb/uart_tx6.v
vlog ../soc/uart_pb/uart.v



vlog ../soc/soc.v
#vlog $XILINX_VIVADO/data/verilog/src/glbl.v
vlog /opt/Xilinx/Vivado/2015.2/data/verilog/src/glbl.v
vlog /opt/Xilinx/Vivado/2015.2/data/verilog/src/unisim_retarget_comp.v


vlog test_case.v  +incdir+../behavioral/adxl362/ +incdir+../testbench/

vsim -voptargs=+acc work.soc_testbench +define+XILINX
do wave.do
run -all
