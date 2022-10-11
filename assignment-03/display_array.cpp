#include <stdio.h>

extern "C"
int display_array(int * arr)
{
    printf("\nThese numbers were received and stored in an array:\n");
    for (int * i = arr; *i; ++i)
      printf("%d ", *i);

    printf("\n\n");
    return 0;
}
