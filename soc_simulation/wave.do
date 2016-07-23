onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/clk_in
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/reset_in
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/switches
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/leds
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/push_buttons
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/RX
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/TX
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/anode
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/cathode
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/sck_o
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/ncs_o
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/mosi_o
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/miso_i
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/int1
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/int2
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/clk_sys
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/interrupt_ack
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/locked
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/out_port
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/port_id
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/read_strobe
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/reset_sys
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/write_strobe
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/in_port
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/sw0_out_port
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/sw1_out_port
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/led0_out_port
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/led1_out_port
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/uart_data_out
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/display_data_out
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/buttons_out_port
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/spi_out_port
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/spi_interrupt
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/uart_interrupt
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/button_interrupt
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/interrupt
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/kcpsm6_sleep
add wave -noupdate -group DUT -radix hexadecimal /soc_testbench/dut/button_disconnect
add wave -noupdate -group {DUT SYS CON} /soc_testbench/dut/sys_con/clk_in
add wave -noupdate -group {DUT SYS CON} /soc_testbench/dut/sys_con/clk_sys
add wave -noupdate -group {DUT SYS CON} /soc_testbench/dut/sys_con/reset_in
add wave -noupdate -group {DUT SYS CON} /soc_testbench/dut/sys_con/reset_sys
add wave -noupdate -group {DUT SYS CON} /soc_testbench/dut/sys_con/locked
add wave -noupdate -group {DUT SYS CON} -radix hexadecimal /soc_testbench/dut/sys_con/reset_count
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/clk_sys
add wave -noupdate -expand -group Picoblaze -radix ascii /soc_testbench/dut/picoblaze/processor/kcpsm6_opcode
add wave -noupdate -expand -group Picoblaze -radix ascii /soc_testbench/dut/picoblaze/processor/kcpsm6_status
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/in_port
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/port_id
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/out_port
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/write_strobe
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/read_strobe
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/interrupt
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/kcpsm6_sleep
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/reset_sys
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/address
add wave -noupdate -expand -group Picoblaze -radix hexadecimal -childformat {{{/soc_testbench/dut/picoblaze/instruction[17]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[16]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[15]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[14]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[13]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[12]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[11]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[10]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[9]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[8]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[7]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[6]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[5]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[4]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[3]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[2]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[1]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[0]} -radix ascii}} -subitemconfig {{/soc_testbench/dut/picoblaze/instruction[17]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[16]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[15]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[14]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[13]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[12]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[11]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[10]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[9]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[8]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[7]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[6]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[5]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[4]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[3]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[2]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[1]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[0]} {-height 17 -radix ascii}} /soc_testbench/dut/picoblaze/instruction
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/processor/sim_s0
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/processor/sim_s1
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/processor/sim_s2
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/processor/sim_s3
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/processor/sim_s4
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/processor/sim_s5
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/processor/sim_s6
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/processor/sim_s7
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/processor/sim_s8
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/processor/sim_s9
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/processor/sim_sA
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/processor/sim_sB
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/processor/sim_sC
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/processor/sim_sD
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/processor/sim_sE
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/processor/sim_sF
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/processor/sim_spm00
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/processor/sim_spm01
add wave -noupdate -group {DUT SPI} /soc_testbench/dut/spi/temperature
add wave -noupdate -group {DUT SPI} -radix hexadecimal /soc_testbench/dut/spi/clk
add wave -noupdate -group {DUT SPI} -radix hexadecimal /soc_testbench/dut/spi/reset
add wave -noupdate -group {DUT SPI} -radix hexadecimal /soc_testbench/dut/spi/port_id
add wave -noupdate -group {DUT SPI} -radix hexadecimal /soc_testbench/dut/spi/data_in
add wave -noupdate -group {DUT SPI} -radix hexadecimal /soc_testbench/dut/spi/data_out
add wave -noupdate -group {DUT SPI} -radix hexadecimal /soc_testbench/dut/spi/read_strobe
add wave -noupdate -group {DUT SPI} -radix hexadecimal /soc_testbench/dut/spi/write_strobe
add wave -noupdate -group {DUT SPI} -radix hexadecimal /soc_testbench/dut/spi/interrupt
add wave -noupdate -group {DUT SPI} -radix hexadecimal /soc_testbench/dut/spi/sck_o
add wave -noupdate -group {DUT SPI} -radix hexadecimal /soc_testbench/dut/spi/ncs_o
add wave -noupdate -group {DUT SPI} -radix hexadecimal /soc_testbench/dut/spi/mosi_o
add wave -noupdate -group {DUT SPI} -radix hexadecimal /soc_testbench/dut/spi/miso_i
add wave -noupdate -group {DUT SPI} -radix hexadecimal /soc_testbench/dut/spi/clear_spif
add wave -noupdate -group {DUT SPI} -radix hexadecimal /soc_testbench/dut/spi/clear_wcol
add wave -noupdate -group {DUT SPI} -radix hexadecimal /soc_testbench/dut/spi/rfdout
add wave -noupdate -group {DUT SPI} -radix hexadecimal /soc_testbench/dut/spi/rfre
add wave -noupdate -group {DUT SPI} -radix hexadecimal /soc_testbench/dut/spi/spcr
add wave -noupdate -group {DUT SPI} -radix hexadecimal /soc_testbench/dut/spi/sper
add wave -noupdate -group {DUT SPI} -radix hexadecimal /soc_testbench/dut/spi/spsr
add wave -noupdate -group {DUT SPI} -radix hexadecimal /soc_testbench/dut/spi/wfdin
add wave -noupdate -group {DUT SPI} -radix hexadecimal /soc_testbench/dut/spi/wfwe
add wave -noupdate -group {DUT SPI} -radix hexadecimal /soc_testbench/dut/spi/wr_spsr
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/clk_i
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/nrst
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/spcr
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/spsr
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/sper
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/inta_o
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/rfdout
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/wfwe
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/rfre
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/wr_spsr
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/clear_spif
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/clear_wcol
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/wfdin
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/sck_o
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/mosi_o
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/miso_i
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/treg
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/wfre
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/rfwe
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/rffull
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/rfempty
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/wfdout
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/wffull
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/wfempty
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/tirq
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/wfov
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/state
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/bcnt
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/spie
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/spe
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/dwom
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/mstr
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/cpol
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/cpha
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/spr
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/icnt
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/spre
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/espr
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/spif
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/wcol
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/clkcnt
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/ena
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/tcnt
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/BASE_ADDRESS
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/clk
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/reset
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/port_id
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/data_in
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/data_out
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/read_strobe
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/write_strobe
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/interrupt
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/buffer_write
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/uart_data_write
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/buffer_read
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/uart_data_read
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/rx_data_present
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/rx_half_full
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/rx_full
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/tx_data_present
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/tx_half_full
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/tx_full
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/enable
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/uart_clock_divide
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/uart_data_in_enable
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/uart_data_out_enable
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/uart_control_enable
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/uart_status_enable
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/uart_irq_mask_enable
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/uart_irq_enable
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/uart_clock_divide_lower_enable
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/uart_clock_divide_upper_enable
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/uart_control
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/uart_irq_mask
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/uart_irq
add wave -noupdate -group {DUT UART REGS} -radix hexadecimal /soc_testbench/dut/uart/regs/uart_data_read_reg
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/serial_in
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/en_16_x_baud
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/data_out
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/buffer_read
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/buffer_data_present
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/buffer_half_full
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/buffer_full
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/buffer_reset
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/clk
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/pointer_value
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/pointer
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/en_pointer
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/zero
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/full_int
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/data_present_value
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/data_present_int
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/sample_value
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/sample
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/sample_dly_value
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/sample_dly
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/stop_bit_value
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/stop_bit
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/data_value
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/data
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/run_value
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/run
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/start_bit_value
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/start_bit
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/div_value
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/div
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/div_carry
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/sample_input_value
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/sample_input
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/buffer_write_value
add wave -noupdate -group {DUT UART RECEIVER} -radix hexadecimal /soc_testbench/dut/uart/receiver/buffer_write
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/MISO
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/MOSI
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/SCLK
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/WR_DONE
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/WR_IDLE
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/WR_WRITE
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/address
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/bit_count
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/bit_count_previous
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/clk_sys
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/command
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/data_fifo_read
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/data_fifo_write
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/data_rd
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/data_read
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/data_write
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/empty_fifo
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/finish
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/first
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/flush
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/flush_fifo
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/full_fifo
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/nCS
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/next_state
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/read_data_fifo
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/read_fifo
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/rst
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/running_bit_count
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/spi_byte_begin
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/spi_byte_done
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/spi_data_in
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/spi_data_out
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/state
add wave -noupdate -group {ADXL362 SPI} -radix ascii /soc_testbench/adxl362/spi/state_name
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/terminate_transaction
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/wr_next_state
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/wr_state
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/write
add wave -noupdate -group {ADXL362 SPI} -radix hexadecimal /soc_testbench/adxl362/spi/write_fifo
add wave -noupdate -group {ADXL362 REGS} -radix hexadecimal /soc_testbench/adxl362/registers/act_inact_ctrl
add wave -noupdate -group {ADXL362 REGS} -radix hexadecimal /soc_testbench/adxl362/registers/address
add wave -noupdate -group {ADXL362 REGS} -radix hexadecimal /soc_testbench/adxl362/registers/clk_sys
add wave -noupdate -group {ADXL362 REGS} -radix hexadecimal /soc_testbench/adxl362/registers/data_read
add wave -noupdate -group {ADXL362 REGS} -radix hexadecimal /soc_testbench/adxl362/registers/data_write
add wave -noupdate -group {ADXL362 REGS} -radix hexadecimal /soc_testbench/adxl362/registers/fifo_ctrl
add wave -noupdate -group {ADXL362 REGS} -radix hexadecimal /soc_testbench/adxl362/registers/fifo_samples
add wave -noupdate -group {ADXL362 REGS} -radix hexadecimal /soc_testbench/adxl362/registers/filter_ctrl
add wave -noupdate -group {ADXL362 REGS} -radix hexadecimal /soc_testbench/adxl362/registers/intmap1
add wave -noupdate -group {ADXL362 REGS} -radix hexadecimal /soc_testbench/adxl362/registers/intmap2
add wave -noupdate -group {ADXL362 REGS} -radix hexadecimal /soc_testbench/adxl362/registers/power_ctrl
add wave -noupdate -group {ADXL362 REGS} -radix hexadecimal /soc_testbench/adxl362/registers/self_test
add wave -noupdate -group {ADXL362 REGS} -radix hexadecimal /soc_testbench/adxl362/registers/status
add wave -noupdate -group {ADXL362 REGS} -radix hexadecimal /soc_testbench/adxl362/registers/temperature
add wave -noupdate -group {ADXL362 REGS} -radix hexadecimal /soc_testbench/adxl362/registers/threshold_active
add wave -noupdate -group {ADXL362 REGS} -radix hexadecimal /soc_testbench/adxl362/registers/threshold_inactive
add wave -noupdate -group {ADXL362 REGS} -radix hexadecimal /soc_testbench/adxl362/registers/time_active
add wave -noupdate -group {ADXL362 REGS} -radix hexadecimal /soc_testbench/adxl362/registers/time_inactive
add wave -noupdate -group {ADXL362 REGS} -radix hexadecimal /soc_testbench/adxl362/registers/write
add wave -noupdate -group {ADXL362 REGS} -radix hexadecimal /soc_testbench/adxl362/registers/xdata
add wave -noupdate -group {ADXL362 REGS} -radix hexadecimal /soc_testbench/adxl362/registers/ydata
add wave -noupdate -group {ADXL362 REGS} -radix hexadecimal /soc_testbench/adxl362/registers/zdata
add wave -noupdate -group {DUT DISPLAY TOP} -radix hexadecimal /soc_testbench/dut/seven_segments/anode
add wave -noupdate -group {DUT DISPLAY TOP} -radix hexadecimal /soc_testbench/dut/seven_segments/cathode
add wave -noupdate -group {DUT DISPLAY TOP} -radix hexadecimal /soc_testbench/dut/seven_segments/clk
add wave -noupdate -group {DUT DISPLAY TOP} -radix hexadecimal /soc_testbench/dut/seven_segments/data_in
add wave -noupdate -group {DUT DISPLAY TOP} -radix hexadecimal /soc_testbench/dut/seven_segments/data_out
add wave -noupdate -group {DUT DISPLAY TOP} -radix hexadecimal /soc_testbench/dut/seven_segments/display_segment0
add wave -noupdate -group {DUT DISPLAY TOP} -radix hexadecimal /soc_testbench/dut/seven_segments/display_segment1
add wave -noupdate -group {DUT DISPLAY TOP} -radix hexadecimal /soc_testbench/dut/seven_segments/display_segment2
add wave -noupdate -group {DUT DISPLAY TOP} -radix hexadecimal /soc_testbench/dut/seven_segments/display_segment3
add wave -noupdate -group {DUT DISPLAY TOP} -radix hexadecimal /soc_testbench/dut/seven_segments/display_temperature
add wave -noupdate -group {DUT DISPLAY TOP} -radix hexadecimal /soc_testbench/dut/seven_segments/port_id
add wave -noupdate -group {DUT DISPLAY TOP} -radix hexadecimal /soc_testbench/dut/seven_segments/read_strobe
add wave -noupdate -group {DUT DISPLAY TOP} -radix hexadecimal /soc_testbench/dut/seven_segments/reset
add wave -noupdate -group {DUT DISPLAY TOP} -radix hexadecimal /soc_testbench/dut/seven_segments/segment0
add wave -noupdate -group {DUT DISPLAY TOP} -radix hexadecimal /soc_testbench/dut/seven_segments/segment1
add wave -noupdate -group {DUT DISPLAY TOP} -radix hexadecimal /soc_testbench/dut/seven_segments/segment2
add wave -noupdate -group {DUT DISPLAY TOP} -radix hexadecimal /soc_testbench/dut/seven_segments/segment3
add wave -noupdate -group {DUT DISPLAY TOP} -radix hexadecimal /soc_testbench/dut/seven_segments/temperature
add wave -noupdate -group {DUT DISPLAY TOP} -radix hexadecimal /soc_testbench/dut/seven_segments/write_strobe
add wave -noupdate -group {DUT DISPLAY INST} -radix hexadecimal /soc_testbench/dut/seven_segments/seven_segments/anode
add wave -noupdate -group {DUT DISPLAY INST} -radix hexadecimal /soc_testbench/dut/seven_segments/seven_segments/cathode
add wave -noupdate -group {DUT DISPLAY INST} -radix hexadecimal /soc_testbench/dut/seven_segments/seven_segments/clk
add wave -noupdate -group {DUT DISPLAY INST} -radix hexadecimal /soc_testbench/dut/seven_segments/seven_segments/next_state
add wave -noupdate -group {DUT DISPLAY INST} -radix hexadecimal /soc_testbench/dut/seven_segments/seven_segments/reset
add wave -noupdate -group {DUT DISPLAY INST} -radix hexadecimal /soc_testbench/dut/seven_segments/seven_segments/segment0
add wave -noupdate -group {DUT DISPLAY INST} -radix hexadecimal /soc_testbench/dut/seven_segments/seven_segments/segment1
add wave -noupdate -group {DUT DISPLAY INST} -radix hexadecimal /soc_testbench/dut/seven_segments/seven_segments/segment2
add wave -noupdate -group {DUT DISPLAY INST} -radix hexadecimal /soc_testbench/dut/seven_segments/seven_segments/segment3
add wave -noupdate -group {DUT DISPLAY INST} -radix hexadecimal /soc_testbench/dut/seven_segments/seven_segments/state
add wave -noupdate -group {DUT DISPLAY INST} -radix hexadecimal /soc_testbench/dut/seven_segments/seven_segments/timer_expired
add wave -noupdate -group TESTBENCH -radix hexadecimal /soc_testbench/RX
add wave -noupdate -group TESTBENCH -radix hexadecimal /soc_testbench/TX
add wave -noupdate -group TESTBENCH -radix hexadecimal /soc_testbench/anode
add wave -noupdate -group TESTBENCH -radix hexadecimal /soc_testbench/cathode
add wave -noupdate -group TESTBENCH -radix hexadecimal /soc_testbench/clk
add wave -noupdate -group TESTBENCH -radix hexadecimal /soc_testbench/int1
add wave -noupdate -group TESTBENCH -radix hexadecimal /soc_testbench/int2
add wave -noupdate -group TESTBENCH -radix hexadecimal /soc_testbench/leds
add wave -noupdate -group TESTBENCH -radix hexadecimal /soc_testbench/miso_i
add wave -noupdate -group TESTBENCH -radix hexadecimal /soc_testbench/mosi_o
add wave -noupdate -group TESTBENCH -radix hexadecimal /soc_testbench/ncs_o
add wave -noupdate -group TESTBENCH -radix hexadecimal /soc_testbench/push_buttons
add wave -noupdate -group TESTBENCH -radix hexadecimal /soc_testbench/push_buttons_regs
add wave -noupdate -group TESTBENCH -radix hexadecimal /soc_testbench/reset
add wave -noupdate -group TESTBENCH -radix hexadecimal /soc_testbench/sck_o
add wave -noupdate -group TESTBENCH -radix hexadecimal /soc_testbench/switches
add wave -noupdate -group TESTBENCH -radix hexadecimal /soc_testbench/switches_reg
add wave -noupdate -group {DUT GPIO SW0} -radix hexadecimal /soc_testbench/dut/sw0/clk
add wave -noupdate -group {DUT GPIO SW0} -radix hexadecimal /soc_testbench/dut/sw0/data_in
add wave -noupdate -group {DUT GPIO SW0} -radix hexadecimal /soc_testbench/dut/sw0/data_out
add wave -noupdate -group {DUT GPIO SW0} -radix hexadecimal /soc_testbench/dut/sw0/gpio
add wave -noupdate -group {DUT GPIO SW0} -radix hexadecimal /soc_testbench/dut/sw0/gpio_data_in
add wave -noupdate -group {DUT GPIO SW0} -radix hexadecimal /soc_testbench/dut/sw0/gpio_data_out
add wave -noupdate -group {DUT GPIO SW0} -color Salmon -radix hexadecimal /soc_testbench/dut/sw0/gpio_oen
add wave -noupdate -group {DUT GPIO SW0} -radix hexadecimal /soc_testbench/dut/sw0/interrupt
add wave -noupdate -group {DUT GPIO SW0} -radix hexadecimal /soc_testbench/dut/sw0/port_id
add wave -noupdate -group {DUT GPIO SW0} -radix hexadecimal /soc_testbench/dut/sw0/read_strobe
add wave -noupdate -group {DUT GPIO SW0} -radix hexadecimal /soc_testbench/dut/sw0/reset
add wave -noupdate -group {DUT GPIO SW0} -radix hexadecimal /soc_testbench/dut/sw0/write_strobe
add wave -noupdate -group {DUT GPIO SW0 REGS} -radix hexadecimal /soc_testbench/dut/sw0/regs/clk
add wave -noupdate -group {DUT GPIO SW0 REGS} -radix hexadecimal /soc_testbench/dut/sw0/regs/data_in
add wave -noupdate -group {DUT GPIO SW0 REGS} -radix hexadecimal /soc_testbench/dut/sw0/regs/data_out
add wave -noupdate -group {DUT GPIO SW0 REGS} -radix hexadecimal /soc_testbench/dut/sw0/regs/gpio_oen
add wave -noupdate -group {DUT GPIO SW0 REGS} -radix hexadecimal /soc_testbench/dut/sw0/regs/gpio_oen_enable
add wave -noupdate -group {DUT GPIO SW0 REGS} -radix hexadecimal /soc_testbench/dut/sw0/regs/port_id
add wave -noupdate -group {DUT GPIO SW0 REGS} -radix hexadecimal /soc_testbench/dut/sw0/regs/read_strobe
add wave -noupdate -group {DUT GPIO SW0 REGS} -radix hexadecimal /soc_testbench/dut/sw0/regs/reset
add wave -noupdate -group {DUT GPIO SW0 REGS} -radix hexadecimal /soc_testbench/dut/sw0/regs/write_strobe
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {945100 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 467
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {102534847 ps} {102745535 ps}
