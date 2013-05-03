#include <stdio.h>

#include "SDFPAdder4_wrapper.h"

#include "rtwtypes.h"
#include "fpconv.h"

#define dprintf(format, args...) printf(format, ##args)

int main() {

   uint32_T in0[1];
   uint32_T in1[1];
   uint32_T in2[1];
   uint32_T in3[1];
   uint32_T adder_out[1];
   uint32_T in_bitwidth[1];
   real_T pwr_switching_inst[1];
   real_T pwr_leakage_inst[1];
   real_T pwr_total_inst[1];
   int_T  p_width0=1;
   uint32_T  in_fp_position[1];
   int_T  p_width1=1;
   uint32_T  out_bitwidth[1];
   int_T  p_width2=1;
   uint32_T  out_fp_position[1];
   int_T p_width3=1;
   real_T  frequency[1];
   int_T p_width4=1;
   uint32_T  input_count[1];
   int_T p_width5=1;
   real_T xD[4];

   in0[0] = 0x17171717;
   in1[0] = 0x00001101;
   in2[0] = 0x00001001;
   in3[0] = 0x00001000;

   in_bitwidth[0] = 32;
   in_fp_position[0] = 16;

   out_bitwidth[0] = 32;
   out_fp_position[0] = 16;

   frequency[0] = 40000000.0f;
   input_count[0] = 2;

   xD[0] = 0xFAFAA0A0;
   xD[1] = 0x0;
   xD[2] = 0x0;
   xD[3] = 0x0;

   SDFPAdder4_Outputs_wrapper(
         in0, in1, in2, in3,
         adder_out, 
         pwr_switching_inst,
         pwr_leakage_inst,
         pwr_total_inst,
         xD,
         in_bitwidth, p_width0,
         in_fp_position, p_width1,
         out_bitwidth, p_width2,
         out_fp_position, p_width3,
         frequency, p_width4,
         input_count, p_width5
         );



   return 0;

}
