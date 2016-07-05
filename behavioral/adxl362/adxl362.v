//                              -*- Mode: Verilog -*-
// Filename        : adxl362.v
// Description     : Top level for ADXL362 Model
// Author          : Philip Tracton
// Created On      : Wed Jun 22 21:28:54 2016
// Last Modified By: Philip Tracton
// Last Modified On: Wed Jun 22 21:28:54 2016
// Update Count    : 0
// Status          : Unknown, Use with caution!


module adxl362 (/*AUTOARG*/
   // Outputs
   MISO, INT1, INT2,
   // Inputs
   SCLK, MOSI, nCS
   ) ;
   input wire SCLK;
   input wire MOSI;
   input wire nCS;
   output wire MISO;
   output reg  INT1;
   output reg  INT2;


   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [7:0]           act_inact_ctrl;         // From registers of adxl362_regs.v
   wire [5:0]           address;                // From spi of adxl362_spi.v
   wire                 clk;                    // From sys_con of adxl362_system_controller.v
   wire                 clk_16mhz;              // From sys_con of adxl362_system_controller.v
   wire                 clk_odr;                // From sys_con of adxl362_system_controller.v
   wire                 data_fifo_write;        // From spi of adxl362_spi.v
   wire [7:0]           data_write;             // From spi of adxl362_spi.v
   wire [3:0]           fifo_ctrl;              // From registers of adxl362_regs.v
   wire [7:0]           fifo_samples;           // From registers of adxl362_regs.v
   wire                 fifo_write;             // From accelerometer of adxl362_accelerometer.v
   wire [15:0]          fifo_write_data;        // From accelerometer of adxl362_accelerometer.v
   wire [7:0]           filter_ctrl;            // From registers of adxl362_regs.v
   wire [7:0]           intmap1;                // From registers of adxl362_regs.v
   wire [7:0]           intmap2;                // From registers of adxl362_regs.v
   wire [7:0]           power_ctrl;             // From registers of adxl362_regs.v
   wire                 read_data_fifo;         // From spi of adxl362_spi.v
   wire                 reset;                  // From sys_con of adxl362_system_controller.v
   wire                 rising_clk_odr;         // From accelerometer of adxl362_accelerometer.v
   wire                 rst;                    // From sys_con of adxl362_system_controller.v
   wire                 self_test;              // From registers of adxl362_regs.v
   wire [10:0]          threshold_active;       // From registers of adxl362_regs.v
   wire [10:0]          threshold_inactive;     // From registers of adxl362_regs.v
   wire [7:0]           time_active;            // From registers of adxl362_regs.v
   wire [15:0]          time_inactive;          // From registers of adxl362_regs.v
   wire                 write;                  // From spi of adxl362_spi.v
   // End of automatics

   /*AUTOREG*/
   reg                  soft_reset = 0;
   wire [11:0]          xdata;
   wire [11:0]          ydata;
   wire [11:0]          zdata;
   wire [11:0]          temperature;
   wire [7:0]           data_fifo;
   wire [2:0]           odr;
   wire [1:0]           fifo_mode;
   wire                 fifo_enable;
   wire                 fifo_temp;
   wire                 fifo_empty;   
   wire [7:0]           status;
   reg                  data_ready = 0;
   wire [15:0]          data_fifo_read;   
   wire [7:0]           data_read;
   wire                 empty;
   
   
   assign odr = filter_ctrl[2:0];   
   assign fifo_mode = fifo_ctrl[1:0];
   assign fifo_enable = (fifo_ctrl[1:0] != 2'b00);
   assign fifo_temp = fifo_ctrl[2];
   assign status = {5'b0, ~empty, data_ready};

   always @(posedge clk_16mhz)
     if (rst) begin
        INT1 <= 0;
     end else begin
        if (intmap1[0]) begin
           if (intmap1[7]) begin
              INT1 <= ~status[0];           
           end else begin
              INT1 <= status[0];           
           end
        end        

        if (intmap1[1]) begin
           if (intmap1[7]) begin
              INT1 <= ~status[1];           
           end else begin
              INT1 <= status[1];           
           end
        end        
     end // else: !if(rst)
   


   always @(posedge clk_16mhz)
     if (rst) begin
        INT2 <= 0;
     end else begin
        if (intmap2[0]) begin
           if (intmap2[7]) begin
              INT2 <= ~status[0];           
           end else begin
              INT2 <= status[0];           
           end
        end        

        if (intmap2[1]) begin
           if (intmap2[7]) begin
              INT2 <= ~status[1];           
           end else begin
              INT2 <= status[1];           
           end
        end        
     end // else: !if(rst)
   
   always @(posedge clk_16mhz) begin
      //data_ready = fifo_enable & ~fifo_empty;
      if (fifo_write || rising_clk_odr) begin
         data_ready <= 1;         
      end

      if (!write & ((address == `ADXL362_XDATA_LOW) |
                    (address == `ADXL362_YDATA_LOW) |
                    (address == `ADXL362_ZDATA_LOW) )
          ) begin
         data_ready <= 0;
      end        
   end
   
   //
   // System Controller
   //
   // This module generates the 51.2 KHz clock used in the sytem.  This
   // module is not synthesizable.
   //

   adxl362_system_controller sys_con (/*AUTOINST*/
                                      // Outputs
                                      .clk              (clk),
                                      .clk_16mhz        (clk_16mhz),
                                      .reset            (reset),
                                      .clk_odr          (clk_odr),
                                      .rst              (rst),
                                      // Inputs
                                      .soft_reset       (soft_reset),
                                      .odr              (odr[2:0]));


   //
   // SPI
   //
   // This module handles SPI communication with host CPU.  Register bus interface
   // is synched to the clk domain in this module!
   //
   adxl362_spi spi(/*AUTOINST*/
                   // Outputs
                   .MISO                (MISO),
                   .address             (address[5:0]),
                   .data_write          (data_write[7:0]),
                   .data_fifo_write     (data_fifo_write),
                   .write               (write),
                   .read_data_fifo      (read_data_fifo),
                   // Inputs
                   .SCLK                (SCLK),
                   .MOSI                (MOSI),
                   .nCS                 (nCS),
                   .clk_16mhz           (clk_16mhz),
                   .data_read           (data_read[7:0]),
                   .data_fifo_read      (data_fifo_read[15:0]),
                   .rst                 (rst));

   //
   // Registers
   //
   // These are the firmware accessible registers
   //
   adxl362_regs registers(/*AUTOINST*/
                          // Outputs
                          .data_read            (data_read[7:0]),
                          .threshold_active     (threshold_active[10:0]),
                          .time_active          (time_active[7:0]),
                          .threshold_inactive   (threshold_inactive[10:0]),
                          .time_inactive        (time_inactive[15:0]),
                          .act_inact_ctrl       (act_inact_ctrl[7:0]),
                          .fifo_ctrl            (fifo_ctrl[3:0]),
                          .fifo_samples         (fifo_samples[7:0]),
                          .intmap1              (intmap1[7:0]),
                          .intmap2              (intmap2[7:0]),
                          .filter_ctrl          (filter_ctrl[7:0]),
                          .power_ctrl           (power_ctrl[7:0]),
                          .self_test            (self_test),
                          // Inputs
                          .clk_16mhz            (clk_16mhz),
                          .write                (write),
                          .address              (address[5:0]),
                          .data_write           (data_write[7:0]),
                          .xdata                (xdata[11:0]),
                          .ydata                (ydata[11:0]),
                          .zdata                (zdata[11:0]),
                          .temperature          (temperature[11:0]),
                          .status               (status[7:0]));
   

   //
   // Data FIFO
   //
   

   adxl362_fifo fifo(
                     // Outputs
                     .data_read         (data_fifo_read[15:0]),
                     .full              (full),
                     .empty             (empty),
                     // Inputs
                     .data_write        (fifo_write_data),
                     .clk               (clk_16mhz),
                     .rst               (rst),
                     .flush             (1'b0),
                     .read              (read_data_fifo),
                     .write             (fifo_write));
   

   //
   // Accelerometer
   //
   adxl362_accelerometer accelerometer (/*AUTOINST*/
                                        // Outputs
                                        .rising_clk_odr (rising_clk_odr),
                                        .fifo_write     (fifo_write),
                                        .fifo_write_data(fifo_write_data[15:0]),
                                        .xdata          (xdata[11:0]),
                                        .ydata          (ydata[11:0]),
                                        .zdata          (zdata[11:0]),
                                        .temperature    (temperature[11:0]),
                                        // Inputs
                                        .clk_16mhz      (clk_16mhz),
                                        .clk_odr        (clk_odr),
                                        .fifo_mode      (fifo_mode[1:0]),
                                        .fifo_temp      (fifo_temp));
   
   
endmodule // adxl362
