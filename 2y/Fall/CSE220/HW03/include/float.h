/**
 * This is a header file. DO NOT make any changes inside the header files.
 * Students should implement all functions inside the src/ directory.
 */

#ifndef FLOAT_FILE
#define FLOAT_FILE

/**
 * @brief Construct IEEE 754 Single-precision Number 
 * @param sign_bit The sign bit zero-extended to an 8-bit binary representation
 * @param exponent The exponent field in 8-bit, excess-127 binary representation.
 * @param fraction The fraction field, or mantissa, zero-extended to 32-bit representation. 
 * @returns the binary representation of f as a float
 */
float construct_float_sf(char sign_bit, char exponent, unsigned int fraction);

#endif