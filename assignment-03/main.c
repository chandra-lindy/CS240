#include <stdio.h>

extern int sum();
extern int input_array();
extern int display_array();

int main(int argc, char *argv[])
{
    printf("\n\n\nWelcome to Sum Array!\n"
           "programmed by Chandra Lindy\n\n");
    int answer = sum();
    int result = input_array();
    printf("Answer that was return from sum(): %d\n", answer);
    printf("Return value from input_array(): %d\n", result);

    printf("display_array works!!");
    display_array();

    printf("\n\nThank you for running this program!  Wish you the best for rest of the day...\n");
    printf("main.c will return 0 to the operating system.  Buh bye!");

    return 0;
}
