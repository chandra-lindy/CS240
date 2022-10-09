#!/bin/bash

# Program: <template - program title goes here>
# Author: Chandra Lindy

# Purpose: compile c++, assemble asm files and run the resulting executable

# Clear any previously compiled outputs
rm *.o
rm *.lis
rm *.out

echo "Compile display_array.cpp"
g++ -c -Wall -no-pie -m64 -std=c++17 -o display_array.o display_array.cpp

echo "Assemble manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assemble sum.asm"
nasm -f elf64 -l sum.lis -o sum.o sum.asm

echo "Assemble input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "Compile main.c"
gcc -Wall -fno-pie -no-pie main.c input_array.o sum.o display_array.o -o sum_array.out

echo "Run the sum_array program"
./sum_array.out

echo "Script file has terminated."

# Clear any new compiled outputs to keep environment clean
rm *.o
rm *.lis
rm *.out
