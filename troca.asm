.data
    # vetor de 5 posicoes
    vet: .word 0:4
    nline: .asciiz "\n"
.text
    # inicializa os valores que serao salvos no vetor
    li $s0, 4
    li $s1, 8
    li $s2, 12
    li $s3, 16
    li $s4, 20

# salva os valores no vetor
sw $s0, vet($t0)
    addi $t0, $t0, 4
sw $s1, vet($t0)
    addi $t0, $t0, 4
sw $s2, vet($t0)
    addi $t0, $t0, 4
sw $s3, vet($t0)
    addi $t0, $t0, 4
sw $s4, vet($t0)

addi $t0, $zero, 5
sll $t0, $t0, 2

la $a0, vet
add $a1, $a0, $t0
jal zeraVetor

# saida do programa (syscall 10)
li $v0, 10
syscall

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