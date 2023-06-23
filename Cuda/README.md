
#Carpeta CUDA

***

Este programa imprime la suma de los números consecutivamente desde 1 hasta el valor num que en este caso es 1000000 y a su vez muestra
el valor en segundos del tiempo de reloj transcurrido.

Se agregó el módulo de CUDA (devtools/cuda/8.0) para realizar las pruebas del código paralelizado en CUDA 

* El archivo cu_summaSimple.cu contiene el ejercicio de suma simple realizado en c++ paralelizado con CUDA
  
* El archivo cu_summaSimple.cu es el ejecutable de cu_summaSimple.cu (para ejecutar cu_summaSimple.cu se debe pedir un nodo en guane haciendo
  uso de la línea de comando: srun --pty /bin/bash
  y luego hacer uso de los comandos
  nvcc cu_summaSimple.cu -o cu_summaSimple
  ./cu_summaSimple)
      
* El archivo output_summaSimple.txt es la salida generada por el archivo summaSimple.sbatch

* El archivo mpi_summaSimple.c contiene el ejercicio paralelizado mediante mpi cada proceso MPI calcula una parte del sumatorio utilizando 
  la variable local_sum. Luego, utilizamos la función MPI_Reduce para sumar todas las local_sum en la variable total_sum del proceso 0.
  
* El archivo mpi_summaSimple es el ejecutable de mpi_summaSimple.c (para ejecutar mpi_summaSimple se hace uso del comando
  mpicxx mpi_summaSimple.c -o mpi_summaSimple
  mpiexec -np 12 ./mpi_summaSimple)  
       
* El archivo summaSimple.c contiene el ejercicio de suma simple propuesto en el taller 1 realizado en c++ sin paralelizar

* El archivo summaSimple es el ejecutable de summaSimple.c (para ejecutar summaSimple se hace uso del comando
  gcc -fopenmp summaSimple.c -o summaSimple 
  ./summaSimple)
  
* El archivo summaSimple.sbatch contiene al archivo output_summaSimple.txt y es el encargado de correr el archivo cu_summasimple.cu en guane1.

En conclusión, la elección de la herramienta que ofrece el mejor rendimiento entre OpenMP, MPI y CUDA depende del contexto y los requisitos específicos de la aplicación, esto debido
a que OpenMP es particularmente eficiente para paralelizar bucles y tareas que se pueden dividir en secciones independientes. Sin embargo, el rendimiento de OpenMP puede verse 
limitado por la capacidad de memoria y el número de núcleos disponibles en la máquina.

Mientras que MPI Proporciona una gran escalabilidad y rendimiento en sistemas con grandes cantidades de recursos computacionales distribuidos. Sin embargo, el uso de MPI 
puede requerir un mayor esfuerzo de programación para gestionar la comunicación explícita entre los procesos paralelos.

Y en el caso de CUDA se pudo observar que la aceleración en la ejecución del cálculo de la suma fue de 0.2 segundos, esto debido a que CUDA ofrece un rendimiento excepcional en aplicaciones 
que se pueden acelerar en GPUs por lo cual es especialmente adecuado para aplicaciones que realizan operaciones matemáticas o manipulaciones de datos a gran escala. Sin embargo, CUDA requiere 
una comprensión y optimización específica de la arquitectura de la GPU y su rendimiento puede verse limitado si los datos no se pueden adaptar eficientemente
al modelo de procesamiento masivo paralelo.
