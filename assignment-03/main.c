#include <stdio.h>
#include <ctype.h>

extern int sum();
extern int input_array();
extern int display_array();
extern char * manager();

extern int is_integer(char * num)
{
  for (char * i = num; *i; ++i)
    if(!isdigit(*i)) return -1;
  return 0;
}

int main(int argc, char *argv[])
{
    printf("\n\n\nWelcome to Sum Array!\n"
           "programmed by Chandra Lindy\n\n");

    char * name = manager();

    printf("\n\nThank you for running this program %s!  Wish you the best for rest of the day...\n", name);
    printf("main.c will return 0 to the operating system.  Buh bye!\n\n\n");

    return 0;
}
