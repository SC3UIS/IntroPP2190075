#include <stdio.h>
#include <math.h>
#include <mpi.h>

/* Define the function to be integrated here: */
double f(double x){
  return x*x;
}
/*Program begins*/
int main(int argc, char* argv[]) {
 int rank, size;
 int n= 1000000, i;
 double a=50, b=1000000, h, x, sum = 0, integral = 0;

 double local_sum = 0, local_integral = 0;
 double start_time, end_time;
 double sequential_time, parallel_time, acceleration;

 MPI_Init(&argc, &argv);

 MPI_Comm_rank(MPI_COMM_WORLD, &rank);
 MPI_Comm_size(MPI_COMM_WORLD, &size);

 MPI_Bcast(&n, 1, MPI_INT, 0, MPI_COMM_WORLD);
 MPI_Bcast(&a, 1, MPI_DOUBLE, 0, MPI_COMM_WORLD);
 MPI_Bcast(&b, 1, MPI_DOUBLE, 0, MPI_COMM_WORLD);

 start_time = MPI_Wtime();
 h = fabs(b - a) / n;
 int local_n = n / size;
 int start = rank * local_n + 1;
 int end = start + local_n;

 if (rank == size - 1) {
  end = n;
 }

 for (i = start; i < end; i++) {
 x = a + i * h;
  local_sum += f(x);
 }

 local_integral = (h / 2) * (f(a) + f(b) + 2 * local_sum);
 MPI_Reduce(&local_integral, &integral, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
 end_time = MPI_Wtime();

 if (rank == 0) {

  /* Print the answer */
  printf("\nThe integral is: %lf\n", integral);

  sequential_time = end_time - start_time;
  printf("Sequential Time: %lf seconds\n", sequential_time);

  parallel_time = sequential_time / size;
  printf("Parallel Time: %lf seconds\n", parallel_time);

  acceleration = sequential_time / parallel_time;
  printf("Acceleration: %lf\n", acceleration);
 }

 MPI_Finalize();
 return 0;
}
