.data
odd: .asciiz "Odd\n" # string for printing only 
even: .asciiz "Even\n" #string for printing only
.text  
main: # main function
add $v0 , $zero , 5  # add 5 to v0 to read integer
syscall   
add $a0 , $zero , $v0    # put the parameter in $a0 
la $t1 , odd             # load odd string into $t1 regitser
la $t7 , even            # load even string into $t7 register
jal isodd                # jump and link to isodd function
add $t4 , $v0 , $zero    # put the parameter into $t4 register
beq $t4 , 1 , printodd   #  if $t4 == 1 printodd similar as question assig
j printeven              #  otherwsie pritneven 
printodd:                # printodd function
addi $v0 , $zero , 4     # put 4 into v4 to print string
addi $a0 , $t1 , 0       # put the address of the string to br printrd in a0
syscall   
j end                   # jump to the end
printeven:              #pritn even
addi $v0 , $zero , 4    
addi $a0 , $t7 , 0
syscall
end:
add $a0 , $t4 , $zero  #  put 1 if odd otherwise 0
addi $v0 , $zero , 1   # put  1 in $v0 to print integer
syscall       
addi $v0 , $zero , 10   # put 10 into v0 to tereminate the program
syscall 
isodd:            # isodd function
addi $sp , $sp ,-4    # decrement the stack by 4 byte
sw $ra , 0($sp)       #  store the returned address in stack pointer 
jal isEven            # call the isEven function
not $v0 , $v0         # invert the reslt
lw $ra ,0($sp)        # load word from the stack =
addi $sp , $sp , 4    # return stack pointer
isEven:
addi $t2 , $zero , 2      # add to $t2 2
div $a0 , $t2             # div a0(paramter) 2
mfhi $t6                  # get the reminder of the division
add $v0 , $zero , $t6     # put the reminder into retuned register
jr $ra
