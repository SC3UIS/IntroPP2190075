
#Carpeta openmp

***

Este programa imprime la suma de los números consecutivamente desde 1 hasta el valor num que en este caso es 10 y a su vez muestra
el valor en segundos del tiempo de reloj transcurrido.

* El archivo omp_summaSimple es el ejecutable del ejercicio omp_summaSimple.c
* El archivo omp_summaSimple.c contiene el ejercicio de suma simple realizado en c++ paralelizado haciendo uso 
  de la línea de código  #pragma omp parallel for reduction(+:sum) antes del for
* El archivo output_summaSimple.txt es la salida generada por el archivo summaSimple.sbatch
* El archivo summaSimple.c contiene el ejercicio de suma simple propuesto en el taller 1 realizado en c++ sin paralelizar
* El archivo summaSimple.sbatch contiene al archivo output_summaSimple.txt y es el encargado de correr el archivo omp_summasimple.c en guane
  mediante el comando:
  
  gcc -fopenmp omp_summaSimple.c -o omp_summaSimple (compila el archivo omp_summaSimple y el ejecutable lo nombra como omp_summaSimple)
 
  ./omp_summaSimple (Ejecuta el archivo omp_summaSimple)
  
 
  Para ejecutar el summaSimple.sbatch se utiliza el comando: sbatch summaSimple.sbatch
 
  Para mostrar lo ejecutado por el comando anterior se utiliza el comando: nano output_summaSimple.txt
  
