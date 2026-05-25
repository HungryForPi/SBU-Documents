#include <stdio.h>
#include <float.h>


float construct_float_sf(char sign_bit, char exponent, unsigned int fraction) {
    /* DO NOT CHANGE THE DECLARATION OF "f" (This will be converted to float later) */
    unsigned int f = 0; // DO NOT CHANGE
    /*------------------------------------------------------------------------------*/

    /* Start Coding Here */
    f = sign_bit << 31; // set last bit of sign_bit to first bit of f
    f |= (unsigned char)exponent << 23; // set next 8 bits as exponent
    f |= fraction; // set final 23 bits

    /*-------------------*/

    /* DO NOT CHANGE THE RETURN VALUE (This returns the binary representation of "f" as float) */
    return *((float*)&f); // DO NOT CHANGE
    /* ----------------------------------------------------------------------------------------*/
}

/**
 * Create all test cases inside of the main function below.
 * 
 * Run the test cases by running:
 * > make
 * > ./build/float
 * 
 * Before submmiting your assignment, please comment out your 
 * test cases for the TAs.
 */
int main(int argc, char* argv[]){
    (void)argc;
    (void)argv;
    /** TEST CASES BEGIN
    printf("sign %d, exponent %d, mantissa %d -> f = %f (expecting %f)\n",
	   0x00, 0x00, 0x000000, construct_float_sf(0x00, 0x00, 0x000000),
	   0.0);
    printf("sign %d, exponent %d, mantissa %d -> f = %f (expecting %f)\n",
	   0x01, 0x00, 0x000000, construct_float_sf(0x01, 0x00, 0x000000),
	   -0.0);
    printf("sign %d, exponent %d, mantissa %d -> f = %f (expecting %f)\n",
	   0x00, 0x7F, 0x000000, construct_float_sf(0x00, 0x7F, 0x000000),
	   1.0);
    printf("sign %d, exponent %d, mantissa %d -> f = %f (expecting %f)\n",
	   0x01, 0x7F, 0x000000, construct_float_sf(0x01, 0x7F, 0x000000),
	   -1.0);
    printf("sign %d, exponent %d, mantissa %d -> f = %f (expecting %f)\n",
	   0x00, 0x81, 0x300000, construct_float_sf(0x00, 0x81, 0x300000),
	   5.5);
    printf("sign %d, exponent %d, mantissa %d -> f = %f (expecting %f)\n",
	   0x01, 0x81, 0x300000, construct_float_sf(0x01, 0x81, 0x300000),
	   -5.5);
    printf("sign %d, exponent %d, mantissa %d -> f = %f (expecting %f)\n",
	   0x00, 0x76, 0x299B6F, construct_float_sf(0x00, 0x76, 0x299B6F),
	   0.002588);
    printf("sign %d, exponent %d, mantissa %d -> f = %f (expecting %f)\n",
	   0x01, 0x76, 0x299B6F, construct_float_sf(0x01, 0x76, 0x299B6F),
	   -0.002588);
    printf("sign %d, exponent %d, mantissa %d -> f = %f (expecting %f)\n",
	   0x00, 0x7D, 0x2AAAAA, construct_float_sf(0x00, 0x7D, 0x2AAAAA),
	   0.333333);
    /** TEST CASES END **/
    return 0;
}

