// ***************************************************************************
// ***************************************************************************
// Copyright 2011(c) Analog Devices, Inc.
// 
// All rights reserved.
// 
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//     - Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     - Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in
//       the documentation and/or other materials provided with the
//       distribution.
//     - Neither the name of Analog Devices, Inc. nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//     - The use of this software may or may not infringe the patent rights
//       of one or more patent holders.  This license does not release you
//       from the requirement that you obtain separate licenses from these
//       patent holders to use this software.
//     - Use of the software either in source or binary form, must be run
//       on or directly connected to an Analog Devices Inc. component.
//    
// THIS SOFTWARE IS PROVIDED BY ANALOG DEVICES "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
// INCLUDING, BUT NOT LIMITED TO, NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A
// PARTICULAR PURPOSE ARE DISCLAIMED.
//
// IN NO EVENT SHALL ANALOG DEVICES BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
// EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, INTELLECTUAL PROPERTY
// RIGHTS, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR 
// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF 
// THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
// ***************************************************************************
// ***************************************************************************
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

module axi_ad9144 (

  // jesd interface
  // tx_clk is (line-rate/40)

  tx_clk,
  tx_data,

  // dma interface

  dac_clk,
  dac_drd,
  dac_ddata,
  dac_dovf,
  dac_dunf,

  // axi interface

  s_axi_aclk,
  s_axi_aresetn,
  s_axi_awvalid,
  s_axi_awaddr,
  s_axi_awready,
  s_axi_wvalid,
  s_axi_wdata,
  s_axi_wstrb,
  s_axi_wready,
  s_axi_bvalid,
  s_axi_bresp,
  s_axi_bready,
  s_axi_arvalid,
  s_axi_araddr,
  s_axi_arready,
  s_axi_rvalid,
  s_axi_rdata,
  s_axi_rresp,
  s_axi_rready);

  // parameters

  parameter   PCORE_ID = 0;
  parameter   PCORE_QUAD_DUAL_N = 1;
  parameter   PCORE_DAC_DP_DISABLE = 0;
  parameter   C_S_AXI_MIN_SIZE = 32'hffff;
  parameter   C_BASEADDR = 32'hffffffff;
  parameter   C_HIGHADDR = 32'h00000000;

  // jesd interface
  // tx_clk is (line-rate/40)

  input                                     tx_clk;
  output  [(128*PCORE_QUAD_DUAL_N)+127:0]   tx_data;

  // dma interface

  output                                    dac_clk;
  output                                    dac_drd;
  input   [(128*PCORE_QUAD_DUAL_N)+127:0]   dac_ddata;
  input                                     dac_dovf;
  input                                     dac_dunf;

  // axi interface

  input                                     s_axi_aclk;
  input                                     s_axi_aresetn;
  input                                     s_axi_awvalid;
  input   [ 31:0]                           s_axi_awaddr;
  output                                    s_axi_awready;
  input                                     s_axi_wvalid;
  input   [ 31:0]                           s_axi_wdata;
  input   [  3:0]                           s_axi_wstrb;
  output                                    s_axi_wready;
  output                                    s_axi_bvalid;
  output  [  1:0]                           s_axi_bresp;
  input                                     s_axi_bready;
  input                                     s_axi_arvalid;
  input   [ 31:0]                           s_axi_araddr;
  output                                    s_axi_arready;
  output                                    s_axi_rvalid;
  output  [ 31:0]                           s_axi_rdata;
  output  [  1:0]                           s_axi_rresp;
  input                                     s_axi_rready;

  // internal clocks and resets

  wire                                      dac_rst;
  wire                                      up_clk;
  wire                                      up_rstn;

  // internal signals

  wire    [255:0]                           tx_data_s;
  wire    [255:0]                           dac_ddata_s;
  wire    [ 15:0]                           dac_data_i0_0_s;
  wire    [ 15:0]                           dac_data_i0_1_s;
  wire    [ 15:0]                           dac_data_i0_2_s;
  wire    [ 15:0]                           dac_data_i0_3_s;
  wire    [ 15:0]                           dac_data_q0_0_s;
  wire    [ 15:0]                           dac_data_q0_1_s;
  wire    [ 15:0]                           dac_data_q0_2_s;
  wire    [ 15:0]                           dac_data_q0_3_s;
  wire    [ 15:0]                           dac_data_i1_0_s;
  wire    [ 15:0]                           dac_data_i1_1_s;
  wire    [ 15:0]                           dac_data_i1_2_s;
  wire    [ 15:0]                           dac_data_i1_3_s;
  wire    [ 15:0]                           dac_data_q1_0_s;
  wire    [ 15:0]                           dac_data_q1_1_s;
  wire    [ 15:0]                           dac_data_q1_2_s;
  wire    [ 15:0]                           dac_data_q1_3_s;
  wire                                      up_sel_s;
  wire                                      up_wr_s;
  wire    [ 13:0]                           up_addr_s;
  wire    [ 31:0]                           up_wdata_s;
  wire    [ 31:0]                           up_rdata_s;
  wire                                      up_ack_s;

  // signal name changes

  assign up_clk = s_axi_aclk;
  assign up_rstn = s_axi_aresetn;

  // dual/quad cores

  assign tx_data = (PCORE_QUAD_DUAL_N == 1) ? tx_data_s : tx_data_s[127:0];
  assign dac_ddata_s = (PCORE_QUAD_DUAL_N == 1) ? dac_ddata : {32'd0, dac_ddata[127:96],
    32'd0, dac_ddata[95:64], 32'd0, dac_ddata[63:32], 32'd0, dac_ddata[31:0]};

  // device interface

  axi_ad9144_if i_if (
    .tx_clk (tx_clk),
    .tx_data (tx_data_s),
    .dac_clk (dac_clk),
    .dac_rst (dac_rst),
    .dac_data_i0_0 (dac_data_i0_0_s),
    .dac_data_i0_1 (dac_data_i0_1_s),
    .dac_data_i0_2 (dac_data_i0_2_s),
    .dac_data_i0_3 (dac_data_i0_3_s),
    .dac_data_q0_0 (dac_data_q0_0_s),
    .dac_data_q0_1 (dac_data_q0_1_s),
    .dac_data_q0_2 (dac_data_q0_2_s),
    .dac_data_q0_3 (dac_data_q0_3_s),
    .dac_data_i1_0 (dac_data_i1_0_s),
    .dac_data_i1_1 (dac_data_i1_1_s),
    .dac_data_i1_2 (dac_data_i1_2_s),
    .dac_data_i1_3 (dac_data_i1_3_s),
    .dac_data_q1_0 (dac_data_q1_0_s),
    .dac_data_q1_1 (dac_data_q1_1_s),
    .dac_data_q1_2 (dac_data_q1_2_s),
    .dac_data_q1_3 (dac_data_q1_3_s));

  // core

  axi_ad9144_core #(.PCORE_ID(PCORE_ID), .DP_DISABLE(PCORE_DAC_DP_DISABLE)) i_core (
    .dac_clk (dac_clk),
    .dac_rst (dac_rst),
    .dac_data_i0_0 (dac_data_i0_0_s),
    .dac_data_i0_1 (dac_data_i0_1_s),
    .dac_data_i0_2 (dac_data_i0_2_s),
    .dac_data_i0_3 (dac_data_i0_3_s),
    .dac_data_q0_0 (dac_data_q0_0_s),
    .dac_data_q0_1 (dac_data_q0_1_s),
    .dac_data_q0_2 (dac_data_q0_2_s),
    .dac_data_q0_3 (dac_data_q0_3_s),
    .dac_data_i1_0 (dac_data_i1_0_s),
    .dac_data_i1_1 (dac_data_i1_1_s),
    .dac_data_i1_2 (dac_data_i1_2_s),
    .dac_data_i1_3 (dac_data_i1_3_s),
    .dac_data_q1_0 (dac_data_q1_0_s),
    .dac_data_q1_1 (dac_data_q1_1_s),
    .dac_data_q1_2 (dac_data_q1_2_s),
    .dac_data_q1_3 (dac_data_q1_3_s),
    .dac_drd (dac_drd),
    .dac_ddata (dac_ddata_s),
    .dac_dovf (dac_dovf),
    .dac_dunf (dac_dunf),
    .up_rstn (up_rstn),
    .up_clk (up_clk),
    .up_sel (up_sel_s),
    .up_wr (up_wr_s),
    .up_addr (up_addr_s),
    .up_wdata (up_wdata_s),
    .up_rdata (up_rdata_s),
    .up_ack (up_ack_s));

  // up bus interface

  up_axi #(
    .PCORE_BASEADDR (C_BASEADDR),
    .PCORE_HIGHADDR (C_HIGHADDR))
  i_up_axi (
    .up_rstn (up_rstn),
    .up_clk (up_clk),
    .up_axi_awvalid (s_axi_awvalid),
    .up_axi_awaddr (s_axi_awaddr),
    .up_axi_awready (s_axi_awready),
    .up_axi_wvalid (s_axi_wvalid),
    .up_axi_wdata (s_axi_wdata),
    .up_axi_wstrb (s_axi_wstrb),
    .up_axi_wready (s_axi_wready),
    .up_axi_bvalid (s_axi_bvalid),
    .up_axi_bresp (s_axi_bresp),
    .up_axi_bready (s_axi_bready),
    .up_axi_arvalid (s_axi_arvalid),
    .up_axi_araddr (s_axi_araddr),
    .up_axi_arready (s_axi_arready),
    .up_axi_rvalid (s_axi_rvalid),
    .up_axi_rresp (s_axi_rresp),
    .up_axi_rdata (s_axi_rdata),
    .up_axi_rready (s_axi_rready),
    .up_sel (up_sel_s),
    .up_wr (up_wr_s),
    .up_addr (up_addr_s),
    .up_wdata (up_wdata_s),
    .up_rdata (up_rdata_s),
    .up_ack (up_ack_s));

endmodule

// ***************************************************************************
// ***************************************************************************
