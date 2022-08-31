#!/bin/bash

# Program: <template - program title goes here>
# Author: Chandra Lindy

# Purpose: compile c++, assemble asm files and run the resulting executable

# Clear any previously compiled outputs
rm *.o
rm *.lis
rm *.out

echo "Compile driver.cpp"
g++ -c -Wall -no-pie -m64 -std=c++17 -o driver.o driver.cpp

echo "Compile isFloat.cpp"
g++ -c -Wall -no-pie -m64 -std=c++17 -o isFloat.o isFloat.cpp

echo "Assemble fp_io.asm"
nasm -f elf64 -l fp_io.lis -o fp_io.o fp_io.asm

echo "Link object files using the gcc Linker standard 2017"
g++ -m64 -no-pie -std=c++17 -o floating_point_io.out driver.o isFloat.o fp_io.o

echo "Run the Quadratic Program:"
./floating_point_io.out

echo "Script file has terminated."

# Clear any new compiled outputs to keep environment clean
rm *.o
rm *.lis
rm *.out
