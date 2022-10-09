#include <stdio.h>

extern int sum();
extern int input_array();

int main(int argc, char *argv[])
{
    printf("Welcome to Floating Points Numbers programmed by Leslie Silverman.\n"
           "Ms Silverman has been working for the Longstreet Software Company for the last two years.\n");
    int answer = sum();
    int input_array();
    printf("Answer that was return from sum(): %d", answer);
    return 0;
}
