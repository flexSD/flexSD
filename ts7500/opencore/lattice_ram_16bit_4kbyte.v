/* Verilog netlist generated by SCUBA Diamond_1.2_Production (92) */
/* Module Version: 6.1 */
/* /usr/local/diamond/1.2/ispfpga/bin/lin/scuba -w -lang verilog -synth synplify -bus_exp 7 -bb -arch mg5a00 -type bram -wp 10 -rp 0011 -rdata_width 128 -data_width 16 -num_rows 2048 -outdata REGISTERED -resetmode SYNC -cascade -1 -e  */
/* Tue Sep 20 16:41:08 2011 */


`timescale 1 ns / 1 ps
module lattice_ram_16bit_4kbyte (WrAddress, RdAddress, Data, WE, RdClock, 
    RdClockEn, Reset, WrClock, WrClockEn, Q);
    input wire [10:0] WrAddress;
    input wire [7:0] RdAddress;
    input wire [15:0] Data;
    input wire WE;
    input wire RdClock;
    input wire RdClockEn;
    input wire Reset;
    input wire WrClock;
    input wire WrClockEn;
    output wire [127:0] Q;

    wire scuba_vhi;
    wire scuba_vlo;

    VHI scuba_vhi_inst (.Z(scuba_vhi));

    // synopsys translate_off
    defparam lattice_ram_16bit_4kbyte_0_0_3.CSDECODE_B =  3'b000 ;
    defparam lattice_ram_16bit_4kbyte_0_0_3.CSDECODE_A =  3'b000 ;
    defparam lattice_ram_16bit_4kbyte_0_0_3.WRITEMODE_B = "NORMAL" ;
    defparam lattice_ram_16bit_4kbyte_0_0_3.WRITEMODE_A = "NORMAL" ;
    defparam lattice_ram_16bit_4kbyte_0_0_3.GSR = "DISABLED" ;
    defparam lattice_ram_16bit_4kbyte_0_0_3.RESETMODE = "SYNC" ;
    defparam lattice_ram_16bit_4kbyte_0_0_3.REGMODE_B = "OUTREG" ;
    defparam lattice_ram_16bit_4kbyte_0_0_3.REGMODE_A = "OUTREG" ;
    defparam lattice_ram_16bit_4kbyte_0_0_3.DATA_WIDTH_B = 36 ;
    defparam lattice_ram_16bit_4kbyte_0_0_3.DATA_WIDTH_A = 4 ;
    // synopsys translate_on
    DP16KB lattice_ram_16bit_4kbyte_0_0_3 (.DIA0(Data[0]), .DIA1(Data[1]), 
        .DIA2(Data[2]), .DIA3(Data[3]), .DIA4(scuba_vlo), .DIA5(scuba_vlo), 
        .DIA6(scuba_vlo), .DIA7(scuba_vlo), .DIA8(scuba_vlo), .DIA9(scuba_vlo), 
        .DIA10(scuba_vlo), .DIA11(scuba_vlo), .DIA12(scuba_vlo), .DIA13(scuba_vlo), 
        .DIA14(scuba_vlo), .DIA15(scuba_vlo), .DIA16(scuba_vlo), .DIA17(scuba_vlo), 
        .ADA0(scuba_vlo), .ADA1(scuba_vlo), .ADA2(WrAddress[0]), .ADA3(WrAddress[1]), 
        .ADA4(WrAddress[2]), .ADA5(WrAddress[3]), .ADA6(WrAddress[4]), .ADA7(WrAddress[5]), 
        .ADA8(WrAddress[6]), .ADA9(WrAddress[7]), .ADA10(WrAddress[8]), 
        .ADA11(WrAddress[9]), .ADA12(WrAddress[10]), .ADA13(scuba_vlo), 
        .CEA(WrClockEn), .CLKA(WrClock), .WEA(WE), .CSA0(scuba_vlo), .CSA1(scuba_vlo), 
        .CSA2(scuba_vlo), .RSTA(Reset), .DIB0(scuba_vlo), .DIB1(scuba_vlo), 
        .DIB2(scuba_vlo), .DIB3(scuba_vlo), .DIB4(scuba_vlo), .DIB5(scuba_vlo), 
        .DIB6(scuba_vlo), .DIB7(scuba_vlo), .DIB8(scuba_vlo), .DIB9(scuba_vlo), 
        .DIB10(scuba_vlo), .DIB11(scuba_vlo), .DIB12(scuba_vlo), .DIB13(scuba_vlo), 
        .DIB14(scuba_vlo), .DIB15(scuba_vlo), .DIB16(scuba_vlo), .DIB17(scuba_vlo), 
        .ADB0(scuba_vlo), .ADB1(scuba_vlo), .ADB2(scuba_vlo), .ADB3(scuba_vlo), 
        .ADB4(scuba_vlo), .ADB5(RdAddress[0]), .ADB6(RdAddress[1]), .ADB7(RdAddress[2]), 
        .ADB8(RdAddress[3]), .ADB9(RdAddress[4]), .ADB10(RdAddress[5]), 
        .ADB11(RdAddress[6]), .ADB12(RdAddress[7]), .ADB13(scuba_vlo), .CEB(RdClockEn), 
        .CLKB(RdClock), .WEB(scuba_vlo), .CSB0(scuba_vlo), .CSB1(scuba_vlo), 
        .CSB2(scuba_vlo), .RSTB(Reset), .DOA0(Q[0]), .DOA1(Q[1]), .DOA2(Q[2]), 
        .DOA3(Q[3]), .DOA4(Q[16]), .DOA5(Q[17]), .DOA6(Q[18]), .DOA7(Q[19]), 
        .DOA8(), .DOA9(Q[32]), .DOA10(Q[33]), .DOA11(Q[34]), .DOA12(Q[35]), 
        .DOA13(Q[48]), .DOA14(Q[49]), .DOA15(Q[50]), .DOA16(Q[51]), .DOA17(), 
        .DOB0(Q[64]), .DOB1(Q[65]), .DOB2(Q[66]), .DOB3(Q[67]), .DOB4(Q[80]), 
        .DOB5(Q[81]), .DOB6(Q[82]), .DOB7(Q[83]), .DOB8(), .DOB9(Q[96]), 
        .DOB10(Q[97]), .DOB11(Q[98]), .DOB12(Q[99]), .DOB13(Q[112]), .DOB14(Q[113]), 
        .DOB15(Q[114]), .DOB16(Q[115]), .DOB17())
             /* synthesis MEM_LPC_FILE="lattice_ram_16bit_4kbyte.lpc" */
             /* synthesis MEM_INIT_FILE="" */
             /* synthesis CSDECODE_B="0b000" */
             /* synthesis CSDECODE_A="0b000" */
             /* synthesis WRITEMODE_B="NORMAL" */
             /* synthesis WRITEMODE_A="NORMAL" */
             /* synthesis GSR="DISABLED" */
             /* synthesis RESETMODE="SYNC" */
             /* synthesis REGMODE_B="OUTREG" */
             /* synthesis REGMODE_A="OUTREG" */
             /* synthesis DATA_WIDTH_B="36" */
             /* synthesis DATA_WIDTH_A="4" */;

    // synopsys translate_off
    defparam lattice_ram_16bit_4kbyte_0_1_2.CSDECODE_B =  3'b000 ;
    defparam lattice_ram_16bit_4kbyte_0_1_2.CSDECODE_A =  3'b000 ;
    defparam lattice_ram_16bit_4kbyte_0_1_2.WRITEMODE_B = "NORMAL" ;
    defparam lattice_ram_16bit_4kbyte_0_1_2.WRITEMODE_A = "NORMAL" ;
    defparam lattice_ram_16bit_4kbyte_0_1_2.GSR = "DISABLED" ;
    defparam lattice_ram_16bit_4kbyte_0_1_2.RESETMODE = "SYNC" ;
    defparam lattice_ram_16bit_4kbyte_0_1_2.REGMODE_B = "OUTREG" ;
    defparam lattice_ram_16bit_4kbyte_0_1_2.REGMODE_A = "OUTREG" ;
    defparam lattice_ram_16bit_4kbyte_0_1_2.DATA_WIDTH_B = 36 ;
    defparam lattice_ram_16bit_4kbyte_0_1_2.DATA_WIDTH_A = 4 ;
    // synopsys translate_on
    DP16KB lattice_ram_16bit_4kbyte_0_1_2 (.DIA0(Data[4]), .DIA1(Data[5]), 
        .DIA2(Data[6]), .DIA3(Data[7]), .DIA4(scuba_vlo), .DIA5(scuba_vlo), 
        .DIA6(scuba_vlo), .DIA7(scuba_vlo), .DIA8(scuba_vlo), .DIA9(scuba_vlo), 
        .DIA10(scuba_vlo), .DIA11(scuba_vlo), .DIA12(scuba_vlo), .DIA13(scuba_vlo), 
        .DIA14(scuba_vlo), .DIA15(scuba_vlo), .DIA16(scuba_vlo), .DIA17(scuba_vlo), 
        .ADA0(scuba_vlo), .ADA1(scuba_vlo), .ADA2(WrAddress[0]), .ADA3(WrAddress[1]), 
        .ADA4(WrAddress[2]), .ADA5(WrAddress[3]), .ADA6(WrAddress[4]), .ADA7(WrAddress[5]), 
        .ADA8(WrAddress[6]), .ADA9(WrAddress[7]), .ADA10(WrAddress[8]), 
        .ADA11(WrAddress[9]), .ADA12(WrAddress[10]), .ADA13(scuba_vlo), 
        .CEA(WrClockEn), .CLKA(WrClock), .WEA(WE), .CSA0(scuba_vlo), .CSA1(scuba_vlo), 
        .CSA2(scuba_vlo), .RSTA(Reset), .DIB0(scuba_vlo), .DIB1(scuba_vlo), 
        .DIB2(scuba_vlo), .DIB3(scuba_vlo), .DIB4(scuba_vlo), .DIB5(scuba_vlo), 
        .DIB6(scuba_vlo), .DIB7(scuba_vlo), .DIB8(scuba_vlo), .DIB9(scuba_vlo), 
        .DIB10(scuba_vlo), .DIB11(scuba_vlo), .DIB12(scuba_vlo), .DIB13(scuba_vlo), 
        .DIB14(scuba_vlo), .DIB15(scuba_vlo), .DIB16(scuba_vlo), .DIB17(scuba_vlo), 
        .ADB0(scuba_vlo), .ADB1(scuba_vlo), .ADB2(scuba_vlo), .ADB3(scuba_vlo), 
        .ADB4(scuba_vlo), .ADB5(RdAddress[0]), .ADB6(RdAddress[1]), .ADB7(RdAddress[2]), 
        .ADB8(RdAddress[3]), .ADB9(RdAddress[4]), .ADB10(RdAddress[5]), 
        .ADB11(RdAddress[6]), .ADB12(RdAddress[7]), .ADB13(scuba_vlo), .CEB(RdClockEn), 
        .CLKB(RdClock), .WEB(scuba_vlo), .CSB0(scuba_vlo), .CSB1(scuba_vlo), 
        .CSB2(scuba_vlo), .RSTB(Reset), .DOA0(Q[4]), .DOA1(Q[5]), .DOA2(Q[6]), 
        .DOA3(Q[7]), .DOA4(Q[20]), .DOA5(Q[21]), .DOA6(Q[22]), .DOA7(Q[23]), 
        .DOA8(), .DOA9(Q[36]), .DOA10(Q[37]), .DOA11(Q[38]), .DOA12(Q[39]), 
        .DOA13(Q[52]), .DOA14(Q[53]), .DOA15(Q[54]), .DOA16(Q[55]), .DOA17(), 
        .DOB0(Q[68]), .DOB1(Q[69]), .DOB2(Q[70]), .DOB3(Q[71]), .DOB4(Q[84]), 
        .DOB5(Q[85]), .DOB6(Q[86]), .DOB7(Q[87]), .DOB8(), .DOB9(Q[100]), 
        .DOB10(Q[101]), .DOB11(Q[102]), .DOB12(Q[103]), .DOB13(Q[116]), 
        .DOB14(Q[117]), .DOB15(Q[118]), .DOB16(Q[119]), .DOB17())
             /* synthesis MEM_LPC_FILE="lattice_ram_16bit_4kbyte.lpc" */
             /* synthesis MEM_INIT_FILE="" */
             /* synthesis CSDECODE_B="0b000" */
             /* synthesis CSDECODE_A="0b000" */
             /* synthesis WRITEMODE_B="NORMAL" */
             /* synthesis WRITEMODE_A="NORMAL" */
             /* synthesis GSR="DISABLED" */
             /* synthesis RESETMODE="SYNC" */
             /* synthesis REGMODE_B="OUTREG" */
             /* synthesis REGMODE_A="OUTREG" */
             /* synthesis DATA_WIDTH_B="36" */
             /* synthesis DATA_WIDTH_A="4" */;

    // synopsys translate_off
    defparam lattice_ram_16bit_4kbyte_0_2_1.CSDECODE_B =  3'b000 ;
    defparam lattice_ram_16bit_4kbyte_0_2_1.CSDECODE_A =  3'b000 ;
    defparam lattice_ram_16bit_4kbyte_0_2_1.WRITEMODE_B = "NORMAL" ;
    defparam lattice_ram_16bit_4kbyte_0_2_1.WRITEMODE_A = "NORMAL" ;
    defparam lattice_ram_16bit_4kbyte_0_2_1.GSR = "DISABLED" ;
    defparam lattice_ram_16bit_4kbyte_0_2_1.RESETMODE = "SYNC" ;
    defparam lattice_ram_16bit_4kbyte_0_2_1.REGMODE_B = "OUTREG" ;
    defparam lattice_ram_16bit_4kbyte_0_2_1.REGMODE_A = "OUTREG" ;
    defparam lattice_ram_16bit_4kbyte_0_2_1.DATA_WIDTH_B = 36 ;
    defparam lattice_ram_16bit_4kbyte_0_2_1.DATA_WIDTH_A = 4 ;
    // synopsys translate_on
    DP16KB lattice_ram_16bit_4kbyte_0_2_1 (.DIA0(Data[8]), .DIA1(Data[9]), 
        .DIA2(Data[10]), .DIA3(Data[11]), .DIA4(scuba_vlo), .DIA5(scuba_vlo), 
        .DIA6(scuba_vlo), .DIA7(scuba_vlo), .DIA8(scuba_vlo), .DIA9(scuba_vlo), 
        .DIA10(scuba_vlo), .DIA11(scuba_vlo), .DIA12(scuba_vlo), .DIA13(scuba_vlo), 
        .DIA14(scuba_vlo), .DIA15(scuba_vlo), .DIA16(scuba_vlo), .DIA17(scuba_vlo), 
        .ADA0(scuba_vlo), .ADA1(scuba_vlo), .ADA2(WrAddress[0]), .ADA3(WrAddress[1]), 
        .ADA4(WrAddress[2]), .ADA5(WrAddress[3]), .ADA6(WrAddress[4]), .ADA7(WrAddress[5]), 
        .ADA8(WrAddress[6]), .ADA9(WrAddress[7]), .ADA10(WrAddress[8]), 
        .ADA11(WrAddress[9]), .ADA12(WrAddress[10]), .ADA13(scuba_vlo), 
        .CEA(WrClockEn), .CLKA(WrClock), .WEA(WE), .CSA0(scuba_vlo), .CSA1(scuba_vlo), 
        .CSA2(scuba_vlo), .RSTA(Reset), .DIB0(scuba_vlo), .DIB1(scuba_vlo), 
        .DIB2(scuba_vlo), .DIB3(scuba_vlo), .DIB4(scuba_vlo), .DIB5(scuba_vlo), 
        .DIB6(scuba_vlo), .DIB7(scuba_vlo), .DIB8(scuba_vlo), .DIB9(scuba_vlo), 
        .DIB10(scuba_vlo), .DIB11(scuba_vlo), .DIB12(scuba_vlo), .DIB13(scuba_vlo), 
        .DIB14(scuba_vlo), .DIB15(scuba_vlo), .DIB16(scuba_vlo), .DIB17(scuba_vlo), 
        .ADB0(scuba_vlo), .ADB1(scuba_vlo), .ADB2(scuba_vlo), .ADB3(scuba_vlo), 
        .ADB4(scuba_vlo), .ADB5(RdAddress[0]), .ADB6(RdAddress[1]), .ADB7(RdAddress[2]), 
        .ADB8(RdAddress[3]), .ADB9(RdAddress[4]), .ADB10(RdAddress[5]), 
        .ADB11(RdAddress[6]), .ADB12(RdAddress[7]), .ADB13(scuba_vlo), .CEB(RdClockEn), 
        .CLKB(RdClock), .WEB(scuba_vlo), .CSB0(scuba_vlo), .CSB1(scuba_vlo), 
        .CSB2(scuba_vlo), .RSTB(Reset), .DOA0(Q[8]), .DOA1(Q[9]), .DOA2(Q[10]), 
        .DOA3(Q[11]), .DOA4(Q[24]), .DOA5(Q[25]), .DOA6(Q[26]), .DOA7(Q[27]), 
        .DOA8(), .DOA9(Q[40]), .DOA10(Q[41]), .DOA11(Q[42]), .DOA12(Q[43]), 
        .DOA13(Q[56]), .DOA14(Q[57]), .DOA15(Q[58]), .DOA16(Q[59]), .DOA17(), 
        .DOB0(Q[72]), .DOB1(Q[73]), .DOB2(Q[74]), .DOB3(Q[75]), .DOB4(Q[88]), 
        .DOB5(Q[89]), .DOB6(Q[90]), .DOB7(Q[91]), .DOB8(), .DOB9(Q[104]), 
        .DOB10(Q[105]), .DOB11(Q[106]), .DOB12(Q[107]), .DOB13(Q[120]), 
        .DOB14(Q[121]), .DOB15(Q[122]), .DOB16(Q[123]), .DOB17())
             /* synthesis MEM_LPC_FILE="lattice_ram_16bit_4kbyte.lpc" */
             /* synthesis MEM_INIT_FILE="" */
             /* synthesis CSDECODE_B="0b000" */
             /* synthesis CSDECODE_A="0b000" */
             /* synthesis WRITEMODE_B="NORMAL" */
             /* synthesis WRITEMODE_A="NORMAL" */
             /* synthesis GSR="DISABLED" */
             /* synthesis RESETMODE="SYNC" */
             /* synthesis REGMODE_B="OUTREG" */
             /* synthesis REGMODE_A="OUTREG" */
             /* synthesis DATA_WIDTH_B="36" */
             /* synthesis DATA_WIDTH_A="4" */;

    VLO scuba_vlo_inst (.Z(scuba_vlo));

    // synopsys translate_off
    defparam lattice_ram_16bit_4kbyte_0_3_0.CSDECODE_B =  3'b000 ;
    defparam lattice_ram_16bit_4kbyte_0_3_0.CSDECODE_A =  3'b000 ;
    defparam lattice_ram_16bit_4kbyte_0_3_0.WRITEMODE_B = "NORMAL" ;
    defparam lattice_ram_16bit_4kbyte_0_3_0.WRITEMODE_A = "NORMAL" ;
    defparam lattice_ram_16bit_4kbyte_0_3_0.GSR = "DISABLED" ;
    defparam lattice_ram_16bit_4kbyte_0_3_0.RESETMODE = "SYNC" ;
    defparam lattice_ram_16bit_4kbyte_0_3_0.REGMODE_B = "OUTREG" ;
    defparam lattice_ram_16bit_4kbyte_0_3_0.REGMODE_A = "OUTREG" ;
    defparam lattice_ram_16bit_4kbyte_0_3_0.DATA_WIDTH_B = 36 ;
    defparam lattice_ram_16bit_4kbyte_0_3_0.DATA_WIDTH_A = 4 ;
    // synopsys translate_on
    DP16KB lattice_ram_16bit_4kbyte_0_3_0 (.DIA0(Data[12]), .DIA1(Data[13]), 
        .DIA2(Data[14]), .DIA3(Data[15]), .DIA4(scuba_vlo), .DIA5(scuba_vlo), 
        .DIA6(scuba_vlo), .DIA7(scuba_vlo), .DIA8(scuba_vlo), .DIA9(scuba_vlo), 
        .DIA10(scuba_vlo), .DIA11(scuba_vlo), .DIA12(scuba_vlo), .DIA13(scuba_vlo), 
        .DIA14(scuba_vlo), .DIA15(scuba_vlo), .DIA16(scuba_vlo), .DIA17(scuba_vlo), 
        .ADA0(scuba_vlo), .ADA1(scuba_vlo), .ADA2(WrAddress[0]), .ADA3(WrAddress[1]), 
        .ADA4(WrAddress[2]), .ADA5(WrAddress[3]), .ADA6(WrAddress[4]), .ADA7(WrAddress[5]), 
        .ADA8(WrAddress[6]), .ADA9(WrAddress[7]), .ADA10(WrAddress[8]), 
        .ADA11(WrAddress[9]), .ADA12(WrAddress[10]), .ADA13(scuba_vlo), 
        .CEA(WrClockEn), .CLKA(WrClock), .WEA(WE), .CSA0(scuba_vlo), .CSA1(scuba_vlo), 
        .CSA2(scuba_vlo), .RSTA(Reset), .DIB0(scuba_vlo), .DIB1(scuba_vlo), 
        .DIB2(scuba_vlo), .DIB3(scuba_vlo), .DIB4(scuba_vlo), .DIB5(scuba_vlo), 
        .DIB6(scuba_vlo), .DIB7(scuba_vlo), .DIB8(scuba_vlo), .DIB9(scuba_vlo), 
        .DIB10(scuba_vlo), .DIB11(scuba_vlo), .DIB12(scuba_vlo), .DIB13(scuba_vlo), 
        .DIB14(scuba_vlo), .DIB15(scuba_vlo), .DIB16(scuba_vlo), .DIB17(scuba_vlo), 
        .ADB0(scuba_vlo), .ADB1(scuba_vlo), .ADB2(scuba_vlo), .ADB3(scuba_vlo), 
        .ADB4(scuba_vlo), .ADB5(RdAddress[0]), .ADB6(RdAddress[1]), .ADB7(RdAddress[2]), 
        .ADB8(RdAddress[3]), .ADB9(RdAddress[4]), .ADB10(RdAddress[5]), 
        .ADB11(RdAddress[6]), .ADB12(RdAddress[7]), .ADB13(scuba_vlo), .CEB(RdClockEn), 
        .CLKB(RdClock), .WEB(scuba_vlo), .CSB0(scuba_vlo), .CSB1(scuba_vlo), 
        .CSB2(scuba_vlo), .RSTB(Reset), .DOA0(Q[12]), .DOA1(Q[13]), .DOA2(Q[14]), 
        .DOA3(Q[15]), .DOA4(Q[28]), .DOA5(Q[29]), .DOA6(Q[30]), .DOA7(Q[31]), 
        .DOA8(), .DOA9(Q[44]), .DOA10(Q[45]), .DOA11(Q[46]), .DOA12(Q[47]), 
        .DOA13(Q[60]), .DOA14(Q[61]), .DOA15(Q[62]), .DOA16(Q[63]), .DOA17(), 
        .DOB0(Q[76]), .DOB1(Q[77]), .DOB2(Q[78]), .DOB3(Q[79]), .DOB4(Q[92]), 
        .DOB5(Q[93]), .DOB6(Q[94]), .DOB7(Q[95]), .DOB8(), .DOB9(Q[108]), 
        .DOB10(Q[109]), .DOB11(Q[110]), .DOB12(Q[111]), .DOB13(Q[124]), 
        .DOB14(Q[125]), .DOB15(Q[126]), .DOB16(Q[127]), .DOB17())
             /* synthesis MEM_LPC_FILE="lattice_ram_16bit_4kbyte.lpc" */
             /* synthesis MEM_INIT_FILE="" */
             /* synthesis CSDECODE_B="0b000" */
             /* synthesis CSDECODE_A="0b000" */
             /* synthesis WRITEMODE_B="NORMAL" */
             /* synthesis WRITEMODE_A="NORMAL" */
             /* synthesis GSR="DISABLED" */
             /* synthesis RESETMODE="SYNC" */
             /* synthesis REGMODE_B="OUTREG" */
             /* synthesis REGMODE_A="OUTREG" */
             /* synthesis DATA_WIDTH_B="36" */
             /* synthesis DATA_WIDTH_A="4" */;



    // exemplar begin
    // exemplar attribute lattice_ram_16bit_4kbyte_0_0_3 MEM_LPC_FILE lattice_ram_16bit_4kbyte.lpc
    // exemplar attribute lattice_ram_16bit_4kbyte_0_0_3 MEM_INIT_FILE 
    // exemplar attribute lattice_ram_16bit_4kbyte_0_0_3 CSDECODE_B 0b000
    // exemplar attribute lattice_ram_16bit_4kbyte_0_0_3 CSDECODE_A 0b000
    // exemplar attribute lattice_ram_16bit_4kbyte_0_0_3 WRITEMODE_B NORMAL
    // exemplar attribute lattice_ram_16bit_4kbyte_0_0_3 WRITEMODE_A NORMAL
    // exemplar attribute lattice_ram_16bit_4kbyte_0_0_3 GSR DISABLED
    // exemplar attribute lattice_ram_16bit_4kbyte_0_0_3 RESETMODE SYNC
    // exemplar attribute lattice_ram_16bit_4kbyte_0_0_3 REGMODE_B OUTREG
    // exemplar attribute lattice_ram_16bit_4kbyte_0_0_3 REGMODE_A OUTREG
    // exemplar attribute lattice_ram_16bit_4kbyte_0_0_3 DATA_WIDTH_B 36
    // exemplar attribute lattice_ram_16bit_4kbyte_0_0_3 DATA_WIDTH_A 4
    // exemplar attribute lattice_ram_16bit_4kbyte_0_1_2 MEM_LPC_FILE lattice_ram_16bit_4kbyte.lpc
    // exemplar attribute lattice_ram_16bit_4kbyte_0_1_2 MEM_INIT_FILE 
    // exemplar attribute lattice_ram_16bit_4kbyte_0_1_2 CSDECODE_B 0b000
    // exemplar attribute lattice_ram_16bit_4kbyte_0_1_2 CSDECODE_A 0b000
    // exemplar attribute lattice_ram_16bit_4kbyte_0_1_2 WRITEMODE_B NORMAL
    // exemplar attribute lattice_ram_16bit_4kbyte_0_1_2 WRITEMODE_A NORMAL
    // exemplar attribute lattice_ram_16bit_4kbyte_0_1_2 GSR DISABLED
    // exemplar attribute lattice_ram_16bit_4kbyte_0_1_2 RESETMODE SYNC
    // exemplar attribute lattice_ram_16bit_4kbyte_0_1_2 REGMODE_B OUTREG
    // exemplar attribute lattice_ram_16bit_4kbyte_0_1_2 REGMODE_A OUTREG
    // exemplar attribute lattice_ram_16bit_4kbyte_0_1_2 DATA_WIDTH_B 36
    // exemplar attribute lattice_ram_16bit_4kbyte_0_1_2 DATA_WIDTH_A 4
    // exemplar attribute lattice_ram_16bit_4kbyte_0_2_1 MEM_LPC_FILE lattice_ram_16bit_4kbyte.lpc
    // exemplar attribute lattice_ram_16bit_4kbyte_0_2_1 MEM_INIT_FILE 
    // exemplar attribute lattice_ram_16bit_4kbyte_0_2_1 CSDECODE_B 0b000
    // exemplar attribute lattice_ram_16bit_4kbyte_0_2_1 CSDECODE_A 0b000
    // exemplar attribute lattice_ram_16bit_4kbyte_0_2_1 WRITEMODE_B NORMAL
    // exemplar attribute lattice_ram_16bit_4kbyte_0_2_1 WRITEMODE_A NORMAL
    // exemplar attribute lattice_ram_16bit_4kbyte_0_2_1 GSR DISABLED
    // exemplar attribute lattice_ram_16bit_4kbyte_0_2_1 RESETMODE SYNC
    // exemplar attribute lattice_ram_16bit_4kbyte_0_2_1 REGMODE_B OUTREG
    // exemplar attribute lattice_ram_16bit_4kbyte_0_2_1 REGMODE_A OUTREG
    // exemplar attribute lattice_ram_16bit_4kbyte_0_2_1 DATA_WIDTH_B 36
    // exemplar attribute lattice_ram_16bit_4kbyte_0_2_1 DATA_WIDTH_A 4
    // exemplar attribute lattice_ram_16bit_4kbyte_0_3_0 MEM_LPC_FILE lattice_ram_16bit_4kbyte.lpc
    // exemplar attribute lattice_ram_16bit_4kbyte_0_3_0 MEM_INIT_FILE 
    // exemplar attribute lattice_ram_16bit_4kbyte_0_3_0 CSDECODE_B 0b000
    // exemplar attribute lattice_ram_16bit_4kbyte_0_3_0 CSDECODE_A 0b000
    // exemplar attribute lattice_ram_16bit_4kbyte_0_3_0 WRITEMODE_B NORMAL
    // exemplar attribute lattice_ram_16bit_4kbyte_0_3_0 WRITEMODE_A NORMAL
    // exemplar attribute lattice_ram_16bit_4kbyte_0_3_0 GSR DISABLED
    // exemplar attribute lattice_ram_16bit_4kbyte_0_3_0 RESETMODE SYNC
    // exemplar attribute lattice_ram_16bit_4kbyte_0_3_0 REGMODE_B OUTREG
    // exemplar attribute lattice_ram_16bit_4kbyte_0_3_0 REGMODE_A OUTREG
    // exemplar attribute lattice_ram_16bit_4kbyte_0_3_0 DATA_WIDTH_B 36
    // exemplar attribute lattice_ram_16bit_4kbyte_0_3_0 DATA_WIDTH_A 4
    // exemplar end

endmodule
