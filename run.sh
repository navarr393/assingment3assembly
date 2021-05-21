
#David Navarro
#navarrod253@csu.fullerton.edu
#CPSC240-01 

#Bash file to compile and link all files from "harmonic sum"


echo "Bash script has started"

rm *.out    # Remove other helper files.
rm *.o
rm *.lis

echo "Assembling control.asm"

    # Assemble x86 module.
nasm -f elf64 -l control.lis -o control.o control.asm

echo "Assembling fill.asm"
nasm -f elf64 -l fill.lis -o fill.o fill.asm

echo "Assembling harmonic_mean.asm"
nasm -f elf64 -l harmonic_mean.lis -o harmonic_mean.o harmonic_mean.asm

echo "Compiling main.c"
gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c11

echo "Compiling display.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -o display.o display.cpp -std=c++17

echo "Compiling isfloat.cpp"
gcc -c -Wall -m64 -no-pie -o isfloat.o isfloat.cpp -std=c++17

    # Link object files.
g++ -m64 -no-pie -o executable.out -std=c11 main.o control.o fill.o display.o harmonic_mean.o isfloat.o

echo "Running the program"
./executable.out

echo "The bash script file will terminate"