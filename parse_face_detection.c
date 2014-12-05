#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <fcntl.h>

int main(int argc, char *argv[]) {
    FILE *input_file = fopen(argv[1], "rb");
    if (!input_file) {printf("Cannot open file\n"); return 1;}
    int fd = creat("webcam_detected_parsed.txt", 0644);
    
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
    
    feature = strstr(feature, "value"); // pitch_angle
    if (feature == NULL) {printf("Face could not be detected, please try again.\n"); exit(0);}
    value = feature + 1;
    
    feature = strstr(value, "value"); // roll_angle
    value = feature + 8;
    
    feature = strstr(value, "value"); // yaw_angle
    value = feature + 8;
    
    feature = strstr(value, "value");
    value = feature + 8;
    endvalue = strchr(value, '\n');
    strncpy(number, value, endvalue - value);
    number[endvalue - value] = '\0';
    dprintf(fd, "%s ", number); // smiling
    
    feature = strstr(endvalue, "face_id");
    value = feature + 11;
    endvalue = strchr(value, '"');
    strncpy(number, value, endvalue - value);
    number[endvalue - value] = '\0';
    dprintf(fd, "%s", number); // face_id
    
    free(file_contents);
    return 0;
}
