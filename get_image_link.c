#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <fcntl.h>

int main(int argc, char *argv[]) {
    FILE *fp = fopen(argv[1], "r");
    if (!fp) {printf("Cannot open file\n"); return 1;}
    char filename[2];
    filename[1] = '\0';
    int fds[8];
    for (char i = '1'; i <= '8'; i++) {
        filename[0] = i;
        fds[i - '1'] = creat(filename, 0644);
    }
    while (true) {
        char *line = NULL;
        size_t linecap = 0;
        ssize_t linelen;
        char intensity = '2';
        char emotion = '0';
        linelen = getline(&line, &linecap, fp);
        if (linelen <= 0) break;
        if (line[8] == 'H') intensity = '1';
        else if (line[8] == 'S') intensity = '0';
        else printf("Unrecognized intensity, %s\n", line);
        switch (line[21 - 2*(intensity - '0')]) { //3rd letter of the emotion
            case 'g': {emotion = '1'; break;} //anger
            case 'n': {emotion = '2'; break;} //contempt
            case 's': {emotion = '3'; break;} //disgust
            case 'a': {emotion = '4'; break;} //fear
            case 'p': {emotion = '5'; break;} //happiness
            case 'u': {emotion = '6'; break;} //neutral
            case 'd': {emotion = '7'; break;} //sadness
            case 'r': {emotion = '8'; break;} //surprise
            default: {printf("Unrecognized emotion, %s\n", line + 19 - 2*(intensity - '0')); break;}
        }
        free(line);
        line = NULL;
        linecap = 0;
        linelen = getline(&line, &linecap, fp);
        if (linelen <= 0) {printf("Image without output\n"); break;}
        char *link = strstr(line, "direct_link");
        if (link == NULL) {printf("JSON has no direct link\n"); break;}
        link += 14; //To the actual link
        char *endquote = strchr(link, '"');
        if (endquote == NULL) {printf("JSON direct link does not end in quote\n"); break;}
        char output[endquote - link + 29];
        output[endquote - link + 28] = '\0';
        output[0] = emotion;
        output[1] = intensity;
        output[2] = ' ';
        char *parsedlink = output + 3;
        strcpy(output + 3, "http%3A%2F%2F");
        int pos = 16;
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
        dprintf(fds[emotion - '1'], "%s\n", output);
        free(line);
    }
    return 0;
}

