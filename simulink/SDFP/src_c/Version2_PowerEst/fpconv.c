#include <stdio.h>
#include <assert.h>
#include <math.h>
#include "fpconv.h"

/**********************************************/
/**  32-bit Floating Point Helper Functions  **/
/**********************************************/
int fp32_get_exponent(float i) {
   uint32 f = f32_to_uint32(i);
   int f_e = ((f & 0x7F800000) >> 23);
   return f_e - 127;
} 

uint32 fp32_get_mantissa(float i) {
   uint32 f = f32_to_uint32(i);
   return (f & 0x007FFFFF);
}  
uint32 fp32_get_sign(float i) {
   uint32 f = f32_to_uint32(i);
   return (f & 0x80000000) != 0;
}  

int32 i32_sweep_bits( int i ) {
   uint32 p = 0, highest = 0;
   i = abs(i);
   if(i == 0) {
      return -1;
   }
   while(p < 32) {
      if( i & (1<<p) ) 
         highest = p;
      p++;
   }
   return highest;
}

float fixed_point_to_fp32( uint32 f_in, int bit_width, int point_position ) {

   int32 fi_in = change_type(int32, f_in);
   uint32 f_sign = 0;
   if( fi_in < 0 ) {
      fi_in = -fi_in;
      f_sign = 1;
   }
   DEBUGPRINTF1("fixed_point_to_fp32: f_in = %d [%08x] fi_in = %d [%08x]\n", f_in, f_in, fi_in, fi_in);

   uint32 f_in_n = change_type(uint32, fi_in);
   
   /* To do this conversion, we follow these steps:
    * (1) find the highest bit -> highest_bit
    * (2) determine how many positions we need to shift
    *     it to normalize it.
    *     24 - highest_bit = normalized to the 24'th bit position
    * (3) calculate exponent:
    *     = highest_bit - point_position - 1
    */

   if( f_in == 0 ) {
      return 0.0f;
   }

   int highest_bit = i32_sweep_bits(fi_in);
   DEBUGPRINTF1("fixed_point_to_fp32: highest_bit = %d\n", highest_bit);
   int shift_amt = 23 - highest_bit;
   
   DEBUGPRINTF1("fixed_point_to_fp32: shift_amt = %d\n", shift_amt);

   if( shift_amt < 0 ) {
      f_in_n >>= -shift_amt; /* Negative shift amount == shift right */
   } else {
      f_in_n <<= shift_amt;
   }
   DEBUGPRINTF1("fixed_point_to_fp32: shifted f_in_n = %d [%08x]\n", f_in_n, f_in_n);

   f_in_n &= 0x7fffff; /* mask out bits 23 -> 31 */
   DEBUGPRINTF1("fixed_point_to_fp32: masked f_in_n = %d [%08x]\n", f_in_n, f_in_n);
   
   int f_exponent = highest_bit - point_position;
   DEBUGPRINTF1("fixed_point_to_fp32: f_exponent = %d\n", f_exponent);

   uint32 fp_exponent = (f_exponent + 127) << 23; /* add exponent bias */
   DEBUGPRINTF1("fixed_point_to_fp32: fp_exponent = %08x\n", fp_exponent);

   f_in_n |= fp_exponent;
   DEBUGPRINTF1("fixed_point_to_fp32: f_in_n with exponent = %08x\n", f_in_n);

   f_in_n |= f_sign << 31;
   DEBUGPRINTF1("fixed_point_to_fp32: f_in_n with sign = %08x\n", f_in_n);

   return change_type(float, f_in_n);

}

uint32 fp32_to_fixed_point( float i, int bit_width, int point_position ) {

   assert(bit_width > point_position);

   int      i_exponent = fp32_get_exponent(i);
   uint32   i_mantissa = fp32_get_mantissa(i);
   uint32   i_sign     = fp32_get_sign(i);

   DEBUGPRINTF1("Input Floating Point: %f [%08x]\n", i, f32_to_uint32(i));
   DEBUGPRINTF1("i_exponent: %d [%x]\n", i_exponent, i_exponent);
   DEBUGPRINTF1("i_mantissa: %d [%x]\n", i_mantissa, i_mantissa);
   DEBUGPRINTF1("i_sign: %d\n", i_sign);

   /* Check special cases of (a) zero, (b) denormalized, and (c) NaN */
   uint32 denormalized = 0;
   if( i_exponent == 0 ) {
      if( i_mantissa == 0 ) {
         /* Zero */
         return 0x0;
      } else {
         /* Denormalized */
         denormalized = 1;
      }
   } else if( i_exponent == 128) {
      if( i_mantissa == 0 ) {
         /* +/- infinity */
         /* Just max out (saturate) the fixed point number */
         return ((1<<(bit_width-1))-1) | (i_sign << (bit_width-1));
      } else {
         /* NaN */
         return 0;
      }
   }

   /* Make sure we can even represent the number */
   int i_integer_part = ((uint32)i);
   DEBUGPRINTF1( "Integer part: %d [%x]\n", i_integer_part, i_integer_part );

   uint32 integer_msb = i32_sweep_bits(i_integer_part);
   if( integer_msb == -1 ) {
      integer_msb = 0;
   }

   DEBUGPRINTF1("integer_msb: %d\n", integer_msb);

   if( integer_msb > (bit_width - point_position) ) {
      fprintf(stderr, "fp32_to_fixed_point: Not enough bits to represent integer portion of number.\n");
      DEBUGPRINTF1("fp32_to_fixed_point: integer_msb = %d\n", integer_msb);
      return 0xFFFFFFFF;
   }

   /* Now reduce it to just the fractional part. */
   uint32 final_number = 0;

   float f_decimal_part;
   f_decimal_part = i - (float)i_integer_part;
   if( f_decimal_part != 0.0f ) {
      DEBUGPRINTF1( "Decimal part, in float form: %f [%x]\n", f_decimal_part, f32_to_uint32(f_decimal_part) );

      int      f_exponent = fp32_get_exponent(f_decimal_part);
      uint32   f_mantissa = fp32_get_mantissa(f_decimal_part);
      uint32   f_sign     = fp32_get_sign(f_decimal_part);

      DEBUGPRINTF1("f_exponent: %d [%x]\n", f_exponent, f_exponent);
      DEBUGPRINTF1("f_mantissa: %d [%x]\n", f_mantissa, f_mantissa);
      DEBUGPRINTF1("f_sign: %d\n", f_sign);

      /* Insert the hidden bit */
      f_mantissa |= 0x00800000;
      /* NOTE: f_mantissa is now the decimal portion in binary, essentially shifted left by 23 digits. */
      DEBUGPRINTF1("f_mantissa with hidden bit: %d [%x]\n", f_mantissa, f_mantissa);

      final_number = f_mantissa;

      /* The amount we want to shift the fractional mantissa part is this:
       *
       * At this point in the code, the f_mantissa's decimal point is at 
       * bit position 23 (from floating point standard) - f_exponent.
       *
       * i.e. if mantissa is 000...000111010101...0000 where the first 1 is
       * at position 23, and the exponent is -5, that means the decimal point
       * is at bit position 23 - (-5) = bit 28.
       *
       * Now, we take that number, and we need to shift it to put it in our
       * fixed point position. If e.g. we want 16 decimal bits, we will want
       * to shift it RIGHT by -((current bit position) - (16))
       * = -(current bit position) + 16
       *
       * But since (current bit position) = 23 - f_exponent, then
       * -(current bit position) = -23 + f_exponent
       *
       *  and thus:
       *
       * Shift Amount = -23 + f_exponent + desired bit position.
       *
       * */
      int32 shift_amt = -23 + f_exponent + point_position;

      if( shift_amt < 0 ) {
         final_number >>= -shift_amt; /* Negative shift amount == shift right */
      } else {
         final_number <<= shift_amt;
      }
   }

   /* Now that the fractional part is in place, we can put the integer portion into place */
   uint32 u_integer_masked = abs(i_integer_part) & ((1 << (bit_width-point_position))-1);

   DEBUGPRINTF1("u_integer_masked: %d [%x]\n", u_integer_masked, u_integer_masked);

   final_number |= u_integer_masked << point_position;

   /* Now, we deal with the sign. Since in fixed point, we do two's complement, we can just
    * negate this as if it were a regular signed integer. */
   int N = change_type(int, final_number);

   if( i_sign == 1 ) {
      N = -N;
      final_number = change_type(uint32, N);
   }

   DEBUGPRINTF1("u_integer_masked: %d [%x]\n", u_integer_masked, u_integer_masked);
   return final_number;
   
}
