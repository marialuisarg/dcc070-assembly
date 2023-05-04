
        
li $a1 10
li $a0 vet($zero)
jal imprimeVetor        


printf:


# receives a vector and it's size and prints it
imprimeVetor:
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)

    li $t0, 0
    
    add $t1, $zero,$a0
    add $t2, $zero,$a1

    #vet
    lb $s0, 0($t1)

    #tam
    lb $s1, 0($t2)

    # copia vetor para $a1
    move $a1, $s0

    for:
        # recalcula posição do vetor
        add $t3, $t1, $t0
        # Loading %d on $a0
        # %
        li $t3, 37
        sb $a0, 0($t3)
        # d
        li $t3, 100
        sb $a0, 1($t3)

        jal printf
        addi $t0, $t0, 1
        bgt $t0, $s1, fim_for
        j for
        
    fim_for:
        li $t1,92
        sb $a1, 0($t1)
        li $t1,110
        sb $a1, 1($t1)
        jal printf
        

