#ifndef SDFPAdder4_Wrapper_H
#define SDFPAdder4_Wrapper_H

#include "rtwtypes.h"

void SDFPAdder4_Outputs_wrapper(const uint32_T *in0,
                          const uint32_T *in1,
                          const uint32_T *in2,
                          const uint32_T *in3,
                          uint32_T *adder_out,
                          real_T *pwr_switching_inst,
                          real_T *pwr_leakage_inst,
                          real_T *pwr_total_inst ,
			      const real_T  *xD,
                          const uint32_T  *in_bitwidth, const int_T  p_width0, 
                          const uint32_T  *in_fp_position, const int_T  p_width1, 
                          const uint32_T  *out_bitwidth, const int_T  p_width2, 
                          const uint32_T  *out_fp_position, const int_T  p_width3, 
                          const real_T  *frequency, const int_T  p_width4, 
                          const uint32_T  *input_count, const int_T p_width5);

#endif // SDFPAdder4_Wrapper_H
