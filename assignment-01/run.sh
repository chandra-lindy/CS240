#!/bin/bash

# Program: Compare Two Floats
# Author: Chandra Lindy

# Purpose: compile c++, assemble asm files and run the resulting executable

# Clear any previously compiled outputs
rm *.o
rm *.lis
rm *.out

echo "Compile driver.cpp"
g++ -c -Wall -no-pie -m64 -std=c++17 -o driver.o driver.cpp

echo "Compile isFloat.cpp"
g++ -c -Wall -no-pie -m64 -std=c++17 -o isfloat.o isfloat.cpp

echo "Assemble compareTwoFloats.asm"
nasm -f elf64 -l fp_io.lis -o compareTwoFloats.o compareTwoFloats.asm

echo "Link object files using the gcc Linker standard 2017"
g++ -m64 -no-pie -std=c++17 -o compareTwoFloats.out driver.o isfloat.o compareTwoFloats.o

echo "Run the Compare Float Program:\n\n"
./compareTwoFloats.out

echo "\n\nScript file has terminated."

# Clear any new compiled outputs to keep environment clean
rm *.o
rm *.lis
rm *.out
