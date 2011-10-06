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

/* The TS-7500 was released Jul. 2009 and is comprised of a Cavium
 * CNS2132 250Mhz ARM9 CPU, Lattice XP2 5k FPGA, 64MB DDR SDRAM, and
 * 4MByte SPI NOR flash chip.  
 *
 * FPGA functions include:
 *   - micro SD slot 
 *   - SPI controller for 4MByte SPI flash chips on TS-7500 and TS-752.
 *   - DIO pins on the 40 pin header
 *   - Processor bootstrap + TS-BOOTROM firmware store
 *   - I2C RTC interface
 *   - watchdog
 *   - 8 XUART channels
 *   - storage of board MAC address and CPU speed mode in Lattice tagmem.
 *   - miscellaneous glue logic
 *   - optional CAN controller
 *   
 * CPU bootstrap is accomplished by the FPGA emulating a SPI flash
 * chip.  TS-BOOTROM resides in a 16KByte initialized blockram in the
 * FPGA.
 *
 * WISHBONE bridge interface is accomplished with a custom SPI protocol
 * "SBUS" and has provision currently for 128 bytes of registers.
 *
 */

module ts7500_top( 
  cpu_clkout_pad,
  fpga_25mhz_pad,
  clk_32khz_pad,

  dio_pad,

  cpu_uart_txd_pad,
  cpu_uart_rxd_pad,

  /* spi interface */
  spi_clk_pad,
  spi_mosi_pad,
  spi_miso_pad,

  gpio_a0_pad,
  gpio_a1_pad,

  gpio_a13_pad,
  gpio_a14_pad,

  gpio_a3_pad,
  gpio_a15_pad,
  gpio_a16_pad,
  gpio_a17_pad,

  gpio_a28_pad,
  gpio_a29_pad,

  int28_pad,

  gpio_a22_pad,
  gpio_a23_pad,

  /* reset pins */
  un_reset_pad,
  wd_resetn_pad,

  /* sd interface */
  en_sd_power_pad,
  sd_d0_pad,
  sd_d1_pad,
  sd_d2_pad,
  sd_d3_pad,
  sd_cmd_pad,
  sd_clk_pad,

  /* led control pins */
  red_led_pad,
  green_led_pad,

  /* ethernet led control pins */
  eth_left_ledn_pad,
  eth_right_ledn_pad,

  /* rtc pins */
  rtc_sda_pad,
  rtc_scl_pad,
  rtc_int1_pad,

  /* serial flash pins */
  ser_flash_wp_padn,
  ser_flash_cs_padn,
  flash_clk_pad,
  flash_mosi_pad,
  flash_miso_pad

);

/* global signals */
input fpga_25mhz_pad;
input cpu_clkout_pad;

//DIO control
inout [40:0] dio_pad;

input cpu_uart_txd_pad;
output cpu_uart_rxd_pad;
output clk_32khz_pad;

/* spi interface */
input spi_clk_pad;
input spi_mosi_pad;
inout spi_miso_pad;

/* interrupts */
output gpio_a0_pad;
output gpio_a1_pad;

/* i2c */
inout gpio_a13_pad;
inout gpio_a14_pad;

/* i2s */
inout gpio_a3_pad;
inout gpio_a15_pad;
inout gpio_a16_pad;
inout gpio_a17_pad;

inout gpio_a28_pad;  //SPI_CS0
inout gpio_a29_pad;  //SPI_CS1

inout int28_pad;

inout gpio_a22_pad;
inout gpio_a23_pad;

/* reset pins */
output un_reset_pad;
inout wd_resetn_pad;

/* sd interface */
output en_sd_power_pad;
inout sd_d0_pad;
inout sd_d1_pad;
inout sd_d2_pad;
inout sd_d3_pad;
inout sd_cmd_pad;
output sd_clk_pad /* synthesis syn_maxfan=1 syn_useioff=1 */;

/* serial flash pins */
output ser_flash_wp_padn;
output ser_flash_cs_padn;
output flash_mosi_pad;
output flash_clk_pad;
input flash_miso_pad;

/* led control pins */
output red_led_pad;
output green_led_pad;

/* ethernet led control pins */
output eth_left_ledn_pad;
output eth_right_ledn_pad;

/* rtc pins */
inout rtc_sda_pad;
output rtc_scl_pad;
input rtc_int1_pad;

assign gpio_a13_pad = 1'bz;
assign gpio_a14_pad = 1'bz;
assign gpio_a3_pad = 1'bz;
assign gpio_a15_pad = 1'bz;
assign gpio_a16_pad = 1'bz;
assign gpio_a17_pad = 1'bz;
assign gpio_a28_pad = 1'bz;
assign gpio_a29_pad = 1'bz;
assign gpio_a22_pad = 1'bz;
assign gpio_a23_pad = 1'bz;
assign eth_left_ledn_pad = gpio_a22_pad;
assign eth_right_ledn_pad = gpio_a23_pad;

parameter spi_opt = 1'b1;

/****************************************************************************
 * Boilerplate FPGA configuration (clocks, PLL, DLL, reset) - REQUIRED
 ****************************************************************************/
 
wire pll_75mhz, pll_75mhz_shifted, pll_100mhz, pll_750khz, spi_50mhz_clk;
wire lock, lock2;
wire [4:0] pllphase;

pll clkgen (
  .CLK(fpga_25mhz_pad),
  .CLKOP(pll_75mhz),
  .CLKOS(pll_75mhz_shifted),
  .CLKOK(pll_750khz),
  .LOCK(lock),
  .DPHASE3(pllphase[4]),
  .DPHASE2(pllphase[3]),
  .DPHASE1(pllphase[2]),
  .DPHASE0(pllphase[1]),
  .WRDEL(pllphase[0])
);

pll2 clkgen2 (
  .CLK(fpga_25mhz_pad),
  .CLKOP(pll_100mhz),
  .LOCK(lock2)
);

wire internal_osc;
reg [15:0] rst_counter = 16'd0;
reg rstn = 1'b0;

always @(posedge internal_osc) begin
  if (lock && lock2) rst_counter <= rst_counter + 1'b1;
  else begin
    rst_counter <= 16'd0;
    rstn <= 1'b0;
  end
  if (rst_counter[15]) rstn <= 1'b1;
end

wire rst = !rstn;
wire reboot;
assign wd_resetn_pad = !reboot;
reg [31:0] timer;
reg unreset;
reg spi_boot_done;
wire sbus_enabled;

//Interrupts to CPU:

//wire can_irqn, xuart_irq;
assign gpio_a0_pad = 1'b0;//xuart_irq;
assign gpio_a1_pad = 1'b0;//(!can_irqn && can_opt);

wire [4:0] gpio_a17to13 = {gpio_a17_pad, gpio_a16_pad, gpio_a15_pad, gpio_a14_pad, gpio_a13_pad};
assign un_reset_pad = unreset;
wire wb_clk;
reg mode1, mode2, mode3;

//Boot device controller
always @(posedge pll_75mhz or posedge rst) begin
  if (rst) begin
    timer <= 32'd0;
    unreset <= 1'b0;
    spi_boot_done <= 1'b0;
    mode1 <= 1'b1;
    mode2 <= 1'b1;
    mode3 <= 1'b1;
  end else begin
    timer <= timer + 1'b1;
    if (timer >= 32'd64) begin
      unreset <= 1'b1;
      if (!unreset) begin
        mode1 <= dio_pad[7];
        mode2 <= dio_pad[5];
        mode3 <= gpio_a22_pad;
      end
    end
    if (unreset && gpio_a17to13[4:2] == 3'b110)
      spi_boot_done <= 1'b1;
  end
end

assign ser_flash_wp_padn = unreset;
assign clk_32khz_pad = 1'b0;

//reg [4:0] seq_24mhz;
//reg clk_24mhz;
//wire can_enable;
/*
always @(posedge pll_100mhz or posedge rst) begin
  if (rst) begin
    clk_24mhz <= 1'b1;
    seq_24mhz <= 5'd0;
  end else if (can_enable) begin
    seq_24mhz <= seq_24mhz + 1'b1;
    case (seq_24mhz)
    1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21: clk_24mhz <= !clk_24mhz;
    24: begin
      clk_24mhz <= !clk_24mhz;
      seq_24mhz <= 5'd0;
    end
    endcase
  end
end
*/

//Onboard LEDs
wire led_red;
assign red_led_pad = !led_red;
wire led_grn;
assign green_led_pad = !led_grn;

//Main reset signal
assign wb_rst = rst;

//Wishbone clock
assign dcs_clk = pll_100mhz;//pll_75mhz;

/****************************************************************************
 * SBUS protocol core (SPI -> WISHBONE bridge) - REQUIRED
 ****************************************************************************/ 
 
assign sbus_enabled = 1'b1;

wire 			spi_cs0 = gpio_a28_pad;
wire 			spiboot_so;
wire 			sbus_so;

wire 			spiwbm_cyc_o, spiwbm_stb_o, spiwbm_we_o;
wire 	[4:0] 	spiwbm_adr_o;
wire 	[15:0] 	spiwbm_dat_o;
reg 			spiwbm_ack_i;
reg 	[15:0] 	spiwbm_dat_i;
wire 	[1:0] 	spiwbm_sel_o;

wire 			spiwbm2_cyc_o, spiwbm2_stb_o, spiwbm2_we_o;
wire 	[4:0] 	spiwbm2_adr_o;
wire 	[15:0] 	spiwbm2_dat_o;
reg 			spiwbm2_ack_i;
reg 	[15:0] 	spiwbm2_dat_i;
wire 	[1:0] 	spiwbm2_sel_o;
reg 			spiwbm2_en;
wire 			spiwbm2_clk;
wire 	[3:0] 	spiwbm32_sel_o = spiwbm_adr_o[1] ? {spiwbm_sel_o, 2'b00} : {2'b00, spiwbm_sel_o};

assign wb_clk = dcs_clk;

/* Note: Cavium SPI interface will actually work at 62.5Mhz even
 * though its only spec'ed to 50Mhz! 
 */
 
spi_sbus_resync sbuscore(
  .wbm_clk_i(dcs_clk),
  .wbm_adr_o(spiwbm_adr_o),
  .wbm_dat_i(spiwbm_dat_i),
  .wbm_ack_i(spiwbm_ack_i),
  .wbm_cyc_o(spiwbm_cyc_o),
  .wbm_stb_o(spiwbm_stb_o),
  .wbm_we_o(spiwbm_we_o),
  .wbm_dat_o(spiwbm_dat_o),
  .wbm_sel_o(spiwbm_sel_o),

  .wbm2_clk_o(spiwbm2_clk),
  .wbm2_en_i(spiwbm2_en),
  .wbm2_adr_o(spiwbm2_adr_o),
  .wbm2_dat_i(spiwbm2_dat_i),
  .wbm2_ack_i(spiwbm2_ack_i),
  .wbm2_cyc_o(spiwbm2_cyc_o),
  .wbm2_stb_o(spiwbm2_stb_o),
  .wbm2_we_o(spiwbm2_we_o),
  .wbm2_dat_o(spiwbm2_dat_o),
  .wbm2_sel_o(spiwbm2_sel_o),

  .rst_i(wb_rst),
  .csn_i(spi_cs0 || !sbus_enabled),
  .sck_i(spi_clk_pad),
  .si_i(spi_mosi_pad),
  .so_o(sbus_so),
  .sel_i({gpio_a17_pad, gpio_a3_pad})

);

assign spi_miso_pad = sbus_so;

/****************************************************************************
 * SPI controller logic - REQUIRED
 ****************************************************************************/
 
reg 			spiwbs_en;
wire 	[15:0] 	spiwbs_dat_o;
wire 			spiwbs_ack_o;
wire 			scken;
wire 	[3:0] 	csn;
reg 	[3:0] 	csn_q;

always @(posedge wb_clk) csn_q <= csn;
	
assign 			ser_flash_cs_padn = csn[0];
wire 	[3:0] 	si = {{3{dio_pad[12]}}, flash_miso_pad};
wire 			sck, hispeed;
assign 			flash_clk_pad = hispeed ? (pll_75mhz_shifted | !scken) : sck;
wire 			so;
assign 			flash_mosi_pad = so;

wb_spi spicore(
  .wb_rst_i(wb_rst),
  .wb_clk_i(wb_clk & spi_opt),
  .wb_cyc_i(spiwbm_cyc_o && spiwbs_en),
  .wb_stb_i(spiwbm_stb_o && spiwbs_en),
  .wb_dat_o(spiwbs_dat_o),
  .wb_dat_i(spiwbm_dat_o),
  .wb_adr_i(spiwbm_adr_o),
  .wb_we_i(spiwbm_we_o),
  .wb_ack_o(spiwbs_ack_o),
  .wb_sel_i(spiwbm_sel_o),

  .scken_o(scken),
  .so_o(so),
  .si_i(si),
  .csn_o(csn),
  .sck_o(sck),
  .hispeed_o(hispeed)
);

/****************************************************************************
 * Syscon (misc control registers) - REQUIRED
 ****************************************************************************/
reg 			scwbs_en;
wire 	[15:0] 	scwbs_dat_o;
wire 			scwbs_ack_o;	

wire 			rtc_sda, rtc_scl, rtc_sda_oe, rtc_scl_oe;
assign 			rtc_sda_pad = rtc_sda_oe ? rtc_sda : 1'bz;
assign 			rtc_scl_pad = rtc_scl_oe ? rtc_scl : 1'bz;
wire 	[40:0] 	dio, dio_oe;
integer 		i;
wire 			can_tx, can_wbaccess;
reg 	[40:0] 	dio_reg;

wire			sigmaDeltaOut;
wire			dac_cs, dac_sdi;

assign 			dio_pad = {dio_reg[40:26], sigmaDeltaOut, dac_sdi,fpga_25mhz_pad,dac_cs,dio_reg[21:0]};	

assign dio_oe[21:17] = 5'b0;		//Input pins from ADC
assign dio_oe[25:22] = 4'b1;		//Biquad and dac outputs

always @(*) begin
  for (i = 0; i <= 40; i = i + 1) begin
    dio_reg[i] = dio_oe[i] ? dio[i] : 1'bz;
  end

  /* DIO#7 is one of our latched bootstrap pins */
  if (!unreset) dio_reg[7] = 1'bz;

  /* SPI controller hijacks some pins when LUN#1, #2, or #3 is active */
  if (spi_opt) begin
    if (csn_q[1] == 1'b0) dio_reg[11] = 1'b1;
    if (csn_q[2] == 1'b0) dio_reg[37] = 1'b1;
    if (csn_q[3] == 1'b0) dio_reg[39] = 1'b1;
    if (csn[1] == 1'b0) dio_reg[11] = csn[1];
    if (csn[2] == 1'b0) dio_reg[37] = csn[2];
    if (csn[3] == 1'b0) dio_reg[39] = csn[3];
    if (csn[3:1] != 3'b111) begin
      dio_reg[14] = hispeed ? (pll_75mhz_shifted | !scken) : sck;
      dio_reg[13] = so;
      dio_reg[12] = 1'bz;
    end
  end

end

syscon #(.wdog_default(3)) sysconcore(
  .wb_clk_i(spiwbm2_clk),
  .wb_rst_i(wb_rst),

  .wb_cyc_i(spiwbm2_cyc_o && scwbs_en),
  .wb_stb_i(spiwbm2_stb_o && scwbs_en),
  .wb_we_i(spiwbm2_we_o),
  .wb_adr_i(spiwbm2_adr_o),
  .wb_dat_i(spiwbm2_dat_o),
  .wb_sel_i(spiwbm2_sel_o),
  .wb_dat_o(scwbs_dat_o),
  .wb_ack_o(scwbs_ack_o),

  .dio_i(dio_pad),
  .dio_oe_o(dio_oe),
  .dio_o(dio),

  .rtc_sda_o(rtc_sda),
  .rtc_sda_i(rtc_sda_pad),
  .rtc_sda_oe_o(rtc_sda_oe),
  .rtc_scl_o(rtc_scl),
  .rtc_scl_i(rtc_scl_pad),
  .rtc_scl_oe_o(rtc_scl_oe),

  .cpu_uart_txd_i(cpu_uart_txd_pad),
  .cpu_uart_rxd_o(cpu_uart_rxd_pad),

  .clk_100mhz_i(pll_100mhz),
  .reboot_o(reboot),
  .led_grn_o(led_red),
  .led_red_o(led_grn),
  .mode1_i(mode1),
  .mode2_i(mode2),
  .mode3_i(mode3),
  .pllphase_o(pllphase),
  .internal_osc_o(internal_osc)
);

/****************************************************************************
 * Blockram for storing biquad coefficients (4kbytes, 16 bit)
 ***************************************************************************/
 
//NOTE: this blockram module is a SLAVE on both wishbone ports
 
//Wires from coefficient memory window
wire 	[10:0]	cmemwin_wb_adr_o;
wire	[15:0]	cmemwin_wb_dat_o;
wire			cmemwin_wb_cyc_o;
wire			cmemwin_wb_stb_o;
wire			cmemwin_wb_ack_i;
wire 			cmemwin_wb_we_o;

//Wires from biquad coefficient port
wire	[7:0]	bq_coeff_wb_adr_o;
wire			bq_coeff_wb_cyc_o;
wire			bq_coeff_wb_stb_o;
wire	[127:0]	bq_coeff_wb_dat_i;
wire			bq_coeff_wb_ack_i;

coefficient_blockram coefficient_blockram(

  .wb_clk_i(wb_clk),
  .wb_rst_i(wb_rst),

  //From coefficient memory window
  .cmemwin_wb_adr_i(cmemwin_wb_adr_o),
  .cmemwin_wb_dat_i(cmemwin_wb_dat_o),
  .cmemwin_wb_cyc_i(cmemwin_wb_cyc_o),
  .cmemwin_wb_stb_i(cmemwin_wb_stb_o),
  .cmemwin_wb_ack_o(cmemwin_wb_ack_i),
  .cmemwin_wb_we_i(cmemwin_wb_we_o),

  //From biquad module
  .biquad_wb_adr_i(bq_coeff_wb_adr_o),
  .biquad_wb_cyc_i(bq_coeff_wb_cyc_o),
  .biquad_wb_stb_i(bq_coeff_wb_stb_o),
  .biquad_wb_dat_o(bq_coeff_wb_dat_i),
  .biquad_wb_ack_o(bq_coeff_wb_ack_i)
  
);

/****************************************************************************
 * Blockram for storing logged data from biquad (8kbytes, 16 bit)
 ***************************************************************************/
 
 //Wires from logging memory window
 wire			lmemwin_wb_cyc_o;
 wire 			lmemwin_wb_stb_o;
 wire	[11:0]	lmemwin_wb_adr_o;
 wire	[15:0]	lmemwin_wb_dat_i;
 wire			lmemwin_wb_ack_i;
 
 //Wires from biquad logging port
 wire			bq_log_wb_cyc_o;
 wire			bq_log_wb_stb_o;
 wire	[11:0]	bq_log_wb_adr_o;
 wire			bq_log_wb_we_o;
 wire	[15:0]	bq_log_wb_dat_o;
 wire			bq_log_wb_ack_i;
 
 logging_blockram logging_blockram(

  .wb_clk_i(wb_clk),
  .wb_rst_i(wb_rst),
  
  .lmemwin_wb_cyc_i(lmemwin_wb_cyc_o),
  .lmemwin_wb_stb_i(lmemwin_wb_stb_o),
  .lmemwin_wb_adr_i(lmemwin_wb_adr_o),
  .lmemwin_wb_dat_o(lmemwin_wb_dat_i),
  .lmemwin_wb_ack_o(lmemwin_wb_ack_i),
  
  .biquad_wb_cyc_i(bq_log_wb_cyc_o),
  .biquad_wb_stb_i(bq_log_wb_stb_o),
  .biquad_wb_adr_i(bq_log_wb_adr_o),
  .biquad_wb_we_i(bq_log_wb_we_o),
  .biquad_wb_dat_i(bq_log_wb_dat_o),
  .biquad_wb_ack_o(bq_log_wb_ack_i)
  
);

/****************************************************************************
 * Memory Window for biquad coefficient blockram
 ***************************************************************************/
 
reg 			cmemwin_wbs_en;
wire 	[15:0] 	cmemwin_wbs_dat_o;
wire 			cmemwin_wbs_ack_o;

wire 			load_new_coefficients;
wire			done_loading;

coefficient_memwindow coefficient_memwindow(

  .wb_clk_i(wb_clk),
  .wb_rst_i(wb_rst),
  
  //From sbus
  .sbus_wb_cyc_i(spiwbm_cyc_o && cmemwin_wbs_en),
  .sbus_wb_stb_i(spiwbm_stb_o && cmemwin_wbs_en),
  .sbus_wb_we_i(spiwbm_we_o),
  .sbus_wb_adr_i(spiwbm_adr_o),
  .sbus_wb_sel_i(spiwbm_sel_o),
  .sbus_wb_dat_i(spiwbm_dat_o),
  .sbus_wb_dat_o(cmemwin_wbs_dat_o),
  .sbus_wb_ack_o(cmemwin_wbs_ack_o),
  
  //To blockram - write only
  .cbram_wb_we_o(cmemwin_wb_we_o),
  .cbram_wb_cyc_o(cmemwin_wb_cyc_o),
  .cbram_wb_stb_o(cmemwin_wb_stb_o),
  .cbram_wb_adr_o(cmemwin_wb_adr_o),
  .cbram_wb_dat_o(cmemwin_wb_dat_o),
  .cbram_wb_ack_i(cmemwin_wb_ack_i),
  
  .load_new_coefficients(load_new_coefficients),
  .done_loading(done_loading)
  
);

/****************************************************************************
 * Memory Window for data logging blockram
 ***************************************************************************/
 
reg 			lmemwin_wbs_en;
wire 	[15:0] 	lmemwin_wbs_dat_o;
wire 			lmemwin_wbs_ack_o;

logging_memwindow logging_memwindow(
	
  .wb_clk_i(wb_clk),
  .wb_rst_i(wb_rst),
  
  //From sbus (read only)
  .sbus_wb_cyc_i(spiwbm_cyc_o && lmemwin_wbs_en),
  .sbus_wb_stb_i(spiwbm_stb_o && lmemwin_wbs_en),
  .sbus_wb_we_i(spiwbm_we_o),
  .sbus_wb_adr_i(spiwbm_adr_o),
  .sbus_wb_sel_i(spiwbm_sel_o),
  .sbus_wb_dat_i(spiwbm_dat_o),
  .sbus_wb_dat_o(lmemwin_wbs_dat_o),
  .sbus_wb_ack_o(lmemwin_wbs_ack_o),

  //To blockram module - read only
  .lbram_wb_cyc_o(lmemwin_wb_cyc_o),
  .lbram_wb_stb_o(lmemwin_wb_stb_o),
  .lbram_wb_adr_o(lmemwin_wb_adr_o),
  .lbram_wb_dat_i(lmemwin_wb_dat_i),
  .lbram_wb_ack_i(lmemwin_wb_ack_i)
  
);

/****************************************************************************
 * ADC Buffers
 ***************************************************************************/
 /*
 wire			new_adc_data;
 
 wire	[31:0]	adc_a_buf_o;
 wire	[31:0]	adc_b_buf_o;
 wire	[31:0]	adc_c_buf_o;
 wire	[31:0]	adc_d_buf_o;
 
 adc_buffer adc_buffer(

	.reset(wb_rst_i),
	
	.adc_a_i(dio_pad[17]),
	.adc_b_i(dio_pad[18]),
	.adc_c_i(dio_pad[19]),
	.adc_d_i(dio_pad[20]),
	.adc_clk_i(dio_pad[21]),
	
	.buffer_full(new_adc_data),
	
	.adc_a_buf_o(adc_a_buf_o),
	.adc_b_buf_o(adc_b_buf_o),
	.adc_c_buf_o(adc_c_buf_o),
	.adc_d_buf_o(adc_d_buf_o)

);
*/
/****************************************************************************
 * Biquad filter
 ***************************************************************************/

wire			sigmaDeltaInput;

assign sigmaDeltaInput = dio_pad[19];

wb_biquad_interface_128 biquad1(

	.wb_clk_i(wb_clk),
	.wb_rst_i(wb_rst),
	
	.filter_clk_i(dio_pad[21]),
	
	.log_wbm_cyc_o(bq_log_wb_cyc_o),
	.log_wbm_stb_o(bq_log_wb_stb_o),
	.log_wbm_we_o(bq_log_wb_we_o),
	.log_wbm_adr_o(bq_log_wb_adr_o),
	.log_wbm_dat_o(bq_log_wb_dat_o),
	.log_wbm_ack_i(bq_log_wb_ack_i),
	
	.coeff_wbm_cyc_o(bq_coeff_wb_cyc_o),
	.coeff_wbm_stb_o(bq_coeff_wb_stb_o),
	.coeff_wbm_adr_o(bq_coeff_wb_adr_o),
	.coeff_wbm_dat_i(bq_coeff_wb_dat_i),
	.coeff_wbm_ack_i(bq_coeff_wb_ack_i),
	
	.load_new_coefficients(load_new_coefficients),
	.done_loading(done_loading),
	
	.sigmaDeltaInput(sigmaDeltaInput),
	.sigmaDeltaOutput(sigmaDeltaOut)

);

/*****************************************************************************
 * DAC-Filter Interface Module
 ****************************************************************************/

sigma_delta_buffer_filter sigmaDeltaDACOuput(

	.decimation_clk(pll_750khz),
	.dac_clk(fpga_25mhz_pad),
	.adc_clk(dio_pad[21]),
	.reset(wb_rst),
	
	.sigmaDeltaIn(sigmaDeltaOut),
	
	.dac_sdo(dac_sdi),
	.dac_cs(dac_cs)

);

/*
wire	[3:0]	dac_command;
wire	[3:0]	dac_address;
wire	[15:0]	dac_value;

wire			load_dac;

dac_spi_module dac(

	.clk25(fpga_25mhz_pad),//spi_50mhz_clk),
	.reset(wb_rst),
	
	.cmd(dac_command),
	.addr(dac_address),
	.value(dac_value),
	
	.send_data(load_dac),

	.sdo(dac_sdi),
	.cs(dac_cs)

);

//Ramp generator for DAC testing

reg		[4:0]	ramp_ctr;
reg		[15:0]	value_reg;
reg				load_reg;

always@(posedge fpga_25mhz_pad) begin
	
	ramp_ctr <= ramp_ctr + 1;
	load_reg <= 1'b0;
	
	if(ramp_ctr == 5'b1) begin
		value_reg <= value_reg + 1;
		load_reg <= 1'b1;
		ramp_ctr <= 5'b0;
	end	
	
end

assign dac_command = 4'b0010;
assign dac_address = 4'b1111;
assign load_dac = load_reg;
assign dac_value = value_reg;
*/

/****************************************************************************
 * SPI SBUS address decode - REQUIRED
 ****************************************************************************/
 
assign gpio_a23_pad = 1'bz;
assign gpio_a22_pad = 1'bz;

always @(*) begin

	//Enable bits for memory windows
	cmemwin_wbs_en = 1'b0;
	lmemwin_wbs_en = 1'b0;
	
	//Enable bit for SPI Flash interface
	spiwbs_en = 1'b0;
	
	//Enable bits for syscon
	scwbs_en = 1'b0;
	spiwbm2_en = 1'b0;

	//Idle states of data and ack lines
	//Provides auto-ack when unused address space is addressed
	spiwbm_dat_i = 16'hxxxx;
	spiwbm_ack_i = 1'b1;
	spiwbm2_dat_i = 16'hxxxx;
	spiwbm2_ack_i = 1'b1;

	/* Top level address decode:
     *
     * 0x00 - Biquad coefficient memory window
     * 0x10 - Data logging memory window
     * 0x20 - EMPTY
     * 0x40 - SPI interface (for NOR flash)
     * 0x50 - EMPTY
     * 0x60 - Syscon
     *
     * 4 bits of address come from the SBUS interface, 2 bits of address come
     * from GPIO A16 and A15 and each address represents 16-bit registers.  Total
     * 128 bytes of address space (64 16-bit regs)
     *
     * It is possible to 8-bit writes via GPIO A17 and A3 which act as active high
     * byte lane selects.
     */
   
	case ({gpio_a16_pad, gpio_a15_pad})
	
	//Addresses 0x00 to 0x1F
	2'd0: begin
		
		//Address 0x00 to 0x0F
		if(!spiwbm_adr_o[4]) begin
			cmemwin_wbs_en = 1'b1;
			spiwbm_dat_i = cmemwin_wbs_dat_o;
			spiwbm_ack_i = cmemwin_wbs_ack_o;
		
		//Address 0x10 to 0x1F
		end else begin
			lmemwin_wbs_en = 1'b1;
			spiwbm_dat_i = lmemwin_wbs_dat_o;
			spiwbm_ack_i = lmemwin_wbs_ack_o;
		end
			
	end
	
	//Addresses 0x20 to 0x3F
	2'd1: begin
		//Move along, nothing to see here
	end
	
	//Addresses 0x40 to 0x5F
	2'd2: begin
		
		//Address is 0x50 to 0x5F
		if (spiwbm_adr_o[4:0] >= 5'h10) begin
	
		//Address is 0x40 to 0x4F
		end else begin
			spiwbs_en = 1'b1;
			spiwbm_dat_i = spiwbs_dat_o;
			spiwbm_ack_i = spiwbs_ack_o;
		end
	end
	
	//Addresses 0x60 to 0x7F
	2'd3: begin
		
		scwbs_en = 1'b1;
		/* SYSCON can use the SBUS "shortcut" WISHBONE interface by being clocked
		 * by the (intermittent/non-continuous) SPI SCK 
		 */
		spiwbm2_en = 1'b1;  
		spiwbm2_dat_i = scwbs_dat_o;
		spiwbm2_ack_i = scwbs_ack_o;
		/*
		spiwbm_dat_i = scwbs_dat_o;
		spiwbm_ack_i = scwbs_ack_o;
		*/    
	end

	endcase
	
end

endmodule
