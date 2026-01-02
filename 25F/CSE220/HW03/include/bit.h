/**
 * This is a header file. DO NOT make any changes inside the header files.
 * Students should implement all functions inside the src/ directory.
 */

#ifndef BIT_FILE
#define BIT_FILE

/**
 * Flips the bit of num at position pos.
 * @returns The updated integer after toggling the bit.
 */
int ToggleBit(int num, int pos);

/**
 * Finds the position of the most significant 1 bit in num.
 * @returns An integer representing the position of the most significant set bit.
 */
int GetMSB(int num);

/**
 * Clears all bits of num from position start to end (inclusive).
 * @returns The updated integer after clearing the specified range.
 */
int ClearBitRange(int num, int start, int end);

/**
 * Performs a circular left rotation of num by d positions.
 * @returns The rotated integer.
 */
int RotateLeft(int num, int d);

/**
 * Swaps all even-positioned and odd-positioned bits in num.
 * @returns The integer after swapping.
 */
int SwapOddEvenBits(int num);

#endif