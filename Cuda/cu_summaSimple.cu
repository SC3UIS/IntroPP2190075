#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <cuda.h>

#define BLOCK_SIZE 256

// Función para obtener el tiempo de pared (wall time) en segundos
double get_wall_time() {
    struct timeval time;
    if (gettimeofday(&time, NULL)) {
   	 return 0;
    }
    return (double)time.tv_sec + (double)time.tv_usec * .000001;
}

// Kernel CUDA para calcular la suma de los números enteros
__global__ void calculateSum(int num, int* total_sum) {
    int tid = threadIdx.x + blockIdx.x * blockDim.x;
    int stride = gridDim.x * blockDim.x;

	int local_sum = 0;
    for (int count = tid + 1; count <= num; count += stride) {
         local_sum += count;
    }

	atomicAdd(total_sum, local_sum);
}

int main() {
    int num = 1000000, total_sum;
    double start_time, end_time;
    double sequential_time, parallel_time, acceleration;
    start_time = get_wall_time(); // Iniciar el temporizador

	int num_blocks = (num + BLOCK_SIZE - 1) / BLOCK_SIZE; // Calcular el número de bloques necesarios
	int* d_total_sum; // Puntero al total_sum en el dispositivo CUDA
	
	// Asignar memoria en el dispositivo para el total_sum
	cudaMalloc((void**)&d_total_sum, sizeof(int));
	// Copiar el valor de total_sum desde el host al dispositivo
	cudaMemcpy(d_total_sum, &total_sum, sizeof(int), cudaMemcpyHostToDevice);
    
    // Lanzar el kernel para calcular la suma en paralelo
	calculateSum<<<num_blocks, BLOCK_SIZE>>>(num, d_total_sum);
	
	// Copiar el resultado de total_sum desde el dispositivo al host
	cudaMemcpy(&total_sum, d_total_sum, sizeof(int), cudaMemcpyDeviceToHost);
	
	// Liberar la memoria asignada en el dispositivo
	cudaFree(d_total_sum);

	end_time = get_wall_time(); // Detener el temporizador
	
	printf("Positive integer: %d\n", num);
	printf("Sum = %d\n", total_sum);

	sequential_time = end_time - start_time;
	printf("Sequential Time: %lf seconds\n", sequential_time);
	parallel_time = sequential_time;
	printf("Parallel Time: %lf seconds\n", parallel_time);
	acceleration = sequential_time / parallel_time;
	printf("Acceleration: %lf\n", acceleration);

	return 0;	
}
