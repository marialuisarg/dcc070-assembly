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

# salva os argumentos da funcao
la $a0, vet
li $a1, 5

# chama a funcao
jal zeraVetor

# saida do programa (syscall 10)
li $v0, 10
syscall

zeraVetor:
    # salva o endereco de retorno
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    # contador
    li $t0, 0

    # indice do vetor em $s0
    add $s0, $zero, $a0

    # tamanho do vetor em $s1
    add $s1, $zero, $a1

    # multiplica por 4 pra chegar no numero de bytes
    sll $s1, $s1, 2


    for_loop:
        # compara o contador com o tamanho do vetor 
        bge $t0, $s1, exit_loop

        # zera o valor da posicao atual do vetor
        sw $zero, 0($a0)

        # vai pra pr?xima posicao do vetor
        addi $a0, $a0, 4

        # incrementa o contador
        addi $t0, $t0, 4

        # volta pro inicio do loop
        j for_loop

    exit_loop:
        # restaura o endereco de retorno em $ra
        lw $ra, 0($sp)
        addi $sp, $sp, 4

        # sai da funcao
        jr $ra