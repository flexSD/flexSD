/* Verilog netlist generated by SCUBA Diamond_1.2_Production (92) */
/* Module Version: 3.1 */
/* /usr/local/diamond/1.2/ispfpga/bin/lin/scuba -w -lang verilog -synth synplify -bus_exp 7 -bb -arch mg5a00 -type addsub -width 24 -signed -port overflow -pipeline 0 -e  */
/* Tue May  8 14:17:33 2012 */


`timescale 1 ns / 1 ps
module add_sub_24bit_no_outreg (DataA, DataB, Add_Sub, Result, Overflow);
    input wire [23:0] DataA;
    input wire [23:0] DataB;
    input wire Add_Sub;
    output wire [23:0] Result;
    output wire Overflow;

    wire scuba_vhi;
    wire co0;
    wire co1;
    wire co2;
    wire co3;
    wire co4;
    wire co5;
    wire co6;
    wire co7;
    wire co8;
    wire co9;
    wire co10;
    wire co11;
    wire add_sub_inv;
    wire t_bn;
    wire co_n_1;
    wire co_n;
    wire co_n_t;
    wire scuba_vlo;

    VHI scuba_vhi_inst (.Z(scuba_vhi));

    INV INV_0 (.A(Add_Sub), .Z(add_sub_inv));

    XNOR2 XNOR2_t1 (.A(Add_Sub), .B(DataB[23]), .Z(t_bn));

    XOR2 XOR2_t0 (.A(co_n_1), .B(co_n), .Z(Overflow));

    FADSU2 addsub_0 (.A0(add_sub_inv), .A1(DataA[0]), .B0(scuba_vlo), .B1(DataB[0]), 
        .BCI(scuba_vlo), .CON(Add_Sub), .BCO(co0), .S0(), .S1(Result[0]));

    FADSU2 addsub_1 (.A0(DataA[1]), .A1(DataA[2]), .B0(DataB[1]), .B1(DataB[2]), 
        .BCI(co0), .CON(Add_Sub), .BCO(co1), .S0(Result[1]), .S1(Result[2]));

    FADSU2 addsub_2 (.A0(DataA[3]), .A1(DataA[4]), .B0(DataB[3]), .B1(DataB[4]), 
        .BCI(co1), .CON(Add_Sub), .BCO(co2), .S0(Result[3]), .S1(Result[4]));

    FADSU2 addsub_3 (.A0(DataA[5]), .A1(DataA[6]), .B0(DataB[5]), .B1(DataB[6]), 
        .BCI(co2), .CON(Add_Sub), .BCO(co3), .S0(Result[5]), .S1(Result[6]));

    FADSU2 addsub_4 (.A0(DataA[7]), .A1(DataA[8]), .B0(DataB[7]), .B1(DataB[8]), 
        .BCI(co3), .CON(Add_Sub), .BCO(co4), .S0(Result[7]), .S1(Result[8]));

    FADSU2 addsub_5 (.A0(DataA[9]), .A1(DataA[10]), .B0(DataB[9]), .B1(DataB[10]), 
        .BCI(co4), .CON(Add_Sub), .BCO(co5), .S0(Result[9]), .S1(Result[10]));

    FADSU2 addsub_6 (.A0(DataA[11]), .A1(DataA[12]), .B0(DataB[11]), .B1(DataB[12]), 
        .BCI(co5), .CON(Add_Sub), .BCO(co6), .S0(Result[11]), .S1(Result[12]));

    FADSU2 addsub_7 (.A0(DataA[13]), .A1(DataA[14]), .B0(DataB[13]), .B1(DataB[14]), 
        .BCI(co6), .CON(Add_Sub), .BCO(co7), .S0(Result[13]), .S1(Result[14]));

    FADSU2 addsub_8 (.A0(DataA[15]), .A1(DataA[16]), .B0(DataB[15]), .B1(DataB[16]), 
        .BCI(co7), .CON(Add_Sub), .BCO(co8), .S0(Result[15]), .S1(Result[16]));

    FADSU2 addsub_9 (.A0(DataA[17]), .A1(DataA[18]), .B0(DataB[17]), .B1(DataB[18]), 
        .BCI(co8), .CON(Add_Sub), .BCO(co9), .S0(Result[17]), .S1(Result[18]));

    FADSU2 addsub_10 (.A0(DataA[19]), .A1(DataA[20]), .B0(DataB[19]), .B1(DataB[20]), 
        .BCI(co9), .CON(Add_Sub), .BCO(co10), .S0(Result[19]), .S1(Result[20]));

    FADSU2 addsub_11 (.A0(DataA[21]), .A1(DataA[22]), .B0(DataB[21]), .B1(DataB[22]), 
        .BCI(co10), .CON(Add_Sub), .BCO(co11), .S0(Result[21]), .S1(Result[22]));

    FADSU2 addsub_12 (.A0(scuba_vlo), .A1(Add_Sub), .B0(add_sub_inv), .B1(scuba_vlo), 
        .BCI(co11), .CON(Add_Sub), .BCO(), .S0(co_n_1), .S1());

    FADD2B addsub_o0 (.A0(co_n_1), .A1(DataA[23]), .B0(co_n_1), .B1(t_bn), 
        .CI(scuba_vlo), .COUT(co_n_t), .S0(), .S1(Result[23]));

    VLO scuba_vlo_inst (.Z(scuba_vlo));

    FADD2B addsub_o1 (.A0(scuba_vlo), .A1(scuba_vlo), .B0(scuba_vlo), .B1(scuba_vlo), 
        .CI(co_n_t), .COUT(), .S0(co_n), .S1());



    // exemplar begin
    // exemplar end

endmodule
