#include <stdlib.h>
#include "caesar.h" 
#include "strPtr.h"

/**
 *  Feel free to use the functions that you made in strPtr.c
*/ 

int isUpper(char c); // these guys are already initialized in strPtr.c
int isLower(char c);

int isDigit(char c) {
    return 48 <= c && c <= 57;
}

int encryptCaesar(const char *plaintext, char *ciphertext, int key) {
    if (plaintext == NULL || ciphertext == NULL) return -2;
    // check if plaintext is empty
    if (*plaintext == '\0') {
	char *undef = "undefined__EOM__";
	while (*undef != '\0') {
	    *ciphertext++ = *undef++;
	}
	*ciphertext = '\0';
	return 0;
    }

    int index = 0;
    int changed = 0;
    while (*plaintext != '\0') {
	int letter_shift = ((key + index) % 26 + 26) % 26; // +26 in case of negative
	int number_shift = ((key + 2*index) % 10 + 10) % 10; // +10 in case of negative
	if (isUpper(*plaintext)) {
	    *ciphertext = (*plaintext - 65 + letter_shift) % 26 + 65;
	    // idea is to shift the plaintext character down into {0, 1, ..., 25}
	    // so that the remainders mod 26 correspond to the letters IN ORDER,
	    // then re-shifting them so that A <-> 65 gives the correct ASCII
	    changed++;
	}
	else if (isLower(*plaintext)) {
	    *ciphertext = (*plaintext - 97 + letter_shift) % 26 + 97;
	    changed++;
	}
	else if (isDigit(*plaintext)) {
	    *ciphertext = (*plaintext - 48 + number_shift) % 10 + 48;
	    changed++;
	}
	else {
	    *ciphertext = *plaintext;
	}
	ciphertext++; plaintext++; index++;
    }
    char *end = "__EOM__";
    while (*end != '\0') { // stick __EOM__ to the end
	*ciphertext++ = *end++;
    }
    *ciphertext = '\0';
    return changed;
}

// returns index of first instance of `__EOM__`, or -1 if no EOM found
int find_EOM(const char *s) {
    int len = strgLen(s);
    char *eom = "__EOM__";
    for (int i = 0; i < len - 6; i++) {
	int matches_eom = 1;
	for (int j = 0; j < 7 && matches_eom; j++) {
	    matches_eom = matches_eom && (*(s + i + j) == *(eom + j));
	}
	if (matches_eom) {
	    return i;
	}
    }
    return -1;
}

int decryptCaesar(const char *ciphertext, char *plaintext, int key) {
    if (plaintext == NULL || ciphertext == NULL) return -2;
    // emptiness check
    if (*plaintext == '\0') return 0;
    // EOM check
    int eom_loc = find_EOM(ciphertext);
    if (eom_loc < 0) return -1;

    int len = strgLen(ciphertext);
    int plain_len = strgLen(plaintext);
    // undefined check
    char *undef = "undefined__EOM__";
    int is_undef = 1;
    for (int i = 0; i < len; i++) {
	is_undef = is_undef && (*(ciphertext + i) == *undef++);
    }
    if (is_undef) {
	char *undef_plain = "undefined";
	while (*undef_plain != '\0') {
	    *plaintext++ = *undef_plain++;
	}
	*plaintext = '\0';
	return 0;
    }

    // main logic
    int index = 0;
    int changed = 0;
    for (int i = 0; i < eom_loc; i++) {
	// negatives (mod 26) of letter_shift and number_shift from above
	int letter_shift = ((-key - index) % 26 + 26) % 26; // +26 in case of negative
	int number_shift = ((-key - 2*index) % 10 + 10) % 10; // +10 in case of negative
	if (isUpper(*ciphertext)) {
	    if (i < plain_len)
	    *plaintext = (*ciphertext - 'A' + letter_shift) % 26 + 'A';
	    // idea is to shift the plaintext character down into {0, 1, ..., 25}
	    // so that the remainders mod 26 correspond to the letters IN ORDER,
	    // then re-shifting them so that A <-> 65 gives the correct ASCII
	    changed++;
	}
	else if (isLower(*ciphertext)) {
	    if (i < plain_len)
	    *plaintext = (*ciphertext - 'a' + letter_shift) % 26 + 'a';
	    changed++;
	}
	else if (isDigit(*ciphertext)) {
	    if (i < plain_len)
	    *plaintext = (*ciphertext - '0' + number_shift) % 10 + '0';
	    changed++;
	}
	else {
	    if (i < plain_len)
	    *plaintext = *ciphertext;
	}
	if (i < plain_len) plaintext++; // don't append letters past length of plaintext
	ciphertext++; index++;
    }
    *plaintext = '\0';

    return changed;
}


/**
 * Create all test cases inside of the main function below.
 * Run the test cases by first compiling with "make" and then 
 * running "./bin/caesar"
 * 
 * Before submmiting your assignment, please comment out your 
 * test cases for the TAs. 
 * Comment out if using criterion to test.
 *
int main(int argc, char* argv[]){
	(void)argc;
	(void)argv;
	return 0;
} */
