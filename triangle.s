				.text
				.globl main
main:		
				la		$s0, a1
				lw		$t0, 0($s0)
				lw		$t1, 4($s0)
				lw		$t2, 8($s0)
				
				mult	$t0, $t0
				mflo	$t0
				mult	$t1, $t1
				mflo	$t1
				mult	$t2, $t2
				mflo	$t2
				
				la		$a0, rectangle
				
				add 	$t3, $t1, $t2
				bne		$t0, $t3, L1
				jal		printStr
				jal		exit
L1:
				add 	$t3, $t0, $t2
				bne		$t1, $t3, L2
				jal		printStr
				jal		exit
L2:
				add 	$t3, $t0, $t1
				bne		$t2, $t3, L3
				jal		printStr
				jal		exit
L3:
				la		$a0, notr
				jal		printStr
exit:
				li		$v0, 10
				syscall				
printStr:
				li		$v0, 4
				syscall
				addi	$sp, $sp, -4 	#extra code for the stack
				sw		$ra, 0($sp)  	#to keep the value of ra
				jal		printEndl	    #for printing new line
				lw		$ra, 0($sp)
				addi	$sp, $sp, 4
				jr		$ra
printEndl:
				li		$v0, 4
				move	$t0, $a0   		#usually a0 contains some value
				la		$a0, endl
				syscall
				move	$a0, $t0   		#restore a0 original value
				jr		$ra
	
				.data
a1:				.word 3
b1:				.word 4
c1:				.word 5
endl:			.asciiz "\n"
rectangle:		.asciiz "Our triangle is rectangular"
notr:			.asciiz "Our triangle is not rectangular"