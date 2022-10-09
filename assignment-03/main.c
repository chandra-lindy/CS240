#include <stdio.h>

extern int sum();
extern int input_array();
extern int display_array();
extern char * manager();

int main(int argc, char *argv[])
{
    printf("\n\n\nWelcome to Sum Array!\n"
           "programmed by Chandra Lindy\n\n");
    int answer = sum();
    char * name = manager();

    printf("Answer that was return from sum(): %d\n", answer);
    printf("Return value from manager: %s\n", name);

    printf("\n\nThank you for running this program!  Wish you the best for rest of the day...\n");
    printf("main.c will return 0 to the operating system.  Buh bye!\n");

    return 0;
}
