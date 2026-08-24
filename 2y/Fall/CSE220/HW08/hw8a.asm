# Aditya Pahuja, 116165208
.data
type_prompt: .asciiz "Triangle(0) or Square(1) or Pyramid(2)? "
size_prompt: .asciiz "Required size? "

.text
main:
# ask for shape type
li $v0, 4 # 4 for print string
la $a0, type_prompt # load prompt string for asking type of shape
syscall
li $v0, 5 # 5 for read integer
syscall
move $t0, $v0 # save read integer into $t0 before $v0 is overwritten
# print a newline:
li $v0, 11 # 11 for print character
li $a0, 10 # ascii for newline
syscall
# ask for shape size
li $v0, 4 # 4 for print string
la $a0, size_prompt # load prompt string for asking size of shape
syscall
li $v0, 5 # 5 for read integer
syscall
move $a1, $v0 # save read integer into $a1
# print a newline:
li $v0, 11 # 11 for print character
li $a0, 10 # ascii for newline
syscall
move $a0, $t0 # put shape type in $a0
# at this point $a0 and $a1 are the correct arguments
# here we pick which function to invoke based on $a0
li $t0, 0
beq $t0, $a0, call_draw_triangle # if $a0 == 0 draw triangle
li $t0, 1
beq $t0, $a0, call_draw_square # if $a0 == 1 draw square
li $t0, 2
beq $t0, $a0, call_draw_pyramid # if $a0 == 2 draw pyramid
# if none of the other branches are reached, jump to termination
j terminate_program

# these commands are pretty self explanatory...
call_draw_triangle:
jal draw_triangle
j terminate_program # jump to program-ending code

call_draw_square:
jal draw_square
j terminate_program # jump to program-ending code

call_draw_pyramid:
jal draw_pyramid
j terminate_program # jump to program-ending code

terminate_program:
li $v0, 10 # 10 for exit
syscall

#------------------------------print_star_line
print_star_line:
# draw line for a shape of size $a1 with $a2 stars,
# with $a0 indicating shape
li $v0, 11 # print character (won't change during loop)
li $t0, 2
beq $t0, $a0, with_spaces # if $a0 (shape) is 2, jump forward
# TODO 101 for debug pyramid, remove later
li $t0, 101
beq $t0, $a0, with_spaces # if $a0 (shape) is 101, jump forward

# ----- for non-pyramid
li $t1, 0 # loop variable
print_star_line_no_space_loop:
beq $t1, $a2, return_print_star_line
# ^if num stars drawn = num stars needed, end loop
li $a0, 42 # '*' is 42 in ascii
syscall
addi $t1, $t1, 1 # increment loop variable
j print_star_line_no_space_loop # go run loop again

# ----- for pyramid; this one needs $a1 too
with_spaces:
sub $t0, $a1, $a2 # $t0 = number of spaces before first star in line
subi $t1, $a2, 1 # $t1 = number of spaces after first star in line
pre_first_star_loop:
beq $t0, $0, draw_star_loop
# ^after drawing enough spaces, exit this loop and go to the next loop
li $a0, 32 # ' ' is 32 in ascii
syscall
addi $t0, $t0, -1 # decrement loop variable
j pre_first_star_loop

draw_star_loop:
beq $t1, $0, final_star
# ^after drawing enough, exit this loop and go to the next loop
# following four lines print "* "
li $a0, 42 # '*' is 42 in ascii
syscall
li $a0, 32 # ' ' is 32 in ascii
syscall
addi $t1, $t1, -1 # decrement loop variable
j draw_star_loop

final_star:
li $a0, 42 # '*' in ascii
syscall # print '*'
j return_print_star_line # end off fxn

return_print_star_line:
# $v0 is still 11
li $a0, 10 # ascii for newline
syscall # $v0 is still at 11 for print char
jr $ra
#------------------------------

#------------------------------draw_triangle
draw_triangle: # draw triangle with size $a1
addi $sp, $sp, -16 # make space on stack
sw $ra, 0($sp) # save $ra on stack
sw $s0, 4($sp) # save $s0 on stack
sw $s1, 8($sp) # save $s1 on stack
sw $s2, 12($sp) # save $s2 on stack
move $s0, $a0 # shape number
move $s1, $a1 # shape size
li $s2, 0 # num stars in the line
draw_triangle_loop:
beq $s1, $s2, return_draw_triangle # compare loop var to shape size
addi $s2, $s2, 1 # increment $s2
move $a0, $s0 # set args
move $a1, $s1 # set args
move $a2, $s2 # set args, $a2 increases with line number
jal print_star_line # run print line
j draw_triangle_loop

return_draw_triangle:
lw $ra, 0($sp) # restore $ra
lw $s0, 4($sp) # restore $s0
lw $s1, 8($sp) # restore $s1
lw $s2, 12($sp) # restore $s2
jr $ra
#------------------------------

#------------------------------draw_square
draw_square: # draw square with size $a1
addi $sp, $sp, -16 # make space on stack
sw $ra, 0($sp) # save $ra on stack
sw $s0, 4($sp) # save $s0 on stack
sw $s1, 8($sp) # save $s1 on stack
sw $s2, 12($sp) # save $s2 on stack
move $s0, $a0 # shape number
move $s1, $a1 # shape size
li $s2, 0 # num stars in the line
draw_square_loop:
beq $s1, $s2, return_draw_square # compare loop var to shape size
addi $s2, $s2, 1 # increment $s2
move $a0, $s0 # set args
move $a1, $s1 # set args
move $a2, $s1 # set args, $a2 = $a1 = shape size always
jal print_star_line # run print line
j draw_square_loop

return_draw_square:
lw $ra, 0($sp) # restore $ra
lw $s0, 4($sp) # restore $s0
lw $s1, 8($sp) # restore $s1
lw $s2, 12($sp) # restore $s2
jr $ra
#------------------------------

#------------------------------draw_pyramid
draw_pyramid: # draw pyramid with size $a1
addi $sp, $sp, -16 # make space on stack
sw $ra, 0($sp) # save $ra on stack
sw $s0, 4($sp) # save $s0 on stack
sw $s1, 8($sp) # save $s1 on stack
sw $s2, 12($sp) # save $s2 on stack
move $s0, $a0 # shape number
move $s1, $a1 # shape size
li $s2, 0 # num stars in the line
draw_pyramid_loop:
beq $s1, $s2, return_draw_pyramid # compare loop var to shape size
addi $s2, $s2, 1 # increment $s2
move $a0, $s0 # set args
move $a1, $s1 # set args
move $a2, $s2 # set args, $a2 increases with line number
jal print_star_line # run print line
j draw_pyramid_loop

return_draw_pyramid:
lw $ra, 0($sp) # restore $ra
lw $s0, 4($sp) # restore $s0
lw $s1, 8($sp) # restore $s1
lw $s2, 12($sp) # restore $s2
jr $ra
#------------------------------