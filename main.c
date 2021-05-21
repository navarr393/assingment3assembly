/*
Author Information:                                                                       
Name:         David Navarro                                                               
Email:        navarrod253n@csu.fullerton.edu                                                
Institution:  California State University - Fullerton                                     
Course:       CPSC 240-01 Assembly Language                                               
*/                                                                                          

#include <stdio.h>
#include <stdint.h>

extern double control(); //name in asm label (ex. global start)

int main()
{
   double result_code = -999;
    
 printf("This is 240-01 programming final by David Navarro.\n");

    result_code = control();
 printf("The main function received this number %lf and plans to keep it.\n", result_code);
 printf("A 0 will now be returned to the operating system.\n");
 printf("Have a great next semester. Bye.\n");
 return 0;
}