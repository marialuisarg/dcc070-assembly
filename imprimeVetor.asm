.data
    vet: .word 0:2
    nline: .asciiz "\n"
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
    sll $s1,$s1, 2
    #vet
    lw $s0, 0($t1)

    for:
        addi $t0, $t0, 4
        bgt $t0, $s1, fim_for
    	lw $t2, 0($t1)
        li $v0,1
        move $a0, $t2
        syscall
        addi $t1,$t1, 4
        j for
        
    fim_for:
        li $v0, 4
        la $a0, nline
        syscall
        
        

