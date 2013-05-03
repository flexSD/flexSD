#include <stdio.h>

#include "rtwtypes.h"
#include "SDFPAdder4_wrapper.c"

int main() {

   uint32_T in0[1];
   uint32_T in1[1];
   uint32_T in2[1];
   uint32_T in3[1];
   uint32_T adder_out[1];
   uint32_T DBG_in01[1];
   uint32_T DBG_in012[1];
   uint32_T in_bitwidth[1];
   int_T  p_width0=1;
   uint32_T  in_fp_position[1];
   int_T  p_width1=1;
   uint32_T  out_bitwidth[1];
   int_T  p_width2=1;
   uint32_T  out_fp_position[1];
   int_T p_width3=1;

   in0[0] = 0x00001000;

   SDFPAdder4_Outputs_wrapper(
         in0, in1, in2, in3,
         adder_out, DBG_in01, DBG_in012,
         in_bitwidth, p_width0,
         in_fp_position, p_width1,
         out_bitwidth, p_width2,
         out_fp_position, p_width3
         );

   return 0;
}
