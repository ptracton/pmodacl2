+define+VERBOSE
+define+SIM
+define+RTL_SIM
      
+incdir+../testbench
+incdir+../rtl_simulation
+incdir+../rtl
+incdir+../behavioral/verilog_utils/
+incdir+../behavioral/adxl362/
//+incdir+/opt/Xilinx/Vivado/2015.2/data/verilog/src/unisims/
      
// /opt/Xilinx/Vivado/2015.2/data/verilog/src/glbl.v
// /opt/Xilinx/Vivado/2015.2/data/verilog/src/unisims/BUFG.v
// /opt/Xilinx/Vivado/2015.2/data/verilog/src/unisims/BUFGCE.v
// /opt/Xilinx/Vivado/2015.2/data/verilog/src/unisims/IBUF.v


../testbench/spi_testbench.v
../testbench/test_tasks.v
../testbench/spi_tasks.v      
../testbench/dump.v


../behavioral/adxl362/adxl362.v
../behavioral/adxl362/adxl362_system_controller.v
../behavioral/adxl362/adxl362_spi.v
../behavioral/adxl362/adxl362_regs.v      
../behavioral/adxl362/adxl362_fifo.v
../behavioral/adxl362/adxl362_accelerometer.v      

../rtl/fpga.v
../rtl/spi_controller.v
../rtl/spi_fifo.v
../rtl/spi.v
../rtl/system_controller.v      

