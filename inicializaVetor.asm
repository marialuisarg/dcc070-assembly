.data
    vet: .word 0:100
    nline: .asciiz "\n"

.main:
    ## salva numero
    add $a1, 20, $zero

    #endereço de memoria do vetor
    la $a0, vet

    #ultimo valor
    li $a2, 5

    jal inicializaVetor
    li $t0, $a0

    li $v0, 10
    syscall

inicializaVetor:
    #caso trivial, tam =0
    bgt	$zero, $a1, end

    #prepara stack para 5 valores
    addi $sp, $sp -24
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)

    add $s0, $zero, $a0
    add $s1 ,$zero, $a1
    add $s2, $zero, $a2


    #bytes do vetor
    sll $s1, $s1, 2

    #tam - 1
    add $t0, $s1, -4

    move $a0, $s2
    li $a1, 47
    li $a2, 97
    li $a3, 337
    li $s4, 3

    #carrega quinto argumento
    sw $s4, 16($sp)

    jal valorAleatorio
    move $t2, $v0

    #salva valor aleatorio
    sw $s0, 0($t0)

    add $a0, $zero, $s0
    add $a1, $zero, $t0
    add $a2, $zero, $t2

    #salva novoValor
    add $s5, $s5, $t2
    sw $s5, 20($sp)

    jal inicializaVetor
end:
    li $a0, 0
    jr $ra

valorAleatorio:
		mult 	$a0, $a1        # a * b
		mflo 	$t0
		add 	$t1, $t0, $a2   # a * b + c
		div 	$t1, $a3        # (a * b + c) % d
		mfhi 	$t2
		sub 	$v1, $t2, $s4   # (a * b + c) % d - e
	
		jr      $ra             # retorna 
    
    