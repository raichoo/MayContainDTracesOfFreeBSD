#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include "secret.h"

int check(const char *s)
{
    if (!strcmp(s, secret)) {
	return (1);
    } else {
	return (0);
    }
}

int main(int argc, char **argv) {
    char buffer[20];

    while (1) {
	fgets(buffer, 20, stdin);
	check(buffer);
    }

    return (0);
}
