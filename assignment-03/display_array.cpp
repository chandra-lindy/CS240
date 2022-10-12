#include <stdio.h>

extern "C"
long display_array(long * arr)
{
    printf("These numbers were received and stored in an array:\n");
    for (long * i = arr; *i; ++i)
      printf("%ld", *i);

    printf("\n\n");
    return 0;
}
