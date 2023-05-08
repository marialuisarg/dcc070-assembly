.data
    vet: .word 0:4
    nline: .asciiz "\n"
.text
    li $s0, 4
    li $s1, 8
    li $s2, 12
    li $s3, 16
    li $s4, 20

li $t0, 0

sw $s0, vet($t0)
    addi $t0, $t0, 4
sw $s1, vet($t0)
    addi $t0, $t0, 4
sw $s2, vet($t0)
    addi $t0, $t0, 4
sw $s3, vet($t0)
    addi $t0, $t0, 4
sw $s4, vet($t0)


la $a0, vet
li $a1, 5
jal imprimeVetor        


# receives a vector and it's size and prints it
imprimeVetor:
    # contador do for
    li $t0, 0
    
    #$t1 mantem o indice do vetor
    add $t1, $zero,$a0
    
    #tamanho do vetor em $s1
    add $s1, $zero,$a1
    
    # multiplica por 4 para a quantidade de bytes
    sll $s1,$s1, 2

    for:
    	#incrementa o indice
        addi $t0, $t0, 4
        
        #checa condicao de parada
        bgt $t0, $s1, fim_for
        
        #carrega valor localizado no vetor
    	lw $t2, 0($t1)
    	
    	#prepara o print
        li $v0,1
        
        #carrega valor no registrador $a0
        move $a0, $t2
        
        #printa
        syscall
        
        #printa espaco em branco
        li $a0, 32
        li $v0, 11
        
        syscall
        
        #incrementa posicao do vetor
        addi $t1,$t1, 4
        j for
        
    fim_for:
        li $v0, 4
        la $a0, nline
        syscall
        
        

