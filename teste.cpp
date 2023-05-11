#include <iostream>

int main()
{
    int a[5] = {4, 8, 12, 16, 20};

    imprimeVetor(5, a);

    return 0;
}

void imprimeVetor(int n, int *v)
{
    int i;
    for (i = 0; i < n; i++)
    {
        printf("%d ", v[i]);
    }
    printf("\n");
    return;
}

void troca(int *a0, int a1, int a2)
{
    // multiplica por 4 pra chegar no numero de bytes
    a1 = a1 << 2;
    a2 = a2 << 2;

    int *t0 = a0 + a1; // soma o indice da primeira posicao
    int t1 = *t0;      // t1 tem o valor da primeira posicao
    t0 = a0 + a2;      // soma o indice da segunda posicao
    int t2 = *t0;      // t2 tem o valor da segunda posicao
    t0 = a0 + a1;      // soma o indice da primeira posicao
    *t0 = t2;          // salva o valor da segunda posicao na primeira
    t0 = a0 + a2;      // soma o indice da segunda posicao
    *t0 = t1;          // salva o valor da primeira posicao na segunda

    // retorna
    return;
}