#include <stdio.h>

typedef unsigned int uint32_T;
typedef int int_T;
typedef int int32_T;

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

#ifndef change_type
   /* Simple typecasting hack to change data types without affecting bits. */
#define change_type(type,d) (*((type*)(&(d))))
#endif

   int sg_in_signed = change_type(int, sg_in[0]);
   int sg_shifted_signed;
   if( shift_amount[0] > 0 ) {
      sg_shifted_signed = (sg_in_signed << shift_amount[0]);
   } else {
      sg_shifted_signed = (sg_in_signed >> -shift_amount[0]);
   }

   shifter_out[0] = change_type(uint32_T, sg_shifted_signed);

}

int main() {

   uint32_T sg_in, shifter_out;
   int32_T shift_amount;

   sg_in = 0xf80f1234;
   shift_amount = 4;

   SDFPShifter_Outputs_wrapper(&sg_in, &shifter_out, &shift_amount, 1);
   printf("Shifter out = %08x\n", shifter_out);

}
