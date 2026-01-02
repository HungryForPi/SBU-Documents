#include <stdio.h>
#include <stdlib.h>
#include <integer.h>

// FILL IN THE BODY OF THIS FUNCTION.
// Feel free to create any other functions you like; just include them in this file.

void print_hex_repr(unsigned int num) {
    int leading_zero_count = 8;
    // count number of zero needed to pad out repr into 8 hex digits
    unsigned int num_copy = num;
    while (num > 0) {
	num = num >> 4;
	leading_zero_count--;
    }
    // count is 8 means num = 0, but this still has a digit
    if (leading_zero_count == 8) leading_zero_count--;
    for (int _ = 0; _ < leading_zero_count; _++) printf("0");
    printf("%x\n", num_copy);
    return;
}

void repr_convert(char source_repr, char target_repr, unsigned int repr) {
    // errors and edge cases
    if ((source_repr != '2' && source_repr != 'S') ||
	(target_repr != '2' && target_repr != 'S')) {
	printf("error\n");
	return;
    }
    // when source repr and target repr are the same
    // or the leftmost bit of repr is 0 (so it represents a positive number)
    // the conversion should just be repr itself
    if (source_repr == target_repr || repr >> 31 == 0) {
	print_hex_repr(repr);
	return;
    }

    // if the leftmost bit is 1 then:
    // to convert S -> 2 flip the bits of the magnitude and add 1
    if (source_repr == 'S') {
	print_hex_repr((1 << 31 | ~repr) + 1);
	return;
    }
    else if (repr != 1 << 31) {
	// to convert 2 -> S, subtract 1 and then flip everything
	// after the leftmost bit; this fails if and only if
	// subtracting 1 decreases the leftmost bit, i.e.
	// 10...0 in 2's complement doesn't have a representation
	// in sign-magnitude
	print_hex_repr(1 << 31 | ~(repr - 1));
	return;
    }
    else {
	printf("undefined\n");
	return;
    }
}


/**
 * Create all test cases inside of the main function below.
 * Run the test cases by first compiling with "make" and then 
 * running "./build/integer"
 * 
 * Before submmiting your assignment, please comment out your 
 * test cases for the TAs.
 */
int main(int argc, char* argv[]){
    (void)argc;
    (void)argv;
    /** TEST CASES BEGIN
    repr_convert('S', '2', 0x80000001);
    repr_convert('S', '2', 0x80000000);
    repr_convert('S', '2', 0x00000128);
    repr_convert('S', '2', 0xff888889);
    repr_convert('S', '2', 0xfe54e10b);

    repr_convert('2', 'S', 0x80777777);
    repr_convert('2', 'S', 0x81ab1ef5);
    repr_convert('2', 'S', 0x00000128);
    repr_convert('2', 'S', 0xff888889);
    repr_convert('2', 'S', 0xfe54e10b);

    repr_convert('2', '2', 0x59f2ca50);
    repr_convert('F', '2', 0x80000001);
    repr_convert('2', 'S', 0x80000000);


    /** TEST CASES END **/
    return 0;
}
