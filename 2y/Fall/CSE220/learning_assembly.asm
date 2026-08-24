.text
main:
# prompt to ask for an integer
li $v0, 4 # 4 for print string
la $a0, prompt
syscall

# read in an integer
li $v0, 5 # 5 for read integer
syscall
ori $s0, $v0, 0 # save read integer into $s0

# check parity
li $t0, 2
div $s0, $t0 # divide $s0 by 2
mfhi $t1 # take remainder (hi register)
beq $t1, $zero, end # jump to end if remainder is 0

# print "[thing in $s0] is an odd number"
li $v0, 1 # 1 for print integer
la $a0, ($s0)
syscall # print the number
li $v0, 4 # 4 for print string
la $a0, result_positive
syscall

end:
li $v0, 10 # 10 for exit
syscall

.data
prompt: .asciiz "Enter an integer:\n"
result_positive: .asciiz " is an odd number\n"