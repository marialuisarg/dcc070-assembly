.data
	
.text	
	.main:
		#inserindo valores para a,b,c,d,e
		#assumindo a = $t0, b = $t1, c = $t2, d = $t3, e = $t4
		li $t0, 10
		li $t1, 3
		li $t2, 2
		li $t3, 3
		li $t4, 1
		
		#passando os argumentos
		move $a0, $t0       # 0($fp) reservado na pilha
		move $a1, $t1       # 4($fp) reservado na pilha
		move $a2, $t2       # 8($fp) reservado na pilha
		move $a3, $t3       # 12($fp) reservado na pilha
		add  $sp, $sp, -20
		sw   $t4, 16($sp)   # armazena o 5o argumento na pilha
		
		jal  valorAleatorio
		jal  FIM

	valorAleatorio:
		mult 	$a0, $a1   	    # a * b
		mflo 	$t0
		add 	$t1, $t0, $a2	# a * b + c
		div 	$t1, $a3	    # (a * b + c) % d
		mfhi 	$t2
		sub 	$v1, $t2, $t4	# (a * b + c) % d - e
	
		jr	    $ra		        # retorna para main
	
	FIM: 
		li $v0, 10
		syscall	