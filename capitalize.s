
				.text
				
				la		$a0, buffer
nextCh:								
				lb		$t2, 0($a0)
				beqz 	$t2, strEnd
				and		$t2, $t2, 0xDF
				sb		$t2, 0($a0)
				addi	$a0, $a0, 1
				j		nextCh
strEnd:
				la		$a0, buffer
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
readStr:
				la		$a0, buffer
				li		$a1, 15    		#length of the string
				lb		$zero, 16($a0)
				li		$v0, 8
				syscall
				jr		$ra

				.data
endl:			.asciiz "\n"
buffer:			.asciiz "aaaaa"