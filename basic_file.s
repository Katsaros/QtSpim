	.text
	.globl __start
main:
# start of main program
	
	#jal	read_str			# read from the keyboard with max size 20
	#jal	print_str			# print string from label-> buffer
	#jal print_one_char			# code to print specific char from buffer (buffer is string in data and num the number in data) 
	
	#jal printEndl       		# display end of line
	#jal keno   	  		  	# display space between chars
	#jal welcome				# display welcome_str
	
	#jal readInt					# read int from the keyboard
	#jal printInt 				# print the above int WITHOUT data

	#jal	readIntAndWritetoData	# read Int from keyboard And Save to Data with label-> num	
	#jal	printIntData			# print int from Data label-> num
	
	li $v0,10		
	syscall				# exit 
# end of main program

#start of functions

printEndl: 
	la $a0,endl		
	li $v0,4
	syscall				# display end of line
	jr $ra
keno:
	la $a0, str_space
	li $v0,4
	syscall
	jr $ra
welcome: 
	la $a0,welcome_str		
	li $v0,4
	syscall				# display welcome_str
	jr $ra	
	
read_str:
		li $v0, 8			# code to read a string
		li $a1, 21			# max size = 20 bytes
		la $a0, buffer		# $a0 points to the string
		syscall	
		jr $ra
print_str:	
		la $a0, buffer
		li $v0,4
		syscall	
		jr $ra
		
print_one_char:
	li $t7, 0
	lw $t8, num($t7)	
	lb $a0, buffer($t8)	
	li $v0,11
	syscall	
	jr $ra
	
readIntAndWritetoData:
		li $t7, 0
		lw $s0, num($t7)	
		li $v0, 5
		syscall
		move $t8, $v0
		sw $t8, num($t7)
		jr $ra
printIntData: 
		li $t7, 0
		lw $a0, num($t7)
		li $v0, 1
		syscall
		jr $ra	
		
readInt:
		li $v0, 5
		syscall					#integer in v0 we need to move it 
		move $a0, $v0		#to an argument register
		jr $ra			
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
		jr	$ra				
#end of functions
	
	.data
endl: 	.asciiz "\n"
buffer:	.asciiz "--------------------"
str_space:	.asciiz " "
welcome_str:	.asciiz "Give a number: "
num: 	.word 0
str:	.asciiz "abcd"
