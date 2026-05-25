/* DO NOT ADD CODE TO THIS FILE. IT WILL BE REPLACED DURING GRADING. */
#ifndef CAESAR_FILE
#define CAESAR_FILE

#include <assert.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

/**
 * @brief encrypts a message with caesar cypher strategy using a given key. 
 * @param plaintext  a null-terminated string to be encrypted. The string contains only ASCII characters 
 * @param ciphertext a null-terminated string used to encrypt the plaintext according to the caesar cipher approach. A mutable character array is passed as ciphertext so that its contents may be changed.
 * @param key an integer that represents the amount the characters are shifted
 */
int encryptCaesar(const char *plaintext, char *ciphertext, int key);

/**
 * @brief decrypts a message with caesar cypher using a given key.
 * @param ciphertext a null-terminated string that encodes a message using cipher. 
 * @param plaintext a null-terminated string of (possibly) random characters. A mutable character array is passed as plaintext so that its contents may be changed.
 * @param key an integer that represents the amount the characters are shifted
 */
int decryptCaesar(const char *ciphertext, char *plaintext, int key);
#endif
