.ordenaVetor:
	
	#contador do for i
	li $t1, $zero
	
	#t0 mantém o indice do vetor
	add $t0, $zero, $a0
	
	#armazena tamanho do vetor em s0 e ajusta bytes
	add $s0, $zero, $a1
	sll $s0, $s0, 2
		
	for_i:
		addi $t1, $t1, 4		# i++
		subi $t4, $s0, 4		# n-1
		slt $t3, $t1, $t4		# testa condição de parada (i < n-1)
		
		beq $t3, $zero, fim_for_i	# se falso vai pra fim_for_i
		li $t5, $t1, $zero		# min_idx = i
		
		li $t2, $zero			# contador do for j
		
		for_j:
			addi $t3, $t3, 4		# j++
			slt $t3, $t2, $s0		# testa condição de parada (j < n)
			
			beq $t3, $zero, fim_for_j 	# se falso vai pra fim_for_j
			
			lw $t4, $t2($t0)		# carrega vet[j] em $t4
			lw $t6, $t5($t0)		# carrega vet[min_idx] em $t6
			
			slt $t3, $t4, $t6 		# if (vet[j] < vet[min_idx])
			beq $t3, $zero, for_j		# se falso, volta pro início do loop
			li $t5, $t2			# min_idx = j
			
			j for_j				# vai pro inicio do for_j
			
		fim_for_j:
			beq $t5, $t1, for_i			# se (min_idx == i), volta pro inicio do loop
		
			# carrega argumentos para troca
			la $t4, $t1($t0)			# carrega endereço de vet[i] em t4
			la $t6, $t5($t0)			# carrega endereço de vet[min_idx] em t6
		
			move $a0, $t6
			move $a1, $t4
			jal troca
		
			j for_i
		
	fim_for_i:
		li $v0, 4
		jr ra