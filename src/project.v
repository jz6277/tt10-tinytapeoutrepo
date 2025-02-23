/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_group1 (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
    wire [15:0] In;  // 16-bit input combining ui_in and uio_in
    assign In = {ui_in, uio_in};  // Concatenate ui_in as upper and uio_in as lower bits

    assign uo_out = (In[15]) ? 8'd15 :
                    (In[14]) ? 8'd14 :
                    (In[13]) ? 8'd13 :
                    (In[12]) ? 8'd12 :
                    (In[11]) ? 8'd11 :
                    (In[10]) ? 8'd10 :
                    (In[9])  ? 8'd9  :
                    (In[8])  ? 8'd8  :
                    (In[7])  ? 8'd7  :
                    (In[6])  ? 8'd6  :
                    (In[5])  ? 8'd5  :
                    (In[4])  ? 8'd4  :
                    (In[3])  ? 8'd3  :
                    (In[2])  ? 8'd2  :
                    (In[1])  ? 8'd1  :
                    (In[0])  ? 8'd0  :
                               8'b1111_0000;  // Default case when all bits are 0
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
