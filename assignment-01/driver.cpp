#include <stdio.h>
#include <iostream>

extern "C" double fp_io();

main() {
  printf("Welcome to the floating point numbers programed by Chandra Lindy");
  printf("Mr Lindy has been programming in C++ for one semester");
  printf("And now, he's starting to program in assembly x86-64");

  double result {};

  result = fp_io();

  printf("The driver module received this float number: %1.16lf and will keep it", result);
  printf("This driver module will return 0 to the operating system.");
  printf("Have a nice day.  Buh Bye!");

  return 0;
}
