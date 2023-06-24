#include<stdio.h>
#include<math.h>
#include<omp.h>

/* Define the function to be integrated here: */
double f(double x){
  return x*x;
}
/*Program begins*/
int main(){
 int n=1000000,i;
 double a=50,b=1000000,h,x,sum=0,integral;
 double start_time, end_time;
 /*Ask the user for necessary input
 printf("\nEnter the no. of sub-intervals: ");
 scanf("%d",&n);
 printf("\nEnter the initial limit: ");
 scanf("%lf",&a);
 printf("\nEnter the final limit: ");
 scanf("%lf",&b);
 Begin Trapezoidal Method: */
 start_time= omp_get_wtime();
 h=fabs(b-a)/n;
 for(i=1;i<n;i++){
   x=a+i*h;
   sum=sum+f(x);
 }
 integral=(h/2)*(f(a)+f(b)+2*sum);
 /*Print the answer */
 end_time= omp_get_wtime();
 printf("\nThe integral is: %lf\n",integral);
 printf("\nEl tiempo empleado es: %lf segundos\n", end_time - start_time);
 return 0;
}

