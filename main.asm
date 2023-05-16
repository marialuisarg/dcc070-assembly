.data
    vet: .word 0:19
.text
.eqv SIZE 20
.eqv nline 10
.main:
    #endereço de memoria do vetor
    la $a0, vet

    #tamanho do vetor
    li $a1, SIZE
    
    #ultimo valor
    li $a2, 71

    jal inicializaVetor
    #copia valores de retorno
    move $t0, $v0
    move $t1, $v1
    
    #soma retornos
    add $t3, $t1, $t0
    add $s6, $zero, $t3
    #li $v0, 1
    #add $a0, $t3, $zero
    #syscall
    
    #imprime o vetor
    la $a0, vet
    li $a1, SIZE
    
    jal imprimeVetor

    la $a0, vet
    li $a1, SIZE

    # jal ordenaVetor

    #carrega endereço da primeira posicao do vetor
    la $t0, vet

    li $t3, SIZE
    sll $t3, $t3, 2
    
    #carrega ultima posicao do vetor
    add $t1, $t0, $t3

    move $a0, $t0
    move $a1, $t1
    
    jal zeraVetor

    la $a0, vet
    li $a1, SIZE

    jal imprimeVetor

    #imprime soma
    li $v0, 1
    add $a0, $s6, $zero
    syscall
    
    li $v0, 10
    syscall

inicializaVetor:
  
    #prepara stack para 5 valores
    addi $sp, $sp -24
    sw $ra, 0($sp)
    
    #carrega valores em registradores s
    add $s0, $zero, $a0
    add $s1 ,$zero, $a1
    add $s2, $zero, $a2
    
    #salva valores na stack
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)
    
    #caso trivial, tam =0
    li $t3, 0
    bgt $t3, $s1, end
            
    #carrega argumentos de valorAleatorio
    move $a0, $s2
    li $a1, 47
    li $a2, 97
    li $a3, 337
    li $s4, 3

    #carrega quinto argumento
    sw $s4, 16($sp)

    jal valorAleatorio
    move $t2, $v1
    
    #subtrai tam-1 
    addi $s1, $s1, -1
    
    #carrega bytes do vetor
    add $t0, $zero, $s1
    sll $t0, $t0, 2
    
    #vai para o indice tam -1
    add $s0, $s0, $t0

    #salva valor aleatorio
    sw $t2, 0($s0)

    #volta o indice	
    sub $s0, $s0, $t0
    
    		
    #carrega argumentos novamente
    add $a0, $zero, $s0
    add $a1, $zero, $s1
    add $a2, $zero, $t2
    
    

    #salva novoValor
    add $s5, $s5, $t2
    sw $s5, 20($sp)
   
    jal inicializaVetor
end:
   #carrega caso trivial
    li $v0, 0
    
    #recupera endere�o de retorno
    lw $ra, 0($sp)
    
    #recupera somatorio
    add $v1, $zero, $s5
    
    #desaloca stack
    addi $sp, $sp, 24
    
    jr $ra

valorAleatorio:
		mult 	$a0, $a1        # a * b
		mflo 	$t0
		add 	$t1, $t0, $a2   # a * b + c
		div 	$t1, $a3        # (a * b + c) % d
		mfhi 	$t2
		sub 	$v1, $t2, $s4   # (a * b + c) % d - e
	
		jr      $ra             # retorna 
		
# recebe um vetor e printa
imprimeVetor:
    # contador do for
    li $t0, 0
    
    #$t1 mantem o indice do vetor
    add $t1, $zero,$a0
    
    #tamanho do vetor em $s1
    add $s1, $zero,$a1
    

    for:
    	# multiplica por 4 para a quantidade de bytes
    	sll $s1,$s1, 2
    		
    	#incrementa o indice
        addi $t0, $t0, 4
        
        #checa condicao de parada
        bgt $t0, $s1, fim_for
        
        #carrega valor localizado no vetor
    	lw $t2, 0($t1)
    	
    	#prepara o print
        li $v0,1
        
        #carrega valor no registrador $a0
        move $a0, $t2
        
        #printa
        syscall
        
        #printa espaco em branco
        li $a0, 32
        li $v0, 11
        
        syscall
        
        #incrementa posicao do vetor
        addi $t1,$t1, 4
        j for
        
    fim_for:
        li $v0, 11
        li $a0, nline
        syscall
        jr $ra

troca:
    # salva o endereco de retorno
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    add $t0, $zero, $a1   # t0 tem o indice da primeira posicao
    lw $t1, ($t0)         # t1 tem o valor da primeira posicao
    add $t0, $zero, $a2   # t0 tem o indice da segunda posicao
    lw $t2, ($t0)         # t2 tem o valor da segunda posicao
    beq $t1, $t2, end_troca     # se os valores forem iguais, vai pro fim
    sw $t1, ($t0)         # salva o valor da primeira posicao na segunda
    add $t0, $zero, $a1   # t0 tem o indice da primeira posicao
    sw $t2, ($t0)         # salva o valor da segunda posicao na primeira
    j end_troca

    end_troca:
        # recupera o endereco de retorno
        lw $ra, 0($sp)
        addi $sp, $sp, 4
        jr $ra

zeraVetor:
    # salva o endereco de retorno
    addi $sp, $sp, -4
    sw $ra, 0($sp)


    for_loop:
        # compara o contador com o tamanho do vetor 
        bge $a0, $a1, exit_loop

        # zera o valor da posicao atual do vetor
        sw $zero, 0($a0)

        # vai pra pr?xima posicao do vetor
        addi $a0, $a0, 4

        # volta pro inicio do loop
        j for_loop

    exit_loop:
        # restaura o endereco de retorno em $ra
        lw $ra, 0($sp)
        addi $sp, $sp, 4

        # sai da funcao
        jr $ra

        


    
