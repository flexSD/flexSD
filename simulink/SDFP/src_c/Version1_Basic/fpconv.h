#ifndef FPCONV_H
#define FPCONV_H

#ifndef T_FP32_TO_FIXED_POINT_VERBOSITY 
#define T_FP32_TO_FIXED_POINT_VERBOSITY 1
#endif

#if T_FP32_TO_FIXED_POINT_VERBOSITY >= 1
#  define DEBUGPRINTF1(format, args...) printf(format, ##args)
#else
#  define DEBUGPRINTF1(format, args...) ;
#endif


typedef unsigned int uint32;
typedef int int32;

#define f32_to_uint32(x) (*((uint32*)(&(x))))
#define f64_to_uint32_lower(x) (*((uint32*)(&(x))))
#define f64_to_uint32_upper(x) (*((uint32*)(&(x))+1))

#define change_type(type,d) (*((type*)(&(d))))

float fixed_point_to_fp32( uint32 f_in, int bit_width, int point_position );
uint32 fp32_to_fixed_point( float i, int bit_width, int point_position );

#endif
