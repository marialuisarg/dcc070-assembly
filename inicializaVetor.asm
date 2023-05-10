.data
    vet: .word 0:100
    nline: .asciiz "\n"

main:
    ## salva numero
    add $a1, 20, $zero

    #endereço de memoria do vetor
    la $a0, vet

    #ultimo valor
    li $a2, 4

    jal inicializaVetor

inicializaVetor:
    #prepara stack para 5 valores
    addi $sp, $sp -36
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)

    add $s0, $zero, $a0
    add $s1 ,$zero, $a1
    add $s2, $zero, $a2
    
    #bytes do vetor
    sll $s1, $s1, 2

    bgt	$zero, $a1, end

    #tam - 1
    add $t0, $s1, -1

    li $s3, 47
    li $s4, 97
    li $s5, 337
    li $s6, 3

    sw $s3, 16($sp)
    sw $s4, 20($sp)
    sw $s5, 24($sp)
    sw $s6, 28($sp)

    jal valorAleatorio

    li $t1, 0

end:
    li $a0, 0
    jr $ra
    
    