#include <stdio.h>
#include <iostream>

extern "C" double compare_two_floats();

int main() {
  printf("Welcome to the floating point numbers programed by Chandra Lindy\n");
  printf("Mr Lindy has been programming in C++ for one semester\n");
  printf("And now, he's starting to program in assembly x86-64\n\n");

  double result {};

  result = compare_two_floats();

  printf("\nThe driver module received this float number: %1.16lf and will keep it\n", result);
  printf("This driver module will return 0 to the operating system.\n");
  printf("Have a nice day.  Buh Bye!\n\n");

  return 0;
}
