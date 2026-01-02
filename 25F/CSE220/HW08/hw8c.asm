# Aditya Pahuja, 116165208
.data
v: .word 1, 3, 4, 2, 5 # array to be sorted
n: .word 5 # length of array
before_text: .asciiz "Before sorting: "
after_text: .asciiz "After sorting: "

.text
main:
li $v0, 4 # 4 for print string
la $a0, before_text # load "Before sorting: " string
syscall # print "Before sorting: "
la $a0, v # load array
lw $a1, n # load size of array
jal print_arr # print array
la $a0, v # load array
lw $a1, n # load size of array
jal sort_arr # sort array
li $v0, 4 # 4 for print string
la $a0, after_text # load "Before sorting: " string
syscall # print "Before sorting: "
la $a0, v # load array
lw $a1, n # load size of array
jal print_arr # print array
li $v0, 10 # 10 for exit
syscall # kill program

print_arr: # print array given $a0 = array address and $a1 = array size
move $t0, $a0 # set $t0 to array address
li $t1, 0 # zero prospective loop var
print_arr_loop:
beq $t1, $a1, print_arr_return # return if loop has been run n times
li $v0, 1 # 1 for print integer
lw $a0, 0($t0) # set $a0 to v[$t0]
syscall # print v[$t0]
li $v0, 11 # 11 for print character
li $a0, 32 # 32 for space
syscall # print space
addi $t0, $t0, 4 # icnrement array pointer
addi $t1, $t1, 1 # increment loop variable
j print_arr_loop # go loop
print_arr_return:
li $v0, 11 # 11 for print character
li $a0, 10 # 10 for newline
syscall # print newline
jr $ra # return

sort_arr:
# save $s0 through $s7 and $ra on stack
addi $sp, $sp, -36 # create space on stack
# following commands just toss the variables onto stack
sw $s0, 0($sp)
sw $s1, 4($sp)
sw $s2, 8($sp)
sw $s3, 12($sp)
sw $s4, 16($sp)
sw $s5, 20($sp)
sw $s6, 24($sp)
sw $s7, 28($sp)
sw $ra, 32($sp)
# sort
li $s0, 0 # i = 0
addi $s2, $a1, -1 # n - 1
move $s4, $a0 # $s4 = v
sort_outer_loop:
beq $s0, $s2, sort_return
li $s1, 0 # j = 0
sub $s3, $s2, $s0 # n - 1 - i
move $s5, $s4 # copy of the array pointer
sort_inner_loop:
beq $s1, $s3, sort_end_inner # check if j = n-1-i
lw $s6, ($s5) # v[j]
addi $s5, $s5, 4 # increment array pointer
lw $s7, ($s5) # v[j+1]
blt $s6, $s7, skip_swap # if v[j] <= v[j+1], skip swap
move $a0, $s4 # $a0 = v
move $a1, $s1 # $a1 = j
jal swap_in_arr
skip_swap:
addi $s1, $s1, 1 # increment j
j sort_inner_loop
sort_end_inner:
addi $s0, $s0, 1 # i++
j sort_outer_loop
sort_return:
# restore vars stored on stack
lw $s0, 0($sp)
lw $s1, 4($sp)
lw $s2, 8($sp)
lw $s3, 12($sp)
lw $s4, 16($sp)
lw $s5, 20($sp)
lw $s6, 24($sp)
lw $s7, 28($sp)
lw $ra, 32($sp)
addi $sp, $sp, 36 # restore stack pointer
jr $ra # jump back

swap_in_arr: # swap $a0[$a1] and $a0[$a1+1]
li $t0, 4 # set $t0 = 4
mult $a1, $t0 # multiply $a1 * 4 for offset of $a0
mflo $t0 # set $t0 to the needed offset
add $t1, $a0, $t0 # set $t1 to $a0 + 4*k (which corresponds to $a0[k])
addi $t2, $t1, 4 # set $t1 to $a0 + 4*(k-1) (which corresponds to $a0[k+1])
lw $t3, ($t1) # $t3 = v[k]
lw $t4, ($t2) # $t4 = v[k+1]
sw $t3, ($t2) # set v[k] to v[k+1]
sw $t4, ($t1) # set v[k+1] to (old value of) v[k]
jr $ra # return