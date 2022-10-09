#include <stdio.h>

extern "C"
int display_array(int * arr)
{
    printf("\n");
    for (int * i = arr; *i; ++i) {
      printf("%d ", *i);
    }
    // printf("[ Array!  hurray!  it's displayed ]\n");
    return 0;
}
