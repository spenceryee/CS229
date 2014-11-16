#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <fcntl.h>

int main(int argc, char *argv[]) {
    FILE *input_file = fopen(argv[1], "rb");
    if (!input_file) {printf("Cannot open file\n"); return 1;}
    char output_file[18];
    output_file[17] = '\0';
    output_file[0] = argv[1][0];
    strcpy(output_file + 1, "_detected_parsed");
    int fd = creat(output_file, 0644);
    
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
    char *value;
    char *endvalue;
    char number[200];
    
    while (true) {
        feature = strstr(feature, "value");
        if (feature == NULL) break;
        value = feature + 8;
        endvalue = strchr(value, '\n');
        strncpy(number, value, endvalue - value);
        number[endvalue - value] = '\0';
        dprintf(fd, "%s ", number);
        
        for (int i = 0; i < 3; i++) {
            feature = strstr(endvalue, "value");
            value = feature + 8;
            endvalue = strchr(value, '\n');
            strncpy(number, value, endvalue - value);
            number[endvalue - value] = '\0';
            dprintf(fd, "%s ", number);
        }
        feature = strstr(endvalue, "face_id");
        value = feature + 11;
        endvalue = strchr(value, '"');
        strncpy(number, value, endvalue - value);
        number[endvalue - value] = '\0';
        dprintf(fd, "%s ", number);
        
        feature = strstr(endvalue, "tag");
        value = feature + 7;
        strncpy(number, value, 2);
        number[2] = '\0';
        dprintf(fd, "%s\n", number);
    }
    
    free(file_contents);
    return 0;
}