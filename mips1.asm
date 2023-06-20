# Segmento de dados globais
.data
    msgSoma:    .asciiz    "Soma: "

# Segmento de texto (instru��es do programa)
.text
main:
    # Aloca espa�o na pilha
    addi    $sp, $sp, -80   # 80 bytes para um vetor de 20 inteiros
    
    # Inicializa vari�veis locais
    move    $s0, $sp        # vet aponta para o in�cio do vetor na pilha
    li      $s1, 0          # soma = 0
    
    # Chama a fun��o inicializaVetor
    move    $a0, $s0        # Primeiro par�metro: vet
    li      $a1, 20         # Segundo par�metro: SIZE
    li      $a2, 71         # Terceiro par�metro: 71
    jal     inicializaVetor # Chama a fun��o inicializaVetor
    move    $s1, $v0        # Guarda o retorno da fun��o em soma
    
    # Chama a fun��o imprimeVetor
    move    $a0, $s0        # Primeiro par�metro: vet
    li      $a1, 20         # Segundo par�metro: SIZE
    jal     imprimeVetor    # Chama a fun��o imprimeVetor
    
    # Chama a fun��o ordenaVetor
    move    $a0, $s0        # Primeiro par�metro: vet
    li      $a1, 20         # Segundo par�metro: SIZE
    jal     ordenaVetor     # Chama a fun��o ordenaVetor
    
    # Chama a fun��o imprimeVetor
    move    $a0, $s0        # Primeiro par�metro: vet
    li      $a1, 20         # Segundo par�metro: SIZE
    jal     imprimeVetor    # Chama a fun��o imprimeVetor
    
    # Chama a fun��o zeraVetor
    move    $a0, $s0        # Primeiro par�metro: &vet[0]
    addi    $a1, $s0, 80    # Segundo par�metro: &vet[20]
    jal     zeraVetor       # Chama a fun��o zeraVetor
    
    # Chama a fun��o imprimeVetor
    move    $a0, $s0        # Primeiro par�metro: vet
    li      $a1, 20         # Segundo par�metro: SIZE
    jal     imprimeVetor    # Chama a fun��o imprimeVetor
    
    # Impress�o em tela: printf("Soma: %d\n", soma);
    li      $v0, 4          # C�digo 4 para impress�o de string
    la      $a0, msgSoma    # Primeiro par�metro: endere�o da string "Soma: "
    syscall
    li      $v0, 1          # C�digo 1 para impress�o de inteiro
    move    $a0, $s1        # Primeiro par�metro: soma ($s1)
    syscall
    li      $v0, 11         # C�digo 11 para impress�o de caractere
    li      $a0, 10         # Primeiro par�metro: \n (ASCII)
    syscall
    
    # Libera espa�o na pilha
    addi    $sp, $sp, 80    # Libera os 80 bytes alocados pela fun��o

    # Fim do programa
    li      $v0, 17         # C�digo 17 para exit com valor de retorno
    li      $a0, 0          # Primeiro par�metro: valor de retorno 0
    syscall 


zeraVetor:
    # Esta fun��o � folha
    # O primeiro par�metro � o ponteiro para o in�cio do vetor
    # O segundo par�metro � ponteiro para o fim do vetor
    
    zeraLoop:
        bge    $a0, $a1, zeraFim    # Se inicio >= fim vai para zeraFim
        sw      $zero, 0($a0)       # Salva valor 0 no endere�o apontado por inicio
        addi    $a0, $a0, 4         # Incrementa inicio para a pr�xima posi��o
        j       zeraLoop            # Repete o la�o
    
    zeraFim:

    # Fim da fun��o    
    jr      $ra             # Retorna
    

imprimeVetor:
    # Esta fun��o n�o � folha
    # O primeiro par�metro � o ponteiro para o in�cio do vetor
    # O segundo par�metro � o tamanho do vetor
    
    # Aloca espa�o na pilha
    addi    $sp, $sp, -16   # 16 bytes para $ra, $s0, $s1, $s2
    sw      $ra, 0($sp)     # Salva $ra na pilha
    sw      $s0, 4($sp)     # Salva $s0 na pilha
    sw      $s1, 8($sp)     # Salva $s1 na pilha
    sw      $s2, 12($sp)    # Salva $s2 na pilha
    
    # Inicializa vari�veis
    move    $s0, $a0        # Par�metro vet salvo em $s0
    move    $s1, $a1        # Par�metro tam salvo em $s1
    li      $s2, 0          # Vari�vel i = 0 em $s2
    
    imprimeLoop:
        beq     $s2, $s1, imprimeFim    # Se i == tam vai para imprimeFim
        sll     $t0, $s2, 2         # $t0 = i * 4
        add     $t0, $s0, $t0       # $t0 = &vet[i]
        
        li      $v0, 1              # C�digo 1 para impress�o de inteiro
        lw      $a0, 0($t0)         # Primeiro par�metro: vet[i]
        syscall
    
        li      $v0, 11             # C�digo 11 para impress�o de caractere
        li      $a0, 32             # Primeiro par�metro: " " (espa�o)
        syscall
    
        addi    $s2, $s2, 1         # Incremento i++
        j       imprimeLoop         # Repete o la�o
                
    imprimeFim:
    li      $v0, 11         # C�digo 11 para impress�o de caractere
    li      $a0, 10         # Primeiro par�metro: \n
    syscall
    
    # Libera espa�o na pilha
    lw      $ra, 0($sp)     # Recupera $ra da pilha
    lw      $s0, 4($sp)     # Recupera $s0 da pilha
    lw      $s1, 8($sp)     # Recupera $s1 da pilha
    lw      $s2, 12($sp)    # Recupera $s2 da pilha
    addi    $sp, $sp, 16    # Libera os 16 bytes alocados pela fun��o
    
    # Fim da fun��o
    jr      $ra             # Retorna
    

inicializaVetor:
    # Esta fun��o n�o � folha
    # O primeiro par�metro � o ponteiro para o in�cio do vetor
    # O segundo par�metro � o tamanho do vetor
    # O terceiro par�metro � o �ltimo valor aleat�rio utilizado na inicializa��o

    # Aloca espa�o na pilha
    addi    $sp, $sp, -20   # 20 bytes para $ra, $s0, $s1, $s2 e $s3
    sw      $ra, 0($sp)     # Salva $ra na pilha
    sw      $s0, 4($sp)     # Salva $s0 na pilha
    sw      $s1, 8($sp)     # Salva $s1 na pilha
    sw      $s2, 12($sp)    # Salva $s2 na pilha
    sw      $s3, 16($sp)    # Salva $s3 na pilha

    # Inicializa vari�veis
    move    $s0, $a0        # Par�metro vet salvo em $s0
    move    $s1, $a1        # Par�metro tamanho salvo em $s1
    move    $s2, $a2        # Par�metro ultimoValor salvo em $s2
    li      $s3, 0          # novoValor = 0

    # Caso base da recurs�o
    move    $v0, $zero      # Prepara valor de retorno 0
    ble     $s1, $zero, inicializaFim   # Se tamanho <= 0 vai para inicializaFim
    
    # Passo recursivo
    # Chama a fun��o valorAleatorio
    move    $a0, $s2        # Primeiro par�metro: ultimoValor
    li      $a1, 47         # Segundo par�metro: 47    
    li      $a2, 97         # Terceir par�metro: 97
    li      $a3, 337        # Quarto par�metro: 337
    
    addi    $sp, $sp, -4    # Aloca 4 bytes na pilha para o quinto par�metro
    li      $t0, 3          # $t0 = 3
    sw      $t0, 0($sp)     # Quinto par�metro: 3    
    jal     valorAleatorio
    addi    $sp, $sp, 4     # Libera 4 bytes na pilha do quinto par�metro
    
    move    $s3, $v0        # novoValor = $v0 (retorno da fun��o valorAleatorio)
    
    addi    $t0, $s1, -1    # $t0 = tamanho - 1
    sll     $t0, $t0, 2     # $t0 = (tamanho - 1) * 4
    add     $t0, $s0, $t0   # $t0 = &vet[tamanho - 1]
    sw      $s3, 0($t0)     # vet[tamanho - 1] = novoValor
    
    # Chama recursivamente a fun��o inicializaVetor
    move    $a0, $s0        # Primeiro par�metro: vet
    addi    $a1, $s1, -1    # Segundo par�metro: tamanho - 1
    move    $a2, $s3        # Terceiro par�metro: novoValor
    jal     inicializaVetor
    
    # Prepara valor de retorno
    add     $v0, $v0, $s3   # Prepara valor de retorno novoValor + retorno da recurs�o 

    inicializaFim:
    # Libera espa�o na pilha
    lw      $ra, 0($sp)     # Recupera $ra da pilha
    lw      $s0, 4($sp)     # Recupera $s0 da pilha
    lw      $s1, 8($sp)     # Recupera $s1 da pilha
    lw      $s2, 12($sp)    # Recupera $s2 da pilha
    lw      $s3, 16($sp)    # Recupera $s3 da pilha
    addi    $sp, $sp, 20    # Libera os 20 bytes alocados pela fun��o
    
    # Fim da fun��o
    jr      $ra             # Retorna
    

ordenaVetor:
    # Esta fun��o n�o � folha
    # O primeiro par�metro � o ponteiro para o in�cio do vetor
    # O segundo par�metro � o tamanho do vetor

    # Aloca espa�o na pilha
    addi    $sp, $sp, -24   # 24 bytes para $ra, $s0, $s1, $s2, $s3 e $s4
    sw      $ra, 0($sp)     # Salva $ra na pilha
    sw      $s0, 4($sp)     # Salva $s0 na pilha
    sw      $s1, 8($sp)     # Salva $s1 na pilha
    sw      $s2, 12($sp)    # Salva $s2 na pilha
    sw      $s3, 16($sp)    # Salva $s3 na pilha
    sw      $s4, 20($sp)    # Salva $s4 na pilha

    # Inicializa vari�veis
    move    $s0, $a0        # Par�metro vet salvo em $s0
    move    $s1, $a1        # Par�metro n salvo em $s1
    li      $s2, 0          # i = 0
    li      $s3, 0          # j = 0
    li      $s4, 0          # min_idx = 0
    
    # La�o externo
    li      $s2, 0          # i = 0
    ordenaFor1:
        addi    $t0, $s1, -1            # $t0 = n - 1
        bge     $s2, $t0, ordenaFim1    # Se i >= n - 1 vai para ordenaFim1
        move    $s4, $s2                # min_idx = i
    
        # La�o interno
        addi    $s3, $s2, 1             # j = i + 1
        ordenaFor2:
            bge     $s3, $s1, ordenaFim2    # Se j >= n vai para ordenaFim2
                    
            # Condicional dentro do lan�o interno
            # Leitura do valor de vet[j]
            sll     $t0, $s3, 2             # $t0 = j * 4
            add     $t0, $s0, $t0           # $t0 = &vet[j]
            lw      $t0, 0($t0)             # $t0 = vet[j]

            # Leitura do valor de vet[min_idx]
            sll     $t1, $s4, 2             # $t1 = min_idx * 4
            add     $t1, $s0, $t1           # $t1 = &vet[min_idx]
            lw      $t1, 0($t1)             # $t1 = vet[min_idx]
            
            bge     $t0, $t1, sortIf1Fim    # Se vet[j] >= vet[min_idx] vai para sortIf1Fim
            move    $s4, $s3                # min_idx = j                        
            
            sortIf1Fim:
            addi    $s3, $s3, 1             # j++
            j       ordenaFor2              # Repete o la�o interno
        
        ordenaFim2:
        # Condicional ap�s o la�o interno
        beq     $s4, $s2, ordenaIfFim       # Se min_idx == i vai para ordenaIfFim
        
        # Chama fun��o troca
        sll     $t0, $s4, 2             # $t0 = min_idx * 4
        add     $a0, $s0, $t0           # Primeiro par�metro: &vet[min_idx]
        sll     $t0, $s2, 2             # $t0 = i * 4
        add     $a1, $s0, $t0           # Segundo par�metro: &vet[i]
        jal     troca
        
        ordenaIfFim:
        addi    $s2, $s2, 1             # i++
        j       ordenaFor1              # Repete o la�o externo
    
    ordenaFim1:
    # Libera espa�o na pilha
    lw      $ra, 0($sp)     # Recupera $ra da pilha
    lw      $s0, 4($sp)     # Recupera $s0 da pilha
    lw      $s1, 8($sp)     # Recupera $s1 da pilha
    lw      $s2, 12($sp)    # Recupera $s2 da pilha
    lw      $s3, 16($sp)    # Recupera $s3 da pilha
    lw      $s4, 20($sp)    # Recupera $s4 da pilha
    addi    $sp, $sp, 24    # Libera os 24 bytes alocados pela fun��o
    
    # Fim da fun��o
    jr      $ra             # Retorna
                  
troca:
    # Esta fun��o � folha
    # O primeiro par�metro � o ponteiro para a posi��o a no vetor
    # O segundo par�metro � o ponteiro para a posi��o b no vetor
    
    # Teste da condicional
    beq     $a0, $a1, trocaFim  # Se a == b vai para trocaFim
    
    # Troca de valores
    lw      $t0, 0($a0)     # $t0 = *a
    lw      $t1, 0($a1)     # $t1 = *b
    sw      $t1, 0($a0)     # *a = $t1
    sw      $t0, 0($a1)     # *b = $t0
    
    trocaFim:
    # Fim da fun��o
    jr      $ra             # Retorna
                      
                                                                                                                                                                                                                                                          
valorAleatorio:
    # Esta fun��o � folha
    # Os quatro primeiros par�metros est�o nos registradores $a0 -- $a3
    # O quinto par�metro est� na pilha
    
    # Recupera o quinto par�metro (e) da pilha
    lw      $t0, 0($sp)    # $t0 = e
    
    # Calcula o valor de retorno
    mul     $v0, $a0, $a1   # $v0 = a * b
    add     $v0, $v0, $a2   # $v0 = a * b + c
    div     $v0, $a3        # hi = (a * b + c) % d
    mfhi    $v0             # $v0 = hi
    sub     $v0, $v0, $t0   # $v0 = (a * b + c) % d - e
        
    # Fim da fun��o
    jr      $ra             # Retorna


