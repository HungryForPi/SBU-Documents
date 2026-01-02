#include <stdlib.h>
#include "strPtr.h"

int strgLen(const char *s) {
    if (s == NULL) return -1;

    int len = 0;
    while (*(s + len) != '\0') len++;
    return len;
}

void strgCopy(char *dest, char *src) {
    if (src == NULL || dest == NULL) return;

    while (*src != '\0') {
	*dest++ = *src++;
    }
    *dest = '\0';
}

// helper functions for conciseness
int isNotDigit(char c) {
    return !(48 <= c && c <= 57);
}

int isUpper(char c) {
    return 65 <= c && c <= 90;
}

int isLower(char c) {
    return 97 <= c && c <= 122;
}

void strgChangeCase(char *s) {
    if (s == NULL) return;
    char prevchar = *s; // don't start prevchar behind s;
    // this doesn't mess with anything because if *s is a digit then
    // there is nothing to do anyway
    char nextchar = *(s+1);
    char curchar = *s;
    while (curchar != '\0') {
	nextchar = *(s+1);

	if (isNotDigit(prevchar) && isNotDigit(nextchar)) { // check adjacent guys
	    if (isUpper(curchar)) *s += 32;
	    if (isLower(curchar)) *s -= 32;
	    // +-32 shifts convert between upper and lower in ASCII
	}

	s++;
	prevchar = curchar;
	curchar = nextchar;
	// nextchar is set at the beginning ---
	// we only want to set nextchar if curchar isn't NUL
    }
}

int strgDiff(char *s1, char *s2) {
    if (s1 == NULL || s2 == NULL) return -2;
    int index = 0;
    while (!(*(s1+index) == '\0' && *(s2+index) == '\0')) {
	// while the strings havent ended
	if (*(s1+index) != *(s2+index)) return index;
	index++;
    }
    return -1;
}

void strgInterleave(char *s1, char *s2, char *d) {
    if (s1 == NULL || s2 == NULL) return;
    int s1done = 0;
    int s2done = 0;
    while (!(s1done && s2done)) {
	if (!s1done) { // if s1 hasn't finished append a letter of s1 to d
	    if (*s1 == '\0') s1done = 1;
	    else *d++ = *s1++;
	}
	if (!s2done) { // then, do the same with s2
	    if (*s2 == '\0') s2done = 1;
	    else *d++ = *s2++;
	}
    }
    // add null terminator
    *d = '\0';
}

void strgReverseLetters(char *s) {
    if (s == NULL) return;

    int len = strgLen(s);
    char letters_only[len]; // store just the letters
    int letters_only_index = 0;
    for (int i = 0; i < len; i++) {
	// isUpper || isLower checks if *s is a letter
	if (isUpper(*s) || isLower(*s)) letters_only[letters_only_index++] = *s;
	s++;
    }
    while (*s != '\0') {
    }

    s -= len; // send the pointer s back to the start of the string
    // but not index of letters_only, so we traverse letters_only in reverse order
    while (*s != '\0') {
	if (isUpper(*s) || isLower(*s)) *s = letters_only[--letters_only_index];
	s++;
    }
}



/**
 * Create all test cases inside of the main function below.
 * Run the test cases by first compiling with "make" and then 
 * running "./bin/strPtr"
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
