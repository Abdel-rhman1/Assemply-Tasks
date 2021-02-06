.data 
str: .asciiz "Utility"
.text 
la , $t1, str # $t1 this array pointer
addi $t4 , $zero , 0 # initialize output by 0
while:
lb $t2 , 0($t1) # load byte from $t1
beq $t2 , 0x00 , endwhile #loop till the $t2 reach to the end
addi $t1 , $t1 , 1   # increament pointer address by 1 ( one byte)
beq $t2 , 0x41 , label   # Ascii for A 
beq $t2 , 0x61 , label   # AScii for a
beq $t2 , 0x45 , label   # Ascii for E
beq $t2 , 0x65 , label   #       for e
beq $t2 , 0x49 , label   #       for I
beq $t2 , 0x69 , label   #       for i
beq $t2 , 0x4F , label   #       for O
beq $t2 , 0x6F , label   #       for o 
beq $t2 , 0x55 , label   #       for U
beq $t2 , 0x75 , label   #       for u
j while
label:
addi $t4 , $t4 , 1 # increaemt output by 1
j while
endwhile:
addi $v0 , $zero , 1 # put 1 in $v0 to print intger
add $a0 , $zero ,$t4 # put the number in the $a0
addi $v0 , $zero , 10
syscall
syscall # call system call
