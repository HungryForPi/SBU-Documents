/* DO NOT ADD CODE TO THIS FILE. IT WILL BE REPLACED DURING GRADING. */
#ifndef STRPTR_FILE
#define STRPTR_FILE

#include <assert.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

/**
 * @returns the length of string s.
 */
int strgLen(const char* s);

/**
 * @brief copies the content of string s (source) to d (destination).
 */
void strgCopy(char* s, char* d);

/**
 * @brief for each character in the string, if it is an alphabet, reverse the case of the character (upper to lower, and lower to upper). Keep the non-alphabet characters as is.
 */
void strgChangeCase(char* s);

/**
 * @brief compare strings s1 and s2. 
 * @return the index where the first difference occurs. Return -1 if the two strings are equal.
 */
int strgDiff(char* s1, char* s2);

/**
 * @brief copy s1 and s2 to d, interleaving the characters of s1 and s2. If one string is longer than the other, after interleaving, copy the rest of the longer string to d. 
 * @example For example, given s1 = “abc'' and s2 = “123”, then d = “a1b2c3”. If s1 = “abcdef” and s2 = “123”, then d = “a1b2c3def”
 */
void strgInterleave(char* s1, char* s2, char* d);

/**
 * @brief Reverse only the letters (A–Z, a–z) across the whole string, keeping all non-letters (spaces, digits, punctuation) at their original positions. 
 */
void strgReverseLetters(char* s);

#endif
