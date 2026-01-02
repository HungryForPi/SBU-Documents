#include <stdio.h>
#include <stdlib.h>

int *g (void) {
    int *px = malloc(sizeof(int));
    *px = 10;
    return px;
}

int main(void){
    int *px = g();
    printf("%p\n", px);
    printf("%d\n", *px);
}

