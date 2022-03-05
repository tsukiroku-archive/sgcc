// Example file

/**
 * 
 * @file main.c
 * @author tsukiroku
 * @date 2022-02-20
 * 
 * @copyright Copyright 2022. rwdv
 */

#include <stdio.h>

int main(int argc, char *argv[]) {
    for (int i = 0; i < argc; i++) {
        printf("%d: %s\n", i, argv[i]);
    }
}
