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
// PN monitors

`timescale 1ns/100ps

module axi_ad9643_pnmon (

  // adc interface

  adc_clk,
  adc_data,

  // pn out of sync and error

  adc_pn_oos,
  adc_pn_err,

  // processor interface PN9 (0x0), PN23 (0x1)

  adc_pn_type);

  // adc interface

  input           adc_clk;
  input   [13:0]  adc_data;

  // pn out of sync and error

  output          adc_pn_oos;
  output          adc_pn_err;

  // processor interface PN9 (0x0), PN23 (0x1)

  input           adc_pn_type;

  // internal registers

  reg             adc_pn_en = 'd0;
  reg     [13:0]  adc_data_in = 'd0;
  reg     [13:0]  adc_data_d = 'd0;
  reg     [29:0]  adc_pn_data = 'd0;
  reg             adc_pn_en_d = 'd0;
  reg             adc_pn_match_d_1 = 'd0;
  reg             adc_pn_match_d_0 = 'd0;
  reg             adc_pn_match_z = 'd0;
  reg             adc_pn_err = 'd0;
  reg     [ 6:0]  adc_pn_oos_count = 'd0;
  reg             adc_pn_oos = 'd0;

  // internal signals

  wire    [29:0]  adc_pn_data_in_s;
  wire            adc_pn_match_d_1_s;
  wire            adc_pn_match_d_0_s;
  wire            adc_pn_match_z_s;
  wire            adc_pn_match_s;
  wire    [29:0]  adc_pn_data_s;
  wire            adc_pn_update_s;
  wire            adc_pn_err_s;

  // PN23 function

  function [29:0] pn23;
    input [29:0] din;
    reg   [29:0] dout;
    begin
      dout[29] = din[22] ^ din[17];
      dout[28] = din[21] ^ din[16];
      dout[27] = din[20] ^ din[15];
      dout[26] = din[19] ^ din[14];
      dout[25] = din[18] ^ din[13];
      dout[24] = din[17] ^ din[12];
      dout[23] = din[16] ^ din[11];
      dout[22] = din[15] ^ din[10];
      dout[21] = din[14] ^ din[ 9];
      dout[20] = din[13] ^ din[ 8];
      dout[19] = din[12] ^ din[ 7];
      dout[18] = din[11] ^ din[ 6];
      dout[17] = din[10] ^ din[ 5];
      dout[16] = din[ 9] ^ din[ 4];
      dout[15] = din[ 8] ^ din[ 3];
      dout[14] = din[ 7] ^ din[ 2];
      dout[13] = din[ 6] ^ din[ 1];
      dout[12] = din[ 5] ^ din[ 0];
      dout[11] = din[ 4] ^ din[22] ^ din[17];
      dout[10] = din[ 3] ^ din[21] ^ din[16];
      dout[ 9] = din[ 2] ^ din[20] ^ din[15];
      dout[ 8] = din[ 1] ^ din[19] ^ din[14];
      dout[ 7] = din[ 0] ^ din[18] ^ din[13];
      dout[ 6] = din[22] ^ din[12];
      dout[ 5] = din[21] ^ din[11];
      dout[ 4] = din[20] ^ din[10];
      dout[ 3] = din[19] ^ din[ 9];
      dout[ 2] = din[18] ^ din[ 8];
      dout[ 1] = din[17] ^ din[ 7];
      dout[ 0] = din[16] ^ din[ 6];
      pn23 = dout;
    end
  endfunction

  // PN9 function

  function [29:0] pn9;
    input [29:0] din;
    reg   [29:0] dout;
    begin
      dout[29] = din[ 8] ^ din[ 4];
      dout[28] = din[ 7] ^ din[ 3];
      dout[27] = din[ 6] ^ din[ 2];
      dout[26] = din[ 5] ^ din[ 1];
      dout[25] = din[ 4] ^ din[ 0];
      dout[24] = din[ 3] ^ din[ 8] ^ din[ 4];
      dout[23] = din[ 2] ^ din[ 7] ^ din[ 3];
      dout[22] = din[ 1] ^ din[ 6] ^ din[ 2];
      dout[21] = din[ 0] ^ din[ 5] ^ din[ 1];
      dout[20] = din[ 8] ^ din[ 0];
      dout[19] = din[ 7] ^ din[ 8] ^ din[ 4];
      dout[18] = din[ 6] ^ din[ 7] ^ din[ 3];
      dout[17] = din[ 5] ^ din[ 6] ^ din[ 2];
      dout[16] = din[ 4] ^ din[ 5] ^ din[ 1];
      dout[15] = din[ 3] ^ din[ 4] ^ din[ 0];
      dout[14] = din[ 2] ^ din[ 3] ^ din[ 8] ^ din[ 4];
      dout[13] = din[ 1] ^ din[ 2] ^ din[ 7] ^ din[ 3];
      dout[12] = din[ 0] ^ din[ 1] ^ din[ 6] ^ din[ 2];
      dout[11] = din[ 8] ^ din[ 0] ^ din[ 4] ^ din[ 5] ^ din[ 1];
      dout[10] = din[ 7] ^ din[ 8] ^ din[ 3] ^ din[ 0];
      dout[ 9] = din[ 6] ^ din[ 7] ^ din[ 2] ^ din[ 8] ^ din[ 4];
      dout[ 8] = din[ 5] ^ din[ 6] ^ din[ 1] ^ din[ 7] ^ din[ 3];
      dout[ 7] = din[ 4] ^ din[ 5] ^ din[ 0] ^ din[ 6] ^ din[ 2];
      dout[ 6] = din[ 3] ^ din[ 8] ^ din[ 5] ^ din[ 1];
      dout[ 5] = din[ 2] ^ din[ 4] ^ din[ 7] ^ din[ 0];
      dout[ 4] = din[ 1] ^ din[ 3] ^ din[ 6] ^ din[ 8] ^ din[ 4];
      dout[ 3] = din[ 0] ^ din[ 2] ^ din[ 5] ^ din[ 7] ^ din[ 3];
      dout[ 2] = din[ 8] ^ din[ 1] ^ din[ 6] ^ din[ 2];
      dout[ 1] = din[ 7] ^ din[ 0] ^ din[ 5] ^ din[ 1];
      dout[ 0] = din[ 6] ^ din[ 8] ^ din[ 0];
      pn9 = dout;
    end
  endfunction

  // pn sequence checking algorithm is commonly used in most applications.
  // if oos is asserted (pn is out of sync):
  //    the next sequence is generated from the incoming data.
  //    if 16 sequences match consecutively, oos is cleared (de-asserted).
  // if oos is de-asserted (pn is in sync)
  //    the next sequence is generated from the current sequence.
  //    if 64 sequences mismatch consecutively, oos is set (asserted).
  // if oos is de-asserted, any spurious mismatches sets the error register.
  // ideally, processor should make sure both oos == 0x0 and err == 0x0.

  assign adc_pn_data_in_s[29:15] = {adc_pn_data[29], adc_data_d};
  assign adc_pn_data_in_s[14:0] = {adc_pn_data[14], adc_data_in};
  assign adc_pn_match_d_1_s = (adc_pn_data_in_s[28:15] == adc_pn_data[28:15]) ? 1'b1 : 1'b0;
  assign adc_pn_match_d_0_s = (adc_pn_data_in_s[13:0] == adc_pn_data[13:0]) ? 1'b1 : 1'b0;
  assign adc_pn_match_z_s = (adc_pn_data_in_s == 30'd0) ? 1'b0 : 1'b1;
  assign adc_pn_match_s = adc_pn_match_d_1 & adc_pn_match_d_0 & adc_pn_match_z;
  assign adc_pn_data_s = (adc_pn_oos == 1'b1) ? adc_pn_data_in_s : adc_pn_data;
  assign adc_pn_update_s = ~(adc_pn_oos ^ adc_pn_match_s);
  assign adc_pn_err_s = ~(adc_pn_oos | adc_pn_match_s);

  // pn running sequence

  always @(posedge adc_clk) begin
    adc_pn_en <= ~adc_pn_en;
    adc_data_in <= {~adc_data[13], adc_data[12:0]};
    adc_data_d <= adc_data_in;
    if (adc_pn_en == 1'b1) begin
      if (adc_pn_type == 1'b0) begin
        adc_pn_data <= pn9(adc_pn_data_s);
      end else begin
        adc_pn_data <= pn23(adc_pn_data_s);
      end
    end
  end

  // pn oos and counters (64 to clear and set).

  always @(posedge adc_clk) begin
    adc_pn_en_d <= adc_pn_en;
    adc_pn_match_d_1 <= adc_pn_match_d_1_s;
    adc_pn_match_d_0 <= adc_pn_match_d_0_s;
    adc_pn_match_z <= adc_pn_match_z_s;
    adc_pn_err <= adc_pn_en_d & adc_pn_err_s;
    if (adc_pn_en_d == 1'b1) begin
      if (adc_pn_update_s == 1'b1) begin
        if (adc_pn_oos_count >= 16) begin
          adc_pn_oos_count <= 'd0;
          adc_pn_oos <= ~adc_pn_oos;
        end else begin
          adc_pn_oos_count <= adc_pn_oos_count + 1'b1;
          adc_pn_oos <= adc_pn_oos;
        end
      end else begin
        adc_pn_oos_count <= 'd0;
        adc_pn_oos <= adc_pn_oos;
      end
    end
  end

endmodule

// ***************************************************************************
// ***************************************************************************

