.data
grades: .space 12
msg: .asciiz "Grades Sumation is equal\n"
.text
.globl main
main:
li $s0 , 3 # n
li $s1 , 0 # i
la $t1 , grades
la $s2 , msg
while:
beq $s0 , $s1 , endwhile
addi $v0 , $zero , 5
syscall
sw $v0 , 0($t1)
addi $t1 , $t1 , 4
addi $s1 , $s1 , 1
j while
endwhile:
la $t1 , grades
lw $a0 , 0($t1)
lw $a1 , 4($t1)
lw $a2 , 8($t1)
jal sum
add $t4 , $v0 , $zero
addi $v0 , $zero , 4
add $a0 , $zero ,$s2
syscall
addi $v0 , $zero , 1
add $a0 , $zero , $t4
syscall
addi $v0 , $zero , 10
syscall
sum:
add $t3 , $a0 , $a1
add $v0 , $2 , $t3
jr $ra
.end main
