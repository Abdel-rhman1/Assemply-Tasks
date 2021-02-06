.text
addi $s1 , $zero , 0  # i  
addi $s2 , $zero , 10 # a
addi $s3 , $zero , 0  # j
lui  $s0 , 0x1001       #100010000
ori  $s0 , $s0 , 0x0000
outerfor:
	beq $s1 , $s2 , endouter
	sll $t0 , $s1 , 2 # 0100    0001 4 4bit
	add $t0 , $t0 , $s0
	lw $t1 , 0($t0)
	addi $s3 , $zero , 0
	innerfor:
	beq $s1 , $s3 , endinner
	add $t1 , $t1 , $s3
	addi $s3 , $s3 , 1
	j innerfor
	endinner:
	sw $t1 0($t0)
	addi $s1 , $s1 , 1
	j outerfor
endouter:
