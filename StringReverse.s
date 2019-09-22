				.text
				.globl main
main:		
				la		$a0, test
				li 		$a1, 11
				jal		revertString
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
				
revertString:# $a0<-mem address of string,$a1<-length of string 
				addi 	$sp, $sp, -12
				sw 		$a0, 0($sp)
				sw 		$a1, 4($sp)
				sw 		$ra, 8($sp)
				add 	$a1, $a1, $a0
				addi 	$a1, $a1, -1
revertStringLoop:
				bge 	$a0, $a1, exitRevertStringLoop
				jal 	swapChar
				addi 	$a0, $a0,1
				addi 	$a1, $a1,-1
				j 		revertStringLoop
exitRevertStringLoop:
				lw 		$a0, 0($sp)
				lw 		$a1, 4($sp)
				lw 		$ra, 8($sp)
				addi 	$sp, $sp, 12
				jr 		$ra
swapChar: # $a0<- mem char 1, $a1<-mem char 2
				lb 		$t0, ($a0)
				lb 		$t1, ($a1)
				sb 		$t0, ($a1)
				sb 		$t1, ($a0)
				jr 		$ra
	
				.data
endl:			.asciiz "\n"
buffer:			.space 16
test:			.asciiz "Hello World" #11