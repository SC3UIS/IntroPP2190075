#include <stdio.h>
#include <math.h>
#include <cuda.h>
#include <time.h>


__host__ __device__ double f(double x){
  return x*x;
}

__device__ double atomicAddDouble(double* address, double val) {
  unsigned long long int* address_as_ull = (unsigned long long int*)address;
  unsigned long long int old = *address_as_ull, assumed;
  do {
    assumed = old;
    old = atomicCAS(address_as_ull, assumed,
                    __double_as_longlong(val + __longlong_as_double(assumed)));
  } while (assumed != old);
  return __longlong_as_double(old);
}

__global__ void integrate(double a, double b, int n, double h, double *d_integral) {
  int i;
  double x, sum = 0.0;
  int idx = threadIdx.x + blockIdx.x * blockDim.x;
  int stride = blockDim.x * gridDim.x;
  
  for (i = idx + 1; i < n; i += stride) {
    x = a + i * h;
    sum += f(x);
  }
  
  sum *= 2.0;
  
  atomicAddDouble(d_integral, sum);
}

double trapezoidalMethod(double a, double b, int n, double h) {
    int i;
    double x, sum = 0;

    for (i = 1; i < n; i++) {
        x = a + i * h;
        sum += f(x);
    }

    return (h / 2) * (f(a) + f(b) + 2 * sum);
}

int main() {
    int n = 1000000, blockSize, numBlocks;;
    double a = 50, b = 1000000, h, integral;
    double *d_integral;
    double *dev_integral;

    h = fabs(b - a) / n;
    
    clock_t start_s = clock();

    integral = trapezoidalMethod(a, b, n, h);

    clock_t end_s = clock();

    blockSize = 256;
    numBlocks = (n + blockSize - 1) / blockSize;
  
    d_integral = (double*)malloc(sizeof(double));
    cudaMalloc((void**)&dev_integral, sizeof(double));
  
    *d_integral = 0.0;
    cudaMemcpy(dev_integral, d_integral, sizeof(double), cudaMemcpyHostToDevice);

    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start);

    integrate<<<numBlocks, blockSize>>>(a, b, n, h, dev_integral);
    cudaDeviceSynchronize();

    cudaEventRecord(stop);
    cudaEventSynchronize(stop);

    cudaMemcpy(d_integral, dev_integral, sizeof(double), cudaMemcpyDeviceToHost);
  
    integral = (h / 2) * (f(a) + f(b) + *d_integral);

    float parallel_time = 0;
    int numThreads = numBlocks * blockSize;
    double sequential_time = (double)(end_s - start_s) / CLOCKS_PER_SEC;


    cudaEventElapsedTime(&parallel_time, start, stop);
    double speedup = sequential_time / parallel_time;
    double scalability = speedup / numThreads;

    printf("\nEl valor de la integral es: %lf\n", integral);
    printf("Tiempo de ejecución en paralelo: %lf segundos\n", parallel_time/1000);
    printf("Tiempo de ejecución secuencial: %lf segundos\n", sequential_time);
    printf("Speedup: %lf\n", speedup);
    printf("Escalabilidad: %lf\n", scalability);

    cudaFree(d_integral);
    cudaFree(dev_integral);

    return 0;
}
