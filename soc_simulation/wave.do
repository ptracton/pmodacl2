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
add wave -noupdate -expand -group Picoblaze /soc_testbench/dut/picoblaze/processor/stack_pointer
add wave -noupdate -expand -group Picoblaze -radix ascii /soc_testbench/dut/picoblaze/processor/kcpsm6_opcode
add wave -noupdate -expand -group Picoblaze -radix ascii /soc_testbench/dut/picoblaze/processor/kcpsm6_status
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/in_port
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/port_id
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/out_port
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/write_strobe
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/read_strobe
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/interrupt
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/interrupt_ack
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/kcpsm6_sleep
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/reset_sys
add wave -noupdate -expand -group Picoblaze /soc_testbench/dut/picoblaze/processor/internal_reset
add wave -noupdate -expand -group Picoblaze /soc_testbench/dut/picoblaze/processor/internal_reset_value
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/address
add wave -noupdate -expand -group Picoblaze -radix hexadecimal -childformat {{{/soc_testbench/dut/picoblaze/instruction[17]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[16]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[15]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[14]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[13]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[12]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[11]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[10]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[9]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[8]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[7]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[6]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[5]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[4]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[3]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[2]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[1]} -radix ascii} {{/soc_testbench/dut/picoblaze/instruction[0]} -radix ascii}} -subitemconfig {{/soc_testbench/dut/picoblaze/instruction[17]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[16]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[15]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[14]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[13]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[12]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[11]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[10]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[9]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[8]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[7]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[6]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[5]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[4]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[3]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[2]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[1]} {-height 17 -radix ascii} {/soc_testbench/dut/picoblaze/instruction[0]} {-height 17 -radix ascii}} /soc_testbench/dut/picoblaze/instruction
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/bram_enable
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/k_write_strobe
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/kcpsm6_reset
add wave -noupdate -expand -group Picoblaze -radix hexadecimal /soc_testbench/dut/picoblaze/int_request
add wave -noupdate -group {DUT SPI} -radix hexadecimal /soc_testbench/dut/spi/WIDTH
add wave -noupdate -group {DUT SPI} -radix hexadecimal /soc_testbench/dut/spi/BASE_ADDRESS
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
add wave -noupdate -group {DUT SPI MODIFIED} -radix hexadecimal /soc_testbench/dut/spi/spi/rreg
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
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5200 ps} 0}
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
WaveRestoreZoom {1707958 ps} {1736424 ps}
