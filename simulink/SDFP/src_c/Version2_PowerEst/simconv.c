#include <stdio.h>
#include <assert.h>
#include <math.h>

#define T_FP32_TO_FIXED_POINT_VERBOSITY 1
#include "fpconv.h"

/**********************************************/
/**  64-bit Floating Point Helper Functions  **/
/**********************************************/
int fp64_get_exponent(double i) {
   uint32 f = f64_to_uint32_upper(i);
   int exp = ((f & 0x7FF00000) >> 20);
   return exp - 1023;
} 

uint32 fp64_get_mantissa_upper(double i) {
   uint32 upper = f64_to_uint32_upper(i);
   return (upper & 0x000FFFFF);
}  

uint32 fp64_get_mantissa_lower(double i) {
   uint32 lower = f64_to_uint32_lower(i);
   return lower;
}

uint32 fp64_get_sign(double i) {
   uint32 f = f64_to_uint32_upper(i);
   return (f & 0x80000000) != 0;
}  

uint32 fp64_to_fixed_point( double i, int bit_width, int point_position ) {

   assert(bit_width > point_position);

   /* XXX: This function does not work for very large numbers, i.e.
    * > 4billion. It was not really designed for that. */

   int      i_exponent   = fp64_get_exponent(i);
   uint32   i_mantissa_u = fp64_get_mantissa_upper(i);
   uint32   i_mantissa_l = fp64_get_mantissa_lower(i);
   uint32   i_sign       = fp64_get_sign(i);

   DEBUGPRINTF1("\n[ fp64_to_fixed_point ]\n");
   DEBUGPRINTF1("Input number: %5.53e [%08x %08x]\n", i, f64_to_uint32_upper(i), f64_to_uint32_lower(i) );

   if( i_exponent > (bit_width - point_position) || i_exponent > 31 ) { 
      fprintf(stderr, "fp64_to_fixed_point: Not enough bits to represent number -- high exponent.\n");
      return 0xFFFFFFFF;
   }

   DEBUGPRINTF1("i_exponent: %d [%x]\n", i_exponent, i_exponent);
   DEBUGPRINTF1("i_mantissa: [%08x %08x]\n", i_mantissa_u, i_mantissa_l);
   DEBUGPRINTF1("i_sign: %d\n", i_sign);

   /* Make sure we can even represent the number */
   int i_integer_part = ((uint32)i);
   uint32 integer_msb = i32_sweep_bits(abs(i_integer_part));

   DEBUGPRINTF1("i_integer_part: %d\n", i_integer_part);
   DEBUGPRINTF1("integer_msb: %d\n", integer_msb);

   if( integer_msb > (bit_width - point_position) ) {
      fprintf(stderr, "fp64_to_fixed_point: Not enough bits to represent integer portion of number.\n");
      return 0xFFFFFFFF;
   }

   /* Now reduce it to just the fractional part. */
   DEBUGPRINTF1( "Subtraction: %f - %f (%d)\n", i, (double)(i_integer_part), i_integer_part);
   double df_integer_part = (double)(i_integer_part);
   double df_decimal_part = (double)(i) - df_integer_part;
   DEBUGPRINTF1( "Decimal part, in double form: %0.52f [%08x %08x]\n", df_decimal_part, f64_to_uint32_upper(df_decimal_part), f64_to_uint32_lower(df_decimal_part) );

   int      df_exponent   = fp64_get_exponent(df_decimal_part);
   uint32   df_mantissa_u = fp64_get_mantissa_upper(df_decimal_part);
   uint32   df_mantissa_l = fp64_get_mantissa_lower(df_decimal_part);
   uint32   df_sign       = fp64_get_sign(df_decimal_part);

   DEBUGPRINTF1("df_exponent: %d [%x]\n", df_exponent, df_exponent);
   DEBUGPRINTF1("df_mantissa: [%08x %08x]\n", df_mantissa_u, df_mantissa_l);
   DEBUGPRINTF1("df_sign: %d\n", df_sign);

   /* Insert the hidden bit */
   df_mantissa_u |= 0x00100000;
   /* NOTE: df_mantissa is now the decimal portion in binary, essentially shifted left by 23 digits. */
   DEBUGPRINTF1("df_mantissa with hidden bit: [%08x %08x]\n", df_mantissa_u, df_mantissa_l);

   /* Now shift our mantissa to isolate the fractional part */
   uint32 fractional_bits;
   if( df_exponent < 0 ) {
      /* 
       * Right-shifting two 32-bit numbers as one number: 
       *    If we need to shift the number N composed of upper
       *    32 bits U and lower 32 bits L (N = {U,L}) right by E:
       *        {U, L} >> E
       *    (1) We right shift L right by E bits.
       *    (2) Then grab the lower E bits of U, and 
       *        put them into the upper E bits of L.
       *    (3) Then right shift U by E bits.
       */
      int E = -df_exponent;

      /* (1) */ 
      df_mantissa_l >>= E;

      /* (2) */ 
      uint32 mask_for_lower_E_bits = (1<<E)-1;
      df_mantissa_l |= (df_mantissa_u & mask_for_lower_E_bits) << (32-E);
           
      /* (3) */ 
      df_mantissa_u >>= E;

   } else {
      /* 
       * Left-shifting two 32-bit numbers as one number: 
       *    If we need to shift the number N composed of upper
       *    32 bits U and lower 32 bits L (N = {U,L}) left by E:
       *        {U, L} << E
       *    (1) We left-shift U by E bits.
       *    (2) Grab the upper E bits of L, and push them into
       *        the lower E bits of U.
       *    (3) Left-shift L by E bits.
       */
      int E = df_exponent;
      
      /* (1) */
      df_mantissa_u <<= E;

      /* (2) */
      uint32 mask_for_upper_E_bits = ((1<<E)-1) << (32-E);
      df_mantissa_u |= (df_mantissa_l & mask_for_upper_E_bits) >> (32-E);

      /* (3) */
      df_mantissa_l <<= E;

   }

   DEBUGPRINTF1("df_mantissa shifted: [%08x %08x]\n", df_mantissa_u, df_mantissa_l);

   uint32 final_number = 0;
//   final_number = (df_mantissa & 0x007FFFFF);
//   /* now the lower 23 bits contain the fractional part. We'll truncate it accordingly. */
//   if( point_position > 23 ) {
//      /* if the fixed point position is more than 23, then shift left to align the most significant
//       * fraction part */
//      final_number <<= point_position - 23;
//   } else if( point_position < 23 ) {
//      /* shift right to truncate extra bits */
//      final_number >>= 23 - point_position;
//   }
//
//   /* Now that the fractional part is in place, we can put the integer portion into place */
//   uint32 u_integer_masked = i_integer_part & ((1 << (bit_width-point_position))-1);
//   final_number |= u_integer_masked << point_position;

   return final_number;
   
}

qa_test_fp64_decomposition() {
   //double df_test = 23.148292392e-10;
   //double df_test = -27.09375; 
   double df_test = -1.6251526251508040;
   DEBUGPRINTF1( "\n[64-bit FP Decomposition Test]\n" );

   uint32* base = (uint32*)(&df_test);
   char* base_c = (char*)(&df_test);

   DEBUGPRINTF1( "base for variable: %08x\n", base );
   DEBUGPRINTF1( "first digit: %08x\n", *base );
   DEBUGPRINTF1( "second digit: %08x\n", *(base+1) );
   DEBUGPRINTF1( "Floating point of test_float: %f [%08x %08x]\n", df_test, f64_to_uint32_upper(df_test),  f64_to_uint32_lower(df_test));


   int      df_exponent   = fp64_get_exponent(df_test);
   uint32   df_mantissa_u = fp64_get_mantissa_upper(df_test);
   uint32   df_mantissa_l = fp64_get_mantissa_lower(df_test);
   uint32   df_sign       = fp64_get_sign(df_test);
   
   DEBUGPRINTF1( "\n" );
   DEBUGPRINTF1( "Exponent: %d [%08x]\n", df_exponent, df_exponent );
   DEBUGPRINTF1( "Mantissa: %08x %08x\n", df_mantissa_u, df_mantissa_l );
   DEBUGPRINTF1( "Sign: %d\n", df_sign );
}


/*****************************************************************************/

qa_test_sweep() {
   int k;
   for(k = 0; k < 32; k++ ) { 
      uint32 kn = 1 << k | 0x107;
      DEBUGPRINTF1( "sweep for %x: %d\n", kn, i32_sweep_bits(kn) );
   }
}

/*****************************************************************************/

int main() {
   
   if(0) {
      float test_float = 27.09375f; //15.22233;

      uint32 bit_size;
      uint32 decimal_pos;

      bit_size = 32;
      decimal_pos = 16;


      test_float = -27.09375f; 
      test_float = 5927.0390625; /* 0x1727 */
      DEBUGPRINTF1( "Floating point of test_float: %f [%x]\n", test_float, f32_to_uint32(test_float) );
      uint32 new_number = fp32_to_fixed_point(test_float, bit_size, decimal_pos);
      printf( "New number: %d [%08x]\n", new_number, new_number );

      float from_fixed_point = fixed_point_to_fp32(new_number, bit_size, decimal_pos);
      //float from_fixed_point = fixed_point_to_fp32(0x000000A0, bit_size, 16);
      printf( "Floating point conversion: %.0f\n", from_fixed_point );

      /*
      qa_test_fp64_decomposition();

      float test_double = 27.09375; 
      uint32 new_number = fp64_to_fixed_point(test_double, bit_size, decimal_pos);
      printf("New number: %d [%08x]\n", new_number, new_number );

      //uint32 foo = fp64_to_fixed_point(-3.683747422959640971384942531585693359375, bit_size, decimal_pos);
      //uint32 foo = fp64_to_fixed_point(-1.683747422959640971384942531585693359375, bit_size, decimal_pos);
      uint32 foo = fp64_to_fixed_point(-1.6837474229600692954278429169789887964725494384765625, bit_size, decimal_pos);
      */
   }

   if(1) { /* random debugging nonsense */
      float t = 3.6779;
      printf("%08x\n", fp32_to_fixed_point(t, 24, 16));
   }

   if(0) { /* test whole numbers */
      float t = 20.0;
      printf("%08x\n", fp32_to_fixed_point(t, 32, 16));
   }

   if(0) { /* Sine test */
      float i;
#define PI 3.14159265
      for(i=0; i<(2*PI); i += (PI/64)) {
         float s = sin(i)*20;
         uint32 fixedpointrepr = fp32_to_fixed_point(s, 32, 16);
         float floatpointrepr = fixed_point_to_fp32(fixedpointrepr, 32, 16);
         float error = fabs(floatpointrepr - s);
         printf("%f -> %08x -> %f\t\t(error: %f)\n", s, fixedpointrepr, floatpointrepr, error);

      }
   }

   return 0;

}
