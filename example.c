/**
 * @file example.c
 * @brief Simple MPI example.
 */

#include <stdio.h>
#include <stdlib.h>
#include "zz_loeschen_mpi_c/arithmeticaloperation.h"

int main(void)
{
    printf("%d\n", add(2, 3));
    return EXIT_SUCCESS;
}
