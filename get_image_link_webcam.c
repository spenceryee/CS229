#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <fcntl.h>

int main(int argc, char *argv[]) {
    FILE *fp = fopen(argv[1], "r");
    if (!fp) {printf("Cannot open file\n"); return 1;}
    char filename[16];
    filename[15] = '\0';
    strcpy(filename, "webcam_link.txt");
    int fd = creat(filename, 0644);
    char *line = NULL;
    size_t linecap = 0;
    ssize_t linelen;
    linelen = getline(&line, &linecap, fp);
    if (linelen <= 0) {printf("Could not find any result from uploading image.\n"); exit(0);}
    free(line);
    line = NULL;
    linecap = 0;
    linelen = getline(&line, &linecap, fp);
    if (linelen <= 0) {printf("Image may have failed to upload\n"); exit(0);}
    char *link = strstr(line, "direct_link");
    if (link == NULL) {printf("JSON has no direct link: %s\n", line); exit(0);}
    link += 14; //To the actual link
    char *endquote = strchr(link, '"');
    if (endquote == NULL) {printf("JSON direct link does not end in quote\n"); exit(0);}
    char output[endquote - link + 26];
    output[endquote - link + 25] = '\0';
    strcpy(output, "http%3A%2F%2F");
    int pos = 13;
    for (int i = 0; i < endquote - link; i++) {
        if (link[i] == '\\' || link[i] == '/') {
            output[i + pos] = '%';
            output[i + pos + 1] = '2';
            output[i + pos + 2] = 'F';
            pos += 2;
        } else {
            output[i + pos] = link[i];
        }
    }
    dprintf(fd, "%s\n", output);
    free(line);
    return 0;
}

