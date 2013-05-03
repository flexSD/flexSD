#include <stdio.h>

typedef unsigned int uint32_T;
typedef int int_T;
typedef int int32_T;

#define MAX(a,b) ((a)>(b)?(a):(b))
#define MAX4(a,b,c,d) (MAX(MAX(MAX(a,b),c),d))
#define dprintf(format, args ...) printf(format, ##args)

void SDFPShifter_Outputs_wrapper(const uint32_T *sg_in,
                          uint32_T *shifter_out, 
                           const int32_T  *shift_amount, const int_T p_width0)
{
/* %%%-SFUNWIZ_wrapper_Outputs_Changes_BEGIN --- EDIT HERE TO _END */
/* This sample sets the output equal to the input
         y0[0] = u0[0];
For complex signals use: y0[0].re = u0[0].re;
                         y0[0].im = u0[0].im;
                         y1[0].re = u1[0].re;
                         y1[0].im = u1[0].im;*/
/* %%%-SFUNWIZ_wrapper_Outputs_Changes_END --- EDIT HERE TO _BEGIN */

   if( shift_amount[0] > 0 ) {
      shifter_out[0] = sg_in[0] << shift_amount[0];
   } else {
      shifter_out[0] = sg_in[0] >> -shift_amount[0];
   }

}

void SDFPAdder4_Outputs_wrapper(const uint32_T *in0,
                          const uint32_T *in1,
                          const uint32_T *in2,
                          const uint32_T *in3,
                          uint32_T *adder_out  , 
                          const uint32_T  *in_bitwidth, const int_T  p_width0, 
                          const uint32_T  *in_fp_position, const int_T  p_width1, 
                          const uint32_T  *out_bitwidth, const int_T  p_width2, 
                          const uint32_T  *out_fp_position,  const int_T p_width3)
{

#define dprintf(format, args ...) ;

   /* Just "rename" the input parameters. */
   uint32_T t_in0 = in0[0];
   uint32_T t_in1 = in1[0];
   uint32_T t_in2 = in2[0];
   uint32_T t_in3 = in3[0];
   uint32_T t_in_bitwidth = in_bitwidth[0];
   uint32_T t_in_fp_position = in_fp_position[0];
   uint32_T t_out_bitwidth = out_bitwidth[0];
   uint32_T t_out_fp_position = out_fp_position[0];
   uint32_T t_adder_out;

   /* Do sum. */
   t_adder_out = t_in0 + t_in1 + t_in2 + t_in3;
   dprintf("t_adder_out = %08x\n", t_adder_out );

   /* Make any adjustments if necessary. */
   if( t_out_fp_position < t_in_fp_position ) {
      /* shift right */
      t_adder_out >>= (t_in_fp_position - t_out_fp_position);
      dprintf("shift t_adder_out by %d bits\n", (t_in_fp_position - t_out_fp_position));
   } else if( t_out_fp_position > t_in_fp_position ) {
      /* shift left if we don't have enough bits. */
      t_adder_out <<= (t_out_fp_position - t_in_fp_position);
   }
   dprintf("t_adder_out, adjusted = %08x\n", t_adder_out );
   
   /* Mask out bits to mimick truncation. */
   uint32_T mask;
   if( t_out_bitwidth < 32 ) 
      mask = (1 << t_out_bitwidth)-1;
   else
      mask = 0xFFFFFFFF;
   dprintf("mask = %08x\n", (1 << t_out_bitwidth) );
   t_adder_out &= mask;

   adder_out[0] = t_adder_out;

}


int main() {

   /* various input values */
   uint32_T  in0;
   uint32_T  in1;
   uint32_T  in2;
   uint32_T  in3;
   uint32_T  adder_out; 

   /* parameters */
   int_T     p_width0 = 1; 
   int_T     p_width1 = 1; 
   int_T     p_width2 = 1; 
   int_T     p_width3 = 1; 
   uint32_T  in_bitwidth; 
   uint32_T  in_fp_position; 
   uint32_T  out_bitwidth; 
   uint32_T  out_fp_position;  

   /* test values */
   in_bitwidth = 32; in_fp_position = 12;

   in0 = 0x00021ABC; 
   in1 = 0x00321ABC; 
   in2 = 0x00321ABC; 
   in3 = 0x00321ABC; 

   out_fp_position = 10;
   out_bitwidth = 32;

   /* call wrapper function */
   SDFPAdder4_Outputs_wrapper(
      &in0, &in1, &in2, &in3, &adder_out, 
      &in_bitwidth, p_width0, &in_fp_position, p_width1, 
      &out_bitwidth, p_width2, &out_fp_position, p_width3
   );

   printf("result adder_out = %08x\n", adder_out);

   uint32_T shifter_out, shift_amount = 12;
   SDFPShifter_Outputs_wrapper(&in0, &shifter_out, &shift_amount, 1);
   printf("result shifter_out = %08x\n", shifter_out);
   
   return 0;
}
