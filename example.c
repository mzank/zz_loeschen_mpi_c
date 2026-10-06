/**
 * @file example.c
 * @brief Simple MPI example.
 */

#include <stdio.h>
#include <stdlib.h>

/**
 * @brief Adds two integers.
 *
 * @param a First integer.
 * @param b Second integer.
 * @return The sum of a and b.
 */
int add(int a, int b)
{
    return a + b;
}

int main(void)
{
    printf("%d\n", add(2, 3));
    return 0;
}
