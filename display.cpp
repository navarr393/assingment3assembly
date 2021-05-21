/*
; Author Information:                                                                       
; Name:         David Navarro                                                               
; Email:        navarrod253n@csu.fullerton.edu                                                  
; Institution:  California State University - Fullerton                                     
; Course:       CPSC 240-01 Assembly Language                                               
*/
#include <stdio.h>

extern "C" void display(double array[], long index);

// Definition of display function.
void display(double array[], long index)
{
    for (int i = 0; i < index; ++i)
    {
        
    
        printf("%5.8lf", array[i]);
        printf("\n");
        
        
    }
    //printf("\n");
    
}