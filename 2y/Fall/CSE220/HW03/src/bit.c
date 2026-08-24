#include <stdio.h>
#include <stdlib.h>
#include <bit.h>

// Students should fill in bodies of the functions below.

int ToggleBit(int num, int pos)
{
    return num ^ (1<<pos); // xor the bit at position pos with 1 to flip it;
    // other bits stay the same when xor'd with 0
}

int GetMSB(int num)
{
    int msb = 31;
    // num & (1 << msb) will be nonzer for the first time when msb
    // is equal to the position of the most significant bit.
    while (!(num & (1 << msb)) && msb >= 0) msb--;
    return msb;
}

int ClearBitRange(int num, int start, int end)
{
    // edge cases
    if (start < 0 || end > 31 || start > end) return num;
    // create mask of the form 1..10..01..1
    // where the 0s occupy the bits between start and end (inclusive)
    int mask = ~((unsigned int)~0 >> (31 - end + start) << start);
    return num & mask;
}

int RotateLeft(int num, int d)
{
    // since rotating by 32 is the same as not rotating,
    // replace d with the unique integer between 0 and 31
    // that is congruent to d modulo 32
    // (the +32 is in case d hence d % 32 is negative)
    d = ((d % 32) + 32) % 32;
    if (d == 0) return num;
    // save d leftmost bits by masking num with 1..10..0
    // (where there are d 1s at the left)
    // and then shifting back to the right
    int destroyed_bits = (unsigned int)((~0 << (32-d)) & num) >> (32 - d);
    return (num << d) | destroyed_bits;
}

int SwapOddEvenBits(int num)
{
    // masks, as given by the hint
    int odd_mask = 0xAAAAAAAA;
    int even_mask = 0x55555555;
    // shift the even bits to the left and odd bits to the right and combine
    return ((unsigned int)(odd_mask & num) >> 1) | ((even_mask & num) << 1);
}

/**
 * Create all test cases inside of the main function below.
 * Run the test cases by first compiling with "make" and then 
 * running "./build/bit"
 * 
 * Before submmiting your assignment, please comment out your 
 * test cases for the TAs.
 */
int main(int argc, char* argv[]){
    (void)argc;
    (void)argv;

    /** TEST CASES BEGIN
    // ToggleBit test cases
    printf("Toggling bit 0 of 0 gives %d (expecting 1)\n",
	   ToggleBit(0,0));
    printf("Toggling bit 0 of 1 gives %d (expecting 0)\n",
	   ToggleBit(1,0));
    printf("Toggling bit 10 of 1 gives %d (expecting 1025)\n",
	   ToggleBit(1,10));
    printf("Toggling bit 4 of 23 gives %d (expecting 7)\n",
	   ToggleBit(23,4));
    printf("Toggling bit 7 of 65535 gives %d (expecting 65407)\n",
	   ToggleBit(65535,7));
    // TODO something with toggling bit 31

    // MSB test cases
    printf("The MSB of 0 is at position %d (expecting -1)\n",
	   GetMSB(0));
    printf("The MSB of 3 is at position %d (expecting 1)\n",
	   GetMSB(3));
    printf("The MSB of 273 is at position %d (expecting 8)\n",
	   GetMSB(273));
    printf("The MSB of 1999000000 is at position %d (expecting 30)\n",
	   GetMSB(1999000000));
    printf("The MSB of -1 is at position %d (expecting 31)\n",
	   GetMSB(-1));
    printf("The MSB of -200 is at position %d (expecting 31)\n",
	   GetMSB(-200));

    // ClearBitRange test cases
    printf("Clearing bits 0 to 0 of 0 gives %d (expecting 0)\n",
	   ClearBitRange(0, 0, 0));
    printf("Clearing bits 0 to 3 of 18 gives %d (expecting 16)\n",
	   ClearBitRange(18, 0, 3));
    printf("Clearing bits 1 to 3 of 19 gives %d (expecting 17)\n",
	   ClearBitRange(19, 1, 3));
    printf("Clearing bits 5 to 5 of 255 gives %d (expecting 223)\n",
	   ClearBitRange(255, 5, 5));
    printf("Clearing bits 5 to 7 of 370 gives %d (expecting 274)\n",
	   ClearBitRange(370, 5, 7));
    printf("Clearing bits 0 to 30 of -1 gives %d (expecting -2147483648)\n",
	   ClearBitRange(-1, 0, 30));
    printf("Clearing bits 30 to 0 of 314 gives %d (expecting 314)\n",
	   ClearBitRange(314, 30, 0));
    printf("Clearing bits 0 to 32 of 159 gives %d (expecting 159)\n",
	   ClearBitRange(159, 0, 32));
    printf("Clearing bits -1 to 30 of 265 gives %d (expecting 265)\n",
	   ClearBitRange(265, -1, 30));

    // RotateLeft test cases
    printf("Rotating 0 to the left by 0 gives %d (expecting 0)\n",
	   RotateLeft(0,0));
    printf("Rotating -1 to the left by 7 gives %d (expecting -1)\n",
	   RotateLeft(-1,7));
    printf("Rotating 7 to the left by 3 gives %d (expecting 56)\n",
	   RotateLeft(7,3));
    printf("Rotating 7 to the left by 31 gives %d (expecting -2147483645)\n",
	   RotateLeft(7,31));
    printf("Rotating -84 to the left by 1 gives %d (expecting -167)\n",
	   RotateLeft(-84,1));

    // SwapOddEvenBits test cases
    printf("Swapping even/odd bits of 0 gives %d (expecting 0)\n",
	   SwapOddEvenBits(0));
    printf("Swapping even/odd bits of 5 gives %d (expecting 10)\n",
	   SwapOddEvenBits(5));
    printf("Swapping even/odd bits of 10 gives %d (expecting 5)\n",
	   SwapOddEvenBits(10));
    printf("Swapping even/odd bits of 23 gives %d (expecting 43)\n",
	   SwapOddEvenBits(23));
    printf("Swapping even/odd bits of 43 gives %d (expecting 23)\n",
	   SwapOddEvenBits(43));
    printf("Swapping even/odd bits of %d gives %d (expecting %d)\n",
	   0x80000000, SwapOddEvenBits(0x80000000), 0x40000000);
    printf("Swapping even/odd bits of %d gives %d (expecting %d)\n",
	   0x40000000, SwapOddEvenBits(0x40000000), 0x80000000);
    printf("Swapping even/odd bits of %d gives %d (expecting %d)\n",
	   0xAAAAAAAA, SwapOddEvenBits(0xAAAAAAAA), 0x55555555);
    printf("Swapping even/odd bits of %d gives %d (expecting %d)\n",
	   0x55555555, SwapOddEvenBits(0x55555555), 0xAAAAAAAA);
    /** TEST CASES END **/
    return 0;
}
