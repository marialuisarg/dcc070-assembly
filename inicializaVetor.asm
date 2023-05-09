.data
    vet: .word 0:100
    nline: .asciiz "\n"

main:
    #endereço de memoria do vetor
    la $a0, vet

    #tamanho do vetor
    li $a1, 40

    #ultimo valor
    li $a2, 4

    jal inicializaVetor

inicializaVetor:
    addi $sp, $sp -8
    sw $ra, 0($sp)
    sw $s0, 4($sp)

    #i = 0
    li $t0, 0

    bgt	$zero, $a1, end
    

end:
    li $a0, 0
    jr $ra
    
    