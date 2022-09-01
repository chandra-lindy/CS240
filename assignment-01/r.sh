#!/bin/bash

# Program: <template - program title goes here>
# Author: Chandra Lindy

# Purpose: compile c++, assemble asm files and run the resulting executable

# Clear any previously compiled outputs
rm *.o
rm *.lis
rm *.out

echo "Compile driver.cpp"
g++ -c -Wall -no-pie -m64 -std=c++17 -o driver.o driver.cpp -g

echo "Compile isFloat.cpp"
g++ -c -Wall -no-pie -m64 -std=c++17 -o isfloat.o isfloat.cpp -g

echo "Assemble fp_io.asm"
nasm -f elf64 -l fp_io.lis -o compare_two_floats.o compare-two-floats.asm -g

echo "Link object files using the gcc Linker standard 2017"
g++ -m64 -no-pie -std=c++17 -o compare_two_floats.out driver.o isfloat.o compare_two_floats.o -g

echo "Run the Compare Float Program:"
./compare_two_floats.out

echo "Script file has terminated."

# Clear any new compiled outputs to keep environment clean
rm *.o
rm *.lis
rm *.out
