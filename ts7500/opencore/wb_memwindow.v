/* Copyright 2009, Unpublished Work of Technologic Systems
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

/* This core is a simple core to allow access to an up to 64Kbyte WISHBONE
 * address space via a 2 16-bit register window.  On the TS-7500 this core
 * appears at 0x3c and is used to address the 8kbyte blockram used by
 * the XUART core for TX/RX buffers.
 * 
 * Register map:
 * base + 0x0: Address reg (RW)
 * base + 0x2: Data reg (RW)
 *
 * * When the data reg is read or written, the address is automatically
 *   incremented by 2.  In this way, contiguous reads/writes of address
 *   space is optimized.
 */

module wb_memwindow16to32(
  wb_clk_i,
  wb_rst_i,
  wb_cyc_i,
  wb_stb_i,
  wb_we_i,
  wb_adr_i,
  wb_sel_i,
  wb_dat_i,
  wb_dat_o,
  wb_ack_o,

  wbm_cyc_o,
  wbm_stb_o,
  wbm_we_o,
  wbm_sel_o,
  wbm_adr_o,
  wbm_dat_o,
  wbm_dat_i,
  wbm_ack_i
);

input wb_clk_i, wb_rst_i, wb_cyc_i, wb_stb_i, wb_we_i;
output wb_ack_o;
output [15:0] wb_dat_o;
input [15:0] wb_dat_i, wb_adr_i;
input [1:0] wb_sel_i;

output wbm_cyc_o, wbm_stb_o, wbm_we_o;
output [31:0] wbm_dat_o, wbm_adr_o;
input [31:0] wbm_dat_i;
output [3:0] wbm_sel_o;
input wbm_ack_i;

reg [15:0] adr;
reg [15:0] wb_dat;
reg wbm_cyc, wbm_stb, wb_ack;

always @(posedge wb_clk_i or posedge wb_rst_i) begin
	
  if (wb_rst_i) begin
	  
    adr <= 16'd0;
	
  end else begin
    
	//Write incoming address to adr register
	if (wb_cyc_i && wb_stb_i && wb_we_i && !wb_adr_i[1]) adr <= wb_dat_i;
	
	//End of write cycle (wbm_ack_i asserted), increment address:
    if (wbm_cyc && wbm_stb && wbm_ack_i) adr <= adr + 2'd2;	

  end
  
end

assign wbm_cyc_o = wbm_cyc;
assign wbm_stb_o = wbm_stb;
assign wb_ack_o = wb_ack;
assign wbm_dat_o[31:0] = {wb_dat_i[15:0], wb_dat_i[15:0]};
assign wb_dat_o = wb_dat;
assign wbm_adr_o = {16'd0, adr[15:2], 2'b00};
assign wbm_we_o = wb_we_i;

//Determine which set of blockram to address:
assign wbm_sel_o = adr[1] ? 4'b1100 : 4'b0011;

always @(*) begin
  
  //Address is 0x3E, read data from blockram and return it to calling bus
  if (wb_adr_i[1]) begin
	
	//Cycle, strobe, and ack lanes routed to blockram
    wbm_cyc = wb_cyc_i;
    wbm_stb = wb_stb_i;
    wb_ack = wbm_ack_i;
	
	//Determines which set of blockram to read from:
    wb_dat = adr[1] ? wbm_dat_i[31:16] : wbm_dat_i[15:0];
	
  //Address is 0x3C, return memory window address to calling bus
  end else begin
	
	//Blockram not addressed
    wbm_cyc = 1'b0;
    wbm_stb = 1'bx;
    wb_ack = wb_cyc_i && wb_stb_i;
    wb_dat = adr;
	
  end
  
end

endmodule

//NOT USED IN THIS IMPLEMENTATION:

/* This core is a simple core to allow access to an up to 64Kbyte WISHBONE
 * address space via a 4 16-bit register window.  
 * 
 * Register map:
 * base + 0x0: Address reg (RW)
 * base + 0x2: 8-bit data reg with auto-increment (RW)
 *
 * * When the data reg is read or written, the address is automatically
 *   incremented by 1.  In this way, contiguous reads/writes of address
 *   space is optimized.
 *
 * base + 0x4: 16-bit data reg with auto-increment (RW)
 *
 * * When the 16-bit data reg is read or written, 2 read or write 8-bit
 *   bus cycles are performed and the address is incremented by 2.
 *
 * base + 0x6: Combo address/data write reg (WO)
 *   bits 15-8: address bits 7-0 of bus write
 *   bits 7-0: data bits of bus write cycle.
 *
 * * This register is only meaningful write-only.  It encodes the 8 LSBs
 *   of the address as the 8 MSBs of the written data word.
 */

module wb_memwindow16to8(
  wb_clk_i,
  wb_rst_i,
  wb_cyc_i,
  wb_stb_i,
  wb_we_i,
  wb_adr_i,
  wb_sel_i,
  wb_dat_i,
  wb_dat_o,
  wb_ack_o,

  wbm_cyc_o,
  wbm_stb_o,
  wbm_we_o,
  wbm_adr_o,
  wbm_dat_o,
  wbm_dat_i,
  wbm_ack_i
);

input wb_clk_i, wb_rst_i, wb_cyc_i, wb_stb_i, wb_we_i;
output wb_ack_o;
output [15:0] wb_dat_o;
input [15:0] wb_dat_i, wb_adr_i;
input [1:0] wb_sel_i;

output wbm_cyc_o, wbm_stb_o, wbm_we_o;
output [7:0] wbm_dat_o;
output [15:0] wbm_adr_o;
input [7:0] wbm_dat_i;
input wbm_ack_i;

reg [15:0] adr;
reg [15:0] wb_dat;
reg holdack, holdstb;
reg [7:0] datlatch;
reg wbm_cyc, wbm_stb, wb_ack;
always @(posedge wb_clk_i or posedge wb_rst_i) begin
  if (wb_rst_i) begin
    adr <= 16'd0;
    holdack <= 1'b1;
    datlatch <= 8'd0;
    holdstb <= 1'b0;
  end else begin
    case (wb_adr_i[2:1])
    2'd0: if (wb_cyc_i && wb_stb_i && wb_we_i) adr <= wb_dat_i;
    2'd1: if (wbm_cyc && wbm_stb && wbm_ack_i) adr <= adr + 1'b1;
    2'd2: if (wbm_cyc && wbm_stb && wbm_ack_i) begin
      adr <= adr + 1'b1;
      if (holdack) begin
        holdack <= 1'b0;
        datlatch <= wbm_dat_i[7:0];
      end else holdack <= 1'b1; 
    end
    2'd3: if (wbm_cyc && wbm_stb && wbm_ack_i) adr[7:0] <= wb_dat_i[15:8] + 1'b1;
    endcase
    holdstb <= 1'b0;
    if (wbm_cyc && wbm_stb && wbm_ack_i) holdstb <= 1'b1;
  end
end

assign wbm_cyc_o = wbm_cyc;
assign wbm_stb_o = wbm_stb;
assign wb_ack_o = wb_ack;
reg [7:0] wbm_dat;
assign wbm_dat_o = wbm_dat;
assign wb_dat_o = wb_dat;
reg [15:0] wbm_adr;
assign wbm_adr_o = wbm_adr;
assign wbm_we_o = wb_we_i;
always @(*) begin
  case (wb_adr_i[2:1]) 
  2'd0: begin
    wbm_cyc = 1'b0;
    wbm_stb = 1'bx;
    wbm_dat = 8'hxx;
    wbm_adr = 16'hxxxx;
    wb_ack = wb_cyc_i && wb_stb_i;
    wb_dat = adr;
  end
  2'd1: begin
    wbm_adr = adr;
    wbm_cyc = wb_cyc_i;
    wbm_stb = wb_stb_i && !holdstb;
    wbm_dat = wb_dat_i[7:0];
    wb_ack = wbm_ack_i && !holdstb;
    wb_dat = {8'hxx, wbm_dat_i[7:0]};
  end
  2'd2: begin
    wbm_adr = adr;
    wbm_cyc = wb_cyc_i;
    wbm_stb = wb_stb_i && !holdstb;
    wbm_dat = holdack ? wb_dat_i[7:0] : wb_dat_i[15:8];
    wb_ack = wbm_ack_i && !holdack && !holdstb;
    wb_dat = {wbm_dat_i[7:0], datlatch};
  end
  2'd3: begin
    wbm_adr = {adr[15:8], wb_dat_i[15:8]};
    wbm_cyc = wb_cyc_i;
    wbm_stb = wb_stb_i && !holdstb;
    wbm_dat = wb_dat_i[7:0];
    wb_ack = wbm_ack_i && !holdstb;
    wb_dat = 16'hxxxx;
  end
  endcase
end


endmodule
