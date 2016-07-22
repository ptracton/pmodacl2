onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/clk_in
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/reset_in
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/switches
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/leds
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/push_buttons
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/RX
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/TX
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/anode
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/cathode
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/sck_o
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/ncs_o
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/mosi_o
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/miso_i
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/int1
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/int2
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/clk_sys
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/interrupt_ack
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/locked
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/out_port
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/port_id
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/read_strobe
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/reset_sys
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/write_strobe
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/in_port
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/sw0_out_port
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/sw1_out_port
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/led0_out_port
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/led1_out_port
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/uart_data_out
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/display_data_out
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/buttons_out_port
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/spi_out_port
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/spi_interrupt
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/uart_interrupt
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/button_interrupt
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/interrupt
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/kcpsm6_sleep
add wave -noupdate -expand -group DUT -radix hexadecimal /soc_testbench/dut/button_disconnect
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 326
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
WaveRestoreZoom {0 ps} {895 ps}
