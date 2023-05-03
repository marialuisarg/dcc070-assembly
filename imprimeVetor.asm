printf:



imprimeVetor:
    addi $sp, $sp, -16
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)
    sw $s2, 12($sp)

    li $t0, 0
    
    add $t1, $zero,$a0
    add $t2, $zero,$a1

    #vet
    lb $s0, 0($t1)

    #tam
    lb $s1, 0($t2)

    for:
        li $t3, 37
        sb $a1, 0($t3)
        li $t3, 100
        sb $a1, 1($t3)
        jal printf
        addi $t1, $t1, 1
        bgt $t1, $s1, fim_for
        j for
        
    fim_for:
        li $t1,92
        sb $a1, 0($t1)
        li $t1,110
        sb $a1, 1($t1)
        jal printf
        

