.data
	
.text	
	.main:
		#inserindo valores para a,b,c,d,e
		#assumindo a = $s0, b = $s1, c = $s2, d = $s3, e = $s4 (valores aleatorios para teste da função)
		li $s0, 10
		li $s1, 3
		li $s2, 2
		li $s3, 3
		li $s4, 1
		
		#passando os argumentos
		move $a0, $s0       # passa s0 como primeiro argumento
		move $a1, $s1       # passa s1 como segundo argumento
		move $a2, $s2       # passa s2 como terceiro argumento
		move $a3, $s3       # passa s3 como quarto argumento
		add  $sp, $sp, -4
		sw   $s4, 0($sp)   # armazena o 5o argumento na pilha
		
		jal  valorAleatorio
		jal  FIM

	valorAleatorio:
		mult 	$a0, $a1        # a * b
		mflo 	$t0
		add 	$t1, $t0, $a2   # a * b + c
		div 	$t1, $a3        # (a * b + c) % d
		mfhi 	$t2
		sub 	$v1, $t2, $s4   # (a * b + c) % d - e
	
		jr      $ra             # retorna para main
	
	FIM: 
		li $v0, 10
		syscall	
