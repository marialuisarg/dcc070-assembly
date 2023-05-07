.data
    vet: .word 0:3
.text
    li $s0, 4
    li $s1, 8
    li $s2, 12

li $t0, 0

sw $s0, vet($t0)
    addi $t0, $t0, 4
sw $s1, vet($t0)
    addi $t0, $t0, 4
sw $s2, vet($t0)

la $a0, vet
li $a1, 3
jal imprimeVetor        


# receives a vector and it's size and prints it
imprimeVetor:
    # indice do for
    li $t0, 0
    
    add $t1, $zero,$a0
    add $s1, $zero,$a1
	
    #vet
    lw $s0, 0($a0)

    for:
        # recalcula posição do vetor
        add $t3, $t1, $t0
  
        sw $t3, 1($a0)
        addi $v0, $zero, 1
        addi $t0, $t0, 4
        li $v0,1
        syscall
        bgt $t0, $s1, fim_for
        j for
        
    fim_for:
        li $t1,92
        sw $a1, 0($t1)
        li $t1,110
        sw $a1, 1($t1)

        
    jr $ra
        

