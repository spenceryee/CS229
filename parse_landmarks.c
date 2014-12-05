#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <fcntl.h>

int main(int argc, char *argv[]) {
    FILE *input_file = fopen(argv[1], "rb");
    if (!input_file) {printf("Cannot open file\n"); return 1;}
    int fd = creat("webcam_matrix.txt", 0644);
    
    char *file_contents;
    long input_file_size;
    fseek(input_file, 0, SEEK_END);
    input_file_size = ftell(input_file);
    rewind(input_file);
    file_contents = malloc((input_file_size + 1) * (sizeof(char)));
    fread(file_contents, sizeof(char), input_file_size, input_file);
    fclose(input_file);
    file_contents[input_file_size] = '\0';
    
    char *feature = file_contents;
    char *value = feature;
    char *endvalue;
    char number[200];
    
    endvalue = strchr(value, '\n');
    strncpy(number, value, endvalue - value);
    number[endvalue - value] = '\0';
    dprintf(fd, "%s", number); // smiling
    
    for (int i = 0; i < 83; i++) {
        feature = strstr(endvalue, "\"x\"");
        value = feature + 5;
        endvalue = strchr(value, ',');
        strncpy(number, value, endvalue - value);
        number[endvalue - value] = '\0';
        dprintf(fd, " %s", number);
        feature = strstr(endvalue, "\"y\"");
        value = feature + 5;
        endvalue = strchr(value, '\n');
        strncpy(number, value, endvalue - value);
        number[endvalue - value] = '\0';
        dprintf(fd, " %s", number);
    }
    dprintf(fd, "\n");
    
    free(file_contents);
    return 0;
}