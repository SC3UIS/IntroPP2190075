
#Carpeta mpi

***

Este programa imprime la suma de los números consecutivamente desde 1 hasta el valor num que en este caso es 1000000 y a su vez muestra
el valor en segundos del tiempo de reloj transcurrido.

Se agregó el módulo de intel (mpidevtools/intel/oneAPI) para realizar las pruebas del código paralelizado en mpi 

* El archivo omp_summaSimple.c contiene el ejercicio de suma simple realizado en c++ paralelizado haciendo uso 
  de la línea de código  #pragma omp parallel for reduction(+:sum) antes del for
  
* El archivo omp_summaSimple es el ejecutable de omp_summaSimple.c (para ejecutar omp_summaSimple se hace uso del comando
  gcc -fopenmp omp_summaSimple.c -o omp_summaSimple
  ./omp_summaSimple)
      
* El archivo output_summaSimple.txt es la salida generada por el archivo summaSimple.sbatch

* El archivo mpi_summaSimple.c contiene el ejercicio paralelizado mediante mpi cada proceso MPI calcula una parte del sumatorio utilizando 
  la variable local_sum. Luego, utilizamos la función MPI_Reduce para sumar todas las local_sum en la variable total_sum del proceso 0.
  
* El archivo mpi_summaSimple es el ejecutable de mpi_summaSimple.c (para ejecutar mpi_summaSimple se hace uso del comando
  mpicxx mpi_summaSimple.c -o mpi_summaSimple
  mpiexec -np 12 ./summaSimple)  
       
* El archivo summaSimple.c contiene el ejercicio de suma simple propuesto en el taller 1 realizado en c++ sin paralelizar

* El archivo summaSimple es el ejecutable de summaSimple.c (para ejecutar summaSimple se hace uso del comando
  gcc -fopenmp summaSimple.c -o summaSimple 
  ./summaSimple)
  
* El archivo summaSimple.sbatch contiene al archivo output_summaSimple.txt y es el encargado de correr el archivo mpi_summasimple.c en guane1.

En conclusión, al hacer la comparación entre los 3 casos que son: el código sin paralelizar, paralelizado con openmp y paralelizado con mpi, se pudo 
observar que el menor tiempo de ejecución se da con openmp para una sola tarea, pero el que mejor rinde para una mayor cantidad de tareas es el 
código paralelizado con mpi, ya que se ejecuta en un tiempo mayor a comparación de los otros debido a que realiza más procesos a la vez. 

Por lo tanto, si se desea paralelizar un código y solo hacerlo para una tarea la mejor elección sería paralelizarlo con openmp, en cambio
si se desean ejecutar una mayor cantidad de procesos es más conveniente realizar la paralelización mediante mpi.  
  
