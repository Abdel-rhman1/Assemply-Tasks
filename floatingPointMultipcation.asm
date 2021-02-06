.data
   n1: 		   .word  0x3f8ccccd #1.1
   n2: 		   .word  0x3f99999a #1.2
   mask_montissa:  .word  0x007FFFFF # monissa bits =1
   mask_esp:       .word  0x7F800000 # exp bits = 1
   ibit:           .word  0x00800000 # leading one
   obit:           .word  0x01000000 # normalize bit
.text
   .globl main
main:
   lw $s0 , n1   # load number one into $s0
   lw $s1 , n2	 # load number two into $s1
   lw $t4 , mask_montissa  # load mask_montissa into $t4
   and  $t0 , $s0 , $t4    # extract number one montissa into to
   and  $t1 , $s1 , $t4    # extract number two montissa into t1
   lw $t4 , ibit       # loading ibit in $t4   
   or $t0 , $t0 , $t4  # extract (this ne)1. number one   
   or $t1 , $t1 , $t4  # extract 1. number two
   lw $t4 , mask_esp   #load the mask_exp into $t4
   and $t2 , $s0 , $t4 # extract the number one expo
   srl $t2 , $t2 , 23  # shift number 1 right expon  bits to free bits for mantissa
   and $t3 , $s1 , $t4 # extract number 2 montissa
   srl $t3 , $t3 , 23  # shift number 2 right expon  bits to free bits for montissa
   match: 
   beq $t2 , $t3 , addsig # if the expon is equal go to addsig
   bgeu $t2 , $t3 , shiftb # otherwise determin the biggest expon(shift the samllest)
   shifta: # shifta          
   sub $t4 , $t3 , $t2 # sub the two expon 
   srav $t0 , $t0 , $t4 # shift the montissa right by the difference 
   add $t2 , $t2 , $t4  # update the number one exp
   j addsig            
   shiftb:               # shiftb
   sub $t4 , $t2 , $t3   # sib the two expon
   srav $t1 , $t1 , $t4  # shift the montissb  tight by the difference 
   add $t3 , $t3 , $t4   # update the number two exp
   addsig:
   xor $t5 , $t0 , $t1  # the new sign is equal to sign one xor sign two
   norm:          # normalize
   lw $t4 , obit   # load the obit int o $t4
   and $t4 , $t5 , $t4   
   beq $t4 , $zero , done # if the 1. 
   srl $t5 , $t5 , 1 
   addi $t2 , $t2 ,1 
   done:
   lw $t4 , mask_montissa 
   and $t5 , $t5 , $t4
   sll $t2 , $t2 , 23
   lw $t4 , mask_esp
   and $t2 , $t2 , $t4
   or $v0 , $t5 , $t2
.end main