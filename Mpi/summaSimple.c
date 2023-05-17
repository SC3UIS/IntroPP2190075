// From https://www.programiz.com/c-programming/c-for-loop 
// Modified by C. Barrios for training purposes 2023
// Simple Program to calculate the sum of first n natural numbers
// Positive integers 1,2,3...n are known as natural numbers

#include <stdio.h>
#include <omp.h>

int main()
{
    int num = 1000000, count, sum = 0;
    double start, end;

    printf("Positive integer: %d", num);
    
    start = omp_get_wtime();

    // for loop terminates when num is less than count
    for(count = 1; count <= num; ++count)
    {
        sum += count;
    }
    
    end = omp_get_wtime();

    printf("\nSum = %d\n", sum);
    printf("El tiempo empleado es: %lf segundos\n", end - start);

    return 0;
}
