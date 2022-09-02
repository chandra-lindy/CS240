//*******************************************************************************************************************************
//Program name: "Compare Two Floats".
// This program will allow users to input two floating point numbers and determine which is the greater than the other by
// displaying the bigger number and returning the smaller number as a return value.
//
// Copyright (C) 2021 Chandra Lindy.
//
// This file is part of the software program "Add Float Array".
// This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
// version 3 as published by the Free Software Foundation.
//
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY// without even the implied
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
// A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>
//*******************************************************************************************************************************

//===============================================================================================================================
//Author information
//  Author name: Chandra Lindy
//  Author email: chandra.lindy@csu.fullerton.edu
//
//Program information
//  Program name: Compare Two Floats
//  Programming languages: Assembly x86-64, C++, C, bash
//  Date program began: 2022 August 31st
//  Date of last update: 2022 September 2nd
//  Date of reorganization of comments: 2021 September 2nd
//  Files in this program: compareTwoFloats.asm, driver.cpp, isfloat.cpp, run.sh
//  Status: Finished.  The program was tested extensively with no errors on an Ubuntu 20.04 native installation
//
//This file
//   File name: compare-two-floats.asm
//   Language: X86 with Intel syntax.
//   Max page width: 129 columns
//   Assemble: nasm -f elf64 -l compareTwoFloats.lis -o compareTwoFloats.o compareTwoFloats.asm
//   Link: g++ -m64 -no-pie -std=c++17 -o compareTwoFloats.out driver.o isfloat.o compareTwoFloats.o
//   Purpose: This file displays a greetings message to the user and calls compareTwoFloats function, then it displays the
//            return value of of compareTwoFloats to the user before displaying a goodbye message.
//===============================================================================================================================


#include <stdio.h>

extern "C" double compareTwoFloats();

int main() {
  printf("Welcome to Compare Two Floats programed by Chandra Lindy\n");
  printf("Mr Lindy has been programming in C++ for one semester\n");
  printf("And now, he's starting to program in assembly x86-64\n\n");

  double result {};

  result = compareTwoFloats();

  printf("\nThe driver module received this float number: %1.16lf and will keep it\n", result);
  printf("This driver module will return 0 to the operating system.\n");
  printf("Have a nice day.  Buh Bye!\n\n");

  return 0;
}
