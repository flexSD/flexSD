#include <stdio.h>

typedef unsigned int uint32_T;
typedef int int_T;

#define MAX(a,b) ((a)>(b)?(a):(b))
#define MAX4(a,b,c,d) (MAX(MAX(MAX(a,b),c),d))
#define dprintf(format, args ...) printf(format, ##args)

void SDFPAdder4_Outputs_wrapper(const uint32_T *in0,
                          const uint32_T *in1,
                          const uint32_T *in2,
                          const uint32_T *in3,
                          uint32_T *adder_out  , 
                          const uint32_T  *in0_bitwidth, const int_T  p_width0, 
                          const uint32_T  *in0_fp_position, const int_T  p_width1, 
                          const uint32_T  *in1_bitwidth, const int_T  p_width2, 
                          const uint32_T  *in1_fp_position, const int_T  p_width3, 
                          const uint32_T  *in2_bitwidth, const int_T  p_width4, 
                          const uint32_T  *in2_fp_position, const int_T  p_width5, 
                          const uint32_T  *in3_bitwidth, const int_T  p_width6, 
                          const uint32_T  *in3_fp_position, const int_T  p_width7, 
                          const uint32_T  *out_bitwidth, const int_T  p_width8, 
                          const uint32_T  *out_fp_position,  const int_T p_width9) {

   /* Just "rename" the input parameters. */
   uint32_T t_in0 = in0[0];
   uint32_T t_in1 = in1[0];
   uint32_T t_in2 = in2[0];
   uint32_T t_in3 = in3[0];
   uint32_T t_in0_bitwidth = in0_bitwidth[0];
   uint32_T t_in1_bitwidth = in1_bitwidth[0];
   uint32_T t_in2_bitwidth = in2_bitwidth[0];
   uint32_T t_in3_bitwidth = in3_bitwidth[0];
   uint32_T t_in0_fp_position = in0_fp_position[0];
   uint32_T t_in1_fp_position = in1_fp_position[0];
   uint32_T t_in2_fp_position = in2_fp_position[0];
   uint32_T t_in3_fp_position = in3_fp_position[0];

   uint32_T t_out_bitwidth = out_bitwidth[0];
   uint32_T t_out_fp_position = out_fp_position[0];

   /* Determine the highest decimal position. We will align according to that. */
   int highest_decimal = MAX4(t_in0_fp_position, t_in1_fp_position, t_in2_fp_position, t_in3_fp_position);

   /* printf("highest_decimal: %d\n", highest_decimal); */

   /* Now shift everyone accordingly. */
   t_in0 <<= (highest_decimal - t_in0_fp_position);
   t_in1 <<= (highest_decimal - t_in1_fp_position);
   t_in2 <<= (highest_decimal - t_in2_fp_position);
   t_in3 <<= (highest_decimal - t_in3_fp_position);

   dprintf("t_in0 = %08x\n", t_in0);
   dprintf("t_in1 = %08x\n", t_in1);
   dprintf("t_in2 = %08x\n", t_in2);
   dprintf("t_in3 = %08x\n", t_in3);

   /* Do sum. */
   *adder_out = t_in0 + t_in1 + t_in2 + t_in3;

   /* Make any adjustments if necessary. */
   if( t_out_fp_position < highest_decimal ) {
      /* shift right */
      *adder_out >>= (t_out_fp_position - highest_decimal);
   } else if( t_out_fp_position > highest_decimal ) {
      /* shift left if we don't have enough bits. */
      *adder_out <<= (highest_decimal - t_out_fp_position);
   }
   
   /* Mask out bits to mimick truncation. */
   uint32_T mask = (1 << t_out_bitwidth)-1;
   *adder_out &= mask;

}


int main() {

   /* various input values */
   uint32_T  in0;
   uint32_T  in1;
   uint32_T  in2;
   uint32_T  in3;
   uint32_T  adder_out; 

   /* parameters */
   uint32_T  in0_bitwidth; 
   int_T     p_width0 = 1; 
   uint32_T  in0_fp_position; 
   int_T     p_width1 = 1; 
   uint32_T  in1_bitwidth; 
   int_T     p_width2 = 1; 
   uint32_T  in1_fp_position; 
   int_T     p_width3 = 1; 
   uint32_T  in2_bitwidth; 
   int_T     p_width4 = 1; 
   uint32_T  in2_fp_position; 
   int_T     p_width5 = 1; 
   uint32_T  in3_bitwidth; 
   int_T     p_width6 = 1; 
   uint32_T  in3_fp_position; 
   int_T     p_width7 = 1; 
   uint32_T  out_bitwidth; 
   int_T     p_width8 = 1; 
   uint32_T  out_fp_position;  
   int_T     p_width9 = 1;

   /* test values */
   in0 = 0x00321ABC; in0_bitwidth = 32; in0_fp_position = 16;
   in1 = 0x00321ABC; in1_bitwidth = 32; in1_fp_position = 8;
   in2 = 0x00321ABC; in2_bitwidth = 32; in2_fp_position = 4;
   in3 = 0x00321ABC; in3_bitwidth = 32; in3_fp_position = 24;

   out_fp_position = 22;
   out_bitwidth = 32;

   /* call wrapper function */
   SDFPAdder4_Outputs_wrapper(
      &in0, &in1, &in2, &in3, &adder_out, &in0_bitwidth, p_width0, &in0_fp_position, p_width1, &in1_bitwidth, p_width2, &in1_fp_position, p_width3, &in2_bitwidth, p_width4, &in2_fp_position, p_width5, &in3_bitwidth, p_width6, &in3_fp_position, p_width7, &out_bitwidth, p_width8, &out_fp_position, p_width9
   );

   printf("result adder_out = %08x\n", adder_out);
   
   return 0;
}
