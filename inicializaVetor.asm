.data
    vet: .word 0:100
    nline: .asciiz "\n"
    msg: .asciiz "Digite um numero: "

main:
    ## imprime mensagem
    li $v0, 4
    la $a0, msg
    syscall
    ## le numero
    li $v0, 5
    syscall

    ## salva numero
    add $a1, $v0, $zero

    #endereço de memoria do vetor
    la $a0, vet

    #ultimo valor
    li $a2, 4

    jal inicializaVetor

inicializaVetor:
    #prepara stack para 4 valores
    addi $sp, $sp -16
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

    

    li $t1, 0

end:
    li $a0, 0
    jr $ra
    
    