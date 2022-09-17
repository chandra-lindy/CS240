//********************************************************************************************************************************
//Program name: "Right Triangles".
// This program will take the length of two sides of a triangle and returns the length of the hypotenuse.  We do this after we
// politely greet the user of course!
//
// Copyright (C) 2022 Chandra Lindy.
//
// This file is part of the software program "Right Triangles".
// This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
// version 3 as published by the Free Software Foundation.
//
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
// A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.
//********************************************************************************************************************************

//================================================================================================================================
//Author information
//  Author name: Chandra Lindy
//  Author email: chandra.lindy@csu.fullerton.edu
//
//Program information
//  Program name: Right Triangles
//  Programming languages: Assembly x86-64, C, bash
//  Date program began: 2022 September 15th
//  Date of last update: 2022 September 16th
//  Date of reorganization of comments: 2022 September 16th
//  Files in this program: triangle.asm, pythagoras.c, r.sh
//  Status: Finished.  The program was tested extensively with no errors on an Ubuntu 20.04 native installation
//
//This file
//   File name: pythagoras.c
//   Language: C
//   Max page width: 130 columns
//   Assemble: nasm -f elf64 -l triangle.lis -o triangle.o triangle.asm
//   Compile: gcc -Wall -fno-pie -no-pie pythagoras.c triangle.o -o right-triangles.out
//   Purpose: Politely calculate the hypotenuse of a triangle given length of two sides of a triangle
//================================================================================================================================


#include <stdio.h>

extern double triangle();

int main() {
  printf("Welcome to Right Triangles programed by Chandra Lindy\n\n");
  printf("To hire Mr Lindy contact him at chandra.lindy@csu.fullerton.edu\n");
  printf("Or you can simply email him to say \"Hi!\"\n\n");

  double result;

  result = triangle();

  printf("\nThe main function received this number: %1.16lf for safe keeping!\n", result);
  printf("This driver module will return 0 to the operating system.\n");
  printf("Have a nice day.  Buh Bye!\n\n");

  return 0;
}
