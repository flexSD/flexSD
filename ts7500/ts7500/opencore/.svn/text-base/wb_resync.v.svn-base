/* Copyright 2007, Unpublished Work of Technologic Systems
 * All Rights Reserved.
 *
 * THIS WORK IS AN UNPUBLISHED WORK AND CONTAINS CONFIDENTIAL,
 * PROPRIETARY AND TRADE SECRET INFORMATION OF TECHNOLOGIC SYSTEMS.
 * ACCESS TO THIS WORK IS RESTRICTED TO (I) TECHNOLOGIC SYSTEMS 
 * EMPLOYEES WHO HAVE A NEED TO KNOW TO PERFORM TASKS WITHIN THE SCOPE
 * OF THEIR ASSIGNMENTS AND (II) ENTITIES OTHER THAN TECHNOLOGIC
 * SYSTEMS WHO HAVE ENTERED INTO APPROPRIATE LICENSE AGREEMENTS.  NO
 * PART OF THIS WORK MAY BE USED, PRACTICED, PERFORMED, COPIED, 
 * DISTRIBUTED, REVISED, MODIFIED, TRANSLATED, ABRIDGED, CONDENSED, 
 * EXPANDED, COLLECTED, COMPILED, LINKED, RECAST, TRANSFORMED, ADAPTED
 * IN ANY FORM OR BY ANY MEANS, MANUAL, MECHANICAL, CHEMICAL, 
 * ELECTRICAL, ELECTRONIC, OPTICAL, BIOLOGICAL, OR OTHERWISE WITHOUT
 * THE PRIOR WRITTEN PERMISSION AND CONSENT OF TECHNOLOGIC SYSTEMS.
 * ANY USE OR EXPLOITATION OF THIS WORK WITHOUT THE PRIOR WRITTEN
 * CONSENT OF TECHNOLOGIC SYSTEMS COULD SUBJECT THE PERPETRATOR TO
 * CRIMINAL AND CIVIL LIABILITY.
 */

module wb_resync(
  wb_rst_i,
  wb_clk_i,

  wbs1_cyc_i,
  wbs1_stb_i,
  wbs1_dat_i,
  wbs1_dat_o,
  wbs1_ack_o,
  wbs1_we_i,
  wbs1_adr_i,
  wbs1_sel_i,

  wbs2_cyc_i,
  wbs2_stb_i,
  wbs2_dat_i,
  wbs2_dat_o,
  wbs2_ack_o,
  wbs2_we_i,
  wbs2_adr_i,
  wbs2_sel_i,

  wbs3_cyc_i,
  wbs3_stb_i,
  wbs3_dat_i,
  wbs3_dat_o,
  wbs3_ack_o,
  wbs3_we_i,
  wbs3_adr_i,
  wbs3_sel_i,

  wbs4_cyc_i,
  wbs4_stb_i,
  wbs4_dat_i,
  wbs4_dat_o,
  wbs4_ack_o,
  wbs4_we_i,
  wbs4_adr_i,
  wbs4_sel_i,

  wbm_clk_i,
  wbm_cyc_o,
  wbm_stb_o,
  wbm_adr_o,
  wbm_dat_o,
  wbm_ack_i,
  wbm_dat_i,
  wbm_we_o,
  wbm_sel_o
);

input wb_rst_i, wb_clk_i;

input wbs1_cyc_i, wbs1_stb_i, wbs1_we_i;
output wbs1_ack_o;
input [3:0] wbs1_sel_i;
input [31:0] wbs1_adr_i, wbs1_dat_i;
output [31:0] wbs1_dat_o;

input wbs2_cyc_i, wbs2_stb_i, wbs2_we_i;
output wbs2_ack_o;
input [3:0] wbs2_sel_i;
input [31:0] wbs2_adr_i, wbs2_dat_i;
output [31:0] wbs2_dat_o;

input wbs3_cyc_i, wbs3_stb_i, wbs3_we_i;
output wbs3_ack_o;
input [3:0] wbs3_sel_i;
input [31:0] wbs3_adr_i, wbs3_dat_i;
output [31:0] wbs3_dat_o;

input wbs4_cyc_i, wbs4_stb_i, wbs4_we_i;
output wbs4_ack_o;
input [3:0] wbs4_sel_i;
input [31:0] wbs4_adr_i, wbs4_dat_i;
output [31:0] wbs4_dat_o;

input wbm_clk_i, wbm_ack_i;
input [31:0] wbm_dat_i;
output [31:0] wbm_adr_o, wbm_dat_o;
output [3:0] wbm_sel_o;
output wbm_we_o, wbm_cyc_o, wbm_stb_o;

wire [31:0] wbs_adr_i;
wire [31:0] wbs_dat_i;
wire [3:0] wbs_sel_i;
wire [31:0] wbs_dat_o;
wire wbs_ack_o, wbs_cyc_i, wbs_stb_i, wbs_we_i;
wb_arbiter arbitercore(
  .wb_clk_i(wb_clk_i),

  .wbowner_dat_o(wbs_dat_i),
  .wbowner_dat_i(wbs_dat_o),
  .wbowner_adr_o(wbs_adr_i),
  .wbowner_cyc_o(wbs_cyc_i),
  .wbowner_stb_o(wbs_stb_i),
  .wbowner_we_o(wbs_we_i),
  .wbowner_ack_i(wbs_ack_o),
  .wbowner_sel_o(wbs_sel_i),

  .wb1_adr_i(wbs1_adr_i),
  .wb1_dat_i(wbs1_dat_i),
  .wb1_dat_o(wbs1_dat_o),
  .wb1_cyc_i(wbs1_cyc_i),
  .wb1_stb_i(wbs1_stb_i),
  .wb1_we_i(wbs1_we_i),
  .wb1_ack_o(wbs1_ack_o),
  .wb1_sel_i(wbs1_sel_i),

  .wb2_adr_i(wbs2_adr_i),
  .wb2_dat_i(wbs2_dat_i),
  .wb2_dat_o(wbs2_dat_o),
  .wb2_cyc_i(wbs2_cyc_i),
  .wb2_stb_i(wbs2_stb_i),
  .wb2_we_i(wbs2_we_i),
  .wb2_ack_o(wbs2_ack_o),
  .wb2_sel_i(wbs2_sel_i),

  .wb3_adr_i(wbs3_adr_i),
  .wb3_dat_i(wbs3_dat_i),
  .wb3_dat_o(wbs3_dat_o),
  .wb3_cyc_i(wbs3_cyc_i),
  .wb3_stb_i(wbs3_stb_i),
  .wb3_we_i(wbs3_we_i),
  .wb3_ack_o(wbs3_ack_o),
  .wb3_sel_i(wbs3_sel_i),

  .wb4_adr_i(wbs4_adr_i),
  .wb4_dat_i(wbs4_dat_i),
  .wb4_dat_o(wbs4_dat_o),
  .wb4_cyc_i(wbs4_cyc_i),
  .wb4_stb_i(wbs4_stb_i),
  .wb4_we_i(wbs4_we_i),
  .wb4_ack_o(wbs4_ack_o),
  .wb4_sel_i(wbs4_sel_i)
);


wire issueq_bsy;
resync_fifo issueq(
  .rst_i(wb_rst_i),
  .wrclk_i(wb_clk_i),
  .wrreq_i(wbs_cyc_i && wbs_stb_i && !issueq_bsy && !wbs_ack_o),
  .data_i({wbs_we_i, wbs_sel_i, wbs_adr_i, wbs_dat_i}),
  .full_wrclk_o(issueq_bsy),
  .rdclk_i(wbm_clk_i),
  .rdreq_i(wbm_ack_i && wbm_stb_o),
  .q_o({wbm_we_o, wbm_sel_o, wbm_adr_o, wbm_dat_o}),
  .full_rdclk_o(wbm_stb_o)
);
assign wbm_cyc_o = wbm_stb_o;

wire resultq_bsy;
resync_fifo resultq(
  .rst_i(wb_rst_i),
  .wrclk_i(wbm_clk_i),
  .wrreq_i(wbm_ack_i && wbm_stb_o),
  .full_wrclk_o(resultq_bsy),
  .data_i(wbm_dat_i),
  
  .rdclk_i(wb_clk_i),
  .full_rdclk_o(wbs_ack_o),
  .rdreq_i(wbs_ack_o),
  .q_o(wbs_dat_o)
);

endmodule

module resync_fifo(
  wrclk_i, wrreq_i, data_i, full_wrclk_o,
  rdclk_i, rdreq_i, q_o, full_rdclk_o, rst_i
);
input wrclk_i, wrreq_i, rdclk_i, rdreq_i, rst_i;
input [255:0] data_i;
output [255:0] q_o;
output full_wrclk_o, full_rdclk_o;

reg [255:0] dat;
reg head, tail, head_r, tail_w;
assign full_wrclk_o = (tail_w != head);
assign full_rdclk_o = (head_r != tail);
assign q_o = dat;

always @(posedge wrclk_i or posedge rst_i) begin
  if (rst_i) begin
    dat <= 255'd0;
    head <= 1'b0;
    tail_w <= 1'b0;
  end else begin
    if (wrreq_i) begin
      dat <= data_i;
      head <= head + 1'b1;
    end
    tail_w <= tail;
  end
end

always @(posedge rdclk_i or posedge rst_i) begin
  if (rst_i) begin
    tail <= 1'b0;
    head_r <= 1'b0;
  end else begin
    if (rdreq_i) begin
      tail <= tail + 1'b1;
    end
    head_r <= head;
  end
end

endmodule 

