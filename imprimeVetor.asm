.data
    vet: .word 0,0,0
.text
    li $s0, 5
    li $s1, 6
    li $s2, 3

li $t0, 0

sw $s0, vet($t0)
    addi $t0, $t0, 4
sw $s1, vet($t0)
    addi $t0, $t0, 4
sw $s2, vet($t0)

la $a0, vet
li $a1, 3
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
    add $s1, $zero,$a1

    #vet
    lbu $s0, 0($t1)


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
        sw $a1, 0($t1)
        li $t1,110
        sw $a1, 1($t1)
        jal printf
        
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    addi $sp, $sp, 12
    jr $ra
        

