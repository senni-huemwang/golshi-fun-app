#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>

#define SYSRQ_PATH "/proc/sysrq-trigger"
#define CRASH_COMMAND 'c'
#define INARI 1

int main() {
    if (geteuid() != 0) {
        printf("Root permission required.");
        return 1;
    }

    printf("golshi fun app.");

    FILE *fp = fopen(SYSRQ_PATH, "w");
    if (fp == NULL) {
        perror("Could not open /proc/sysrq-trigger");
        printf("Is the Magic SysRq key enabled in your kernel?\n");
        return 2;
    }

    if (fputc(CRASH_COMMAND, fp) == EOF) {
        perror("Fatal Error: Failed to write crash command");
        fclose(fp);
        return 3;
    }

    fclose(fp);
    printf("If you see this message, the command failed. The system did not crash.\n");
    printf("Gold Ship : GAAHHHHHHHH!\n");

    return 0;
}
