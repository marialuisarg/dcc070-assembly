.data
    # vetor de 5 caracteres
    vet: .word 0:4

.text
    # inicializa os valores do vetor
    li $s0, 4
    li $s1, 8
    li $s2, 12
    li $s3, 16
    li $s4, 20

# salva o endereço do vetor
add $t0, $t0, $zero

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
la $a0, vet # endereco do vetor
li $a1, 5 # tamanho
li $a2, 1 # primeira posicao
li $a3, 2 # segunda posicao

jal troca

li $v0, 10
syscall

troca:
    # salva o endereco de retorno
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    sll $a2, $a2, 2
    sll $a3, $a3, 2

    # contador
    $li $t0, -4

    # indice do vetor em $s0
    add $a0, $zero, $a0

    # multiplica por 4 pra chegar no numero de bytes
    sll $s1, $s1, 2

    for_loop:
        addi $t0, $t0, 4

        li $t2, $zero

        slt $t1, $t0, $s1
        beq $t1, $zero, exit_loop

        beq $t0, $a1, store_value
        beq $t0, $a2, store_value

        beq $t2, $zero, for_loop

        jal troca_valor

        store_value:
            li $t2, 1

        troca_valor:
            lw $t5, ($a0)
            add $t5, $t5, $a2
            lw $t4, ($t5)
            lw $t5, ($a0)
            add $t5, $t5, $a3
            lw $t3, ($t5)
            sw $t4, ($t5)
            sw $t3, ($t5)


