#!/bin/bash

# Program: Right Trianlges
# Author: Chandra Lindy

# Purpose: compile C, assemble asm files and run the resulting executable

# Clear any previously compiled outputs
rm *.o
rm *.lis
rm *.out

echo "Assemble triangle.asm"
nasm -f elf64 -l triangle.lis -o triangle.o triangle.asm

echo "Compile pythagoras.c"
gcc -Wall -fno-pie -no-pie pythagoras.c triangle.o -o right-triangles.out

echo "Run the Right Triangles Program:\n\n"
./right-triangles.out

echo "Script file has terminated."

# Clear any new compiled outputs to keep environment clean
rm *.o
rm *.lis
rm *.out
