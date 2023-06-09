// From https://www.programiz.com/c-programming/c-for-loop 
// Modified by C. Barrios for training purposes 2023
// Simple Program to calculate the sum of first n natural numbers
// Positive integers 1,2,3...n are known as natural numbers

#include <stdio.h>
int main()
{
    int num = 10, count, sum = 0;

    printf("Positive integer: %d", num);

    // for loop terminates when num is less than count
    for(count = 1; count <= num; ++count)
    {
        sum += count;
    }

    printf("\nSum = %d\n", sum);

    return 0;
}
