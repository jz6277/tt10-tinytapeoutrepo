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
    integer i;
    wire [15:0] In;  // 16-bit input combining ui_in and uio_in
    assign In = {ui_in, uio_in};  // Concatenate ui_in as upper and uio_in as lower bits

    always @(*) begin
        uo_out = 8'b1111_0000;  // Default output if all bits are 0
        for (i = 15; i >= 0; i = i - 1) begin
            if (In[i]) begin
                uo_out = i;  // Store index of first '1' bit found
                break;
            end
        end
    end
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
