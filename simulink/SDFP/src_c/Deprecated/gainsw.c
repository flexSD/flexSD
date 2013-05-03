#include <stdio.h>

typedef unsigned int uint32_T;
typedef int int_T;
typedef int int32_T;
typedef float real32_T;
#define dprintf(format, args ...) printf(format, ##args)


/* Floating point conversion helper macros */
typedef unsigned int uint32;

void SDFPGainSwitch_Outputs_wrapper(const real32_T *sd_in,
                          uint32_T *gain_out  , 
                          const real32_T  *gain, const int_T  p_width0, 
                          const uint32_T  *bitwidth, const int_T  p_width1, 
                          const uint32_T  *fp_position,  const int_T p_width2)
{

   static uint32_T float_repr;
   static uint32_T converted_float = 0;

   if( converted_float == 0 ) {
      float_repr = fp32_to_fixed_point(gain[0], bitwidth[0], fp_position[0]);
      converted_float = 1;
   }

   if(sd_in[0] == -1) {
      gain_out[0] = -float_repr;
   } else if(sd_in[0] == 1) {
      gain_out[0] = float_repr;
   } else {
      /* Error Case */
      gain_out[0] = 0;
   }

}

int main() {

   real32_T sd_in;
   uint32_T gain_out;

   real32_T gain = 1.4283;
   int_T p_width0 = 1;
   int_T p_width1 = 1;
   int_T p_width2 = 1;

   uint32_T bitwidth = 32, fp_position = 12;

   SDFPGainSwitch_Outputs_wrapper( &sd_in, &gain_out, 
         &gain, &p_width0,
         &bitwidth, &p_width1,
         &fp_position, &p_width2
   );

   printf("");

   return 0;
}
