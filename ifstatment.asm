.text
li $s1 , 0 # G
li $s2 , 9 # H
sle $t1 , $s1 , $s2 # if G <= H $t1 will be 1
sgt $t2 , $s1 , $zero # if G > 0 $t2 will be 1
and $t3 , $t2 , $t1 # $t2 and $t3 must be equal 
beq $t3 , 1,label # if the two register equal to 1 goto label
add $s1 , $s2 , $zero # else G = H + 0
j done
label:
add $s2 , $s1 , $zero  # H = G + 0
done: