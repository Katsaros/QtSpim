#needs comments
				.text
				.globl main
main:		
				la		$a0, message
				jal		printStr
				
				la 		$s0, num
				lw      $a0, 0($s0)
				move	$t0, $a0	#t0 = min
				li 		$t1, 9
L1:
				addi	$s0, $s0, 4
				lw		$a0, 0($s0)
				sgt		$t2, $a0, $t0
				beq		$t2, $zero, continue 
				move	$t0, $a0
continue:
				addi	$t1, $t1, -1
				bne		$t1, $zero, L1
				move	$a0, $t0
				jal		printInt
exit:
				li		$v0, 10
				syscall				
printStr:
				li		$v0, 4
				syscall
				jr		$ra
printInt:		
				addi	$sp, $sp, -4
				sw		$ra, 0($sp)
				li		$v0, 1
				syscall
				addi	$sp, $sp, -4 	#extra code for the stack
				sw		$ra, 0($sp)  	#to keep the value of ra
				jal		printEndl	   	#for printing new line
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
num:			.word	6, 5, 10, 20, 90, 12, 21, 21, 130, 10
message:		.asciiz "max = "
message2:		.asciiz	"is "
endl:			.asciiz "\n"
