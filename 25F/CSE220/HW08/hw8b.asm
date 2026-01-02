# Aditya Pahuja, 116165208
.data
.align 2
A: .space 40
B: .space 40
num: .word 10
Ainp: .asciiz "A["
Binp: .asciiz "B["
endinp: .asciiz "]="

.text
main:
#----------- input
lw $t0, num # load length of array
la $t1, A # load address of A
la $t2, B # load address of B
li $t3, 0 # set $t3 (loop variable) to 0
input_loop:
beq $t0, $t3, input_done # check loop var vs length of arrays
addi $t3, $t3, 1 # increment loop var immediately for 1 indexing
# ****prompt for A
li $v0, 4 # 4 for print string
la $a0, Ainp # load Ainp string into $a0
syscall # print A[
li $v0, 1 # 1 for print integer
move $a0, $t3 # set $a0 to the index $t3
syscall # print index
li $v0, 4 # 4 for print string
la $a0, endinp # load endinp string into $a0
syscall # print ]=
# grab value of A[$t3]
li $v0, 5 # 5 for read integer
syscall # read an integer into $v0
sw $v0, 0($t1) # store value of $v0 at address of A
# ****prompt for B
li $v0, 4 # 4 for print string
la $a0, Binp # load Binp string into $a0
syscall # print B[
li $v0, 1 # 1 for print integer
move $a0, $t3 # set $a0 to the index $t3
syscall # print index
li $v0, 4 # 4 for print string
la $a0, endinp # load endinp string into $a0
syscall # print ]=
# grab value of B[$t3]
li $v0, 5 # 5 for read integer
syscall # read an integer into $v0
sw $v0, 0($t2) # store value of $v0 at address of B
# ****increment array pointers
addi $t1, $t1, 4 # increment A pointer
addi $t2, $t2, 4 # increment B pointer
j input_loop # jump back up to start of loop

input_done:
# need to offset pointers back to start by subtracting 4*num
li $t4, 4 # set $t4 = 4
mult $t0, $t4 # multiply array len by 4
mflo $t4 # set $t4 to the result (numbers should be small, so result lives in lo)
la $t1, A # reset A pointer
la $t2, B # reset B pointer
# -----------------------swap time
li $t3, 0 # set prospective loop var to 0
swap_loop:
beq $t0, $t3, swap_done # check loop var vs length of arrays
lw $t5, 0($t1) # temp = A[$t3]
lw $t6, 0($t2) # grab B[$t3]
sw $t6 0($t1) # A[$t3] = B[$t3]
sw $t5 0($t2) # B[$t3] = temp
addi $t3, $t3, 1 # increment loop var
addi $t1, $t1, 4 # increment A pointer
addi $t2, $t2, 4 # increment B pointer
j swap_loop # jump back up to start of loop

swap_done:
# need to offset pointers back to start by subtracting 4*num
li $t4, 4 # set $t4 = 4
mult $t0, $t4 # multiply array len by 4
mflo $t4 # set $t4 to the result (numbers should be small, so result lives in lo)
la $t1, A # reset A pointer
la $t2, B # reset B pointer
# ------------ just need to print out everything now
li $t3, 0 # set prospective loop var to 0
print_loop:
beq $t0, $t3, print_done # check loop var vs length of arrays
li $v0, 1 # 1 for print integer
lw $a0, 0($t1) # grab A[$t3]
syscall # print A[$t3]
li $v0, 11 # 11 for print character
li $a0, 32 # 32 is ascii for space
syscall # print space
li $v0, 1 # 1 for print integer
lw $a0, 0($t2) # grab B[$t3]
syscall # print B[$t3]
li $v0, 11 # 11 for print character
li $a0, 124 # 124 for | (pipe)
syscall # print |
addi $t3, $t3, 1 # increment loop var
addi $t1, $t1, 4 # increment A pointer
addi $t2, $t2, 4 # increment B pointer
j print_loop

print_done:
li $v0, 10 # 10 for exit
syscall # kill the program