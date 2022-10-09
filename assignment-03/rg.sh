#!/bin/bash

# Program: <template - program title goes here>
# Author: Chandra Lindy

# Purpose: compile c++, assemble asm files and run the resulting executable

# Clear any previously compiled outputs
rm *.o
rm *.lis
rm *.out

echo "Compile display_array.cpp"
g++ -c -Wall -no-pie -m64 -std=c++17 -o display_array.o display_array.cpp -g

echo "Assemble manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm -gdwarf

echo "Assemble sum.asm"
nasm -f elf64 -l sum.lis -o sum.o sum.asm -gdwarf

echo "Assemble input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm -gdwarf

echo "Compile main.c"
gcc -Wall -fno-pie -no-pie main.c input_array.o sum.o display_array.o manager.o -o sum_array.out -g

echo "Run the sum_array program"
gdb sum_array.out

echo "Script file has terminated."

# Clear any new compiled outputs to keep environment clean
#rm *.o
#rm *.lis
#rm *.out
