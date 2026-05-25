# Aditya Pahuja, 116165208
.data
A: .word 9, 0, 0, 0
.word 0, 8, 0, 0
.word 0, 0, 7, 0
.word 0, 0, 0, 6
B: .word 5, 0, 0, 0
.word 0, 4, 0, 0
.word 0, 0, 3, 0
.word 0, 0, 0, 2
.align 2
C: .space 64 # 16 integers * 4 bytes each = 64 bytes
n: .word 4 # matrix dimension (4x4)
newline: .asciiz "\n"
space: .asciiz " "

.text
main:
la $a0, A # load arg for matmul
la $a1, B # load arg for matmul
la $a2, C # load arg for matmul
lw $a3, n # load arg for matmul
jal matmul
la $a0, C # load arg for print_matrix
lw $a1, n # load arg for print_matrix
jal print_matrix
li $v0, 10 # 10 for exit
syscall

matmul: # multiply matrices $a0, $a1 of size $a3, store result into $a2
# pseudocode:
# for i = 0, 1, 2, 3:
#   for j = 0, 1, 2, 3:
#     C[i][j] = 0
#     for k = 0, 1, 2, 3:
#       C[i][j] += A[i][k] * B[k][j]
li $t0, 0 # i = 0
i_loop:
	beq $t0, $a3, matmul_return
	li $t1, 0 # j = 0
	move $t8, $a1
	j_loop:
		beq $t1, $a3, end_i_loop
		li $t2, 0 # k = 0
		li $t6, 0 # will be the value of C[i][j]
		li $t9, 4
		k_loop:
			beq $t2, $a3, end_j_loop
			lw $t3, ($a0) # $t3 = A[i][k]
			lw $t4, ($t8) # $t4 = B[k][j]
			mult $t3, $t4
			mflo $t5 # $t5 = A[i][k] * B[k][j]
			add $t6, $t6, $t5 # acculumate the sum of the terms above
			addi $a0, $a0, 4 # move $a0 to the right
			mult $a3, $t9 # multiply 4*n
			mflo $t5 # $t5 = 4n
			add $t8, $t8, $t5 # move $t8 down a row
			addi $t2, $t2, 1 #increment loop var
			j k_loop
		end_j_loop:
			sw $t6 ($a2) # save the element in the relevant position of C
			sub $a0, $a0, $t5 # move A pointer up a row
			mult $a3, $t5 # $t5 should stlil have 4*n in it, so multiply to get 4n^2
			mflo $t5
			addi $t5, $t5, -4 # set $t5 = 4n^2 - 4
			sub $t8, $t8, $t5 # up 4 rows, and right 1 (subtract 4n^2 - 4)
			# ^to get to start of next column
			addi $a2, $a2, 4 # increment C pointer
			addi $t1, $t1, 1 # increment loop var j
			j j_loop
	end_i_loop:
		addi $t0, $t0, 1 # increment loop var i
		mult $a3, $t9 # multiply 4*n
		mflo $t5 # $t5 = 4n
		add $a0, $a0, $t5 # move $a0 down a row
		j i_loop
matmul_return:
	jr $ra

print_matrix: # print matrix $a0 with size $a1
li $t0, 0 # index for C
mult $a1, $a1
mflo $t1 # t1 = n*n = number of entries in matrix
move $t2, $a0 # set t2 to array address
print_loop:
beq $t0, $t1, print_return
addi $t0, $t0, 1 # need to 1-index so the remainder lines up
li $v0, 1 # 1 for print integer
lw $a0, ($t2) # $a0 = current element of matrix
syscall # print element of matrix
# now decide whther to print space or newline based on $t0 mod n
div $t0, $a1 # divide $t0 by $a1
mfhi $t4 # grab remainder into $t4
beq $t4, $0, select_newline # if $t4 is 0, print newline
bne $t4, $0, select_space # if $t4 is nonzero, print space
select_newline:
li $a0, 10 # 10 for newline
j go_print # now go print
select_space:
li $a0, 32 # 32 for space
j go_print # now go print
go_print:
li $v0, 11 # 11 for print character
syscall
addi $t2, $t2, 4 # increment C pointer
j print_loop # go back to start of loop
print_return:
jr $ra