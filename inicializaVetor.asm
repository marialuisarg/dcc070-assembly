.data
    vet: .word 0:39
    nline: .asciiz "\n"
.text
.main:
    ## salva numero
    li $a1, 20

    #endereÃ§o de memoria do vetor
    la $a0, vet

    #ultimo valor
    li $a2, 5

    jal inicializaVetor
    #copia valores de retorno
    move $t0, $v0
    move $t1, $v1
    
    #soma retornos
    add $t3, $t1, $t0
    li $v0, 1
    add $a0, $t3, $zero
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
    
    #recupera endereço de retorno
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
    
    
