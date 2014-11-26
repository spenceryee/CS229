#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <fcntl.h>
#include <dirent.h>

int main(int argc, char *argv[]) {
    DIR *dir = opendir("Emotions");
    struct dirent *dp;
    char name[18];
    char imageName[100];
    strncpy(name, "Emotions/", 10);
    name[17] = '\0';
    char emotionName[100];
    char emotion;
    
    while ((dp = readdir(dir)) != NULL) {
        if (dp->d_name[0] == '.') continue;
        strcpy(name + 9, dp->d_name);
        
        DIR *sdir = opendir(name);
        struct dirent *sdp;
        name[13] = '/';
        while ((sdp = readdir(sdir)) != NULL) {
            if (sdp->d_name[0] == '.') continue;
            strcpy(name + 14, sdp->d_name);
            
            DIR *edir = opendir(name);
            struct dirent *edp;
            while ((edp = readdir(edir)) != NULL) {
                if (edp->d_name[0] == '.') continue;
                strcpy(emotionName, name);
                emotionName[17] = '/';
                strcpy(emotionName + 18, edp->d_name);
                FILE *fp = fopen(emotionName, "r");
                if (!fp) {printf("Cannot open file %s\n", emotionName); continue;}
                
                char *line = NULL;
                size_t linecap = 0;
                getline(&line, &linecap, fp);
                fclose(fp);
                for (int i = 0; true; i++) {
                    if (line[i] != ' ') {
                        emotion = line[i];
                        //printf("%s is emotion label %c\n", name, emotion);
                        break;
                    }
                }
                free(line);
                
                strcpy(imageName, name + 2);
                strncpy(imageName, "Image", 5);
                
                char command[100];
                strcpy(command, "ls ");
                strcpy(command + 3, imageName);
                strcpy(command + 18, " | tail -1");
                
                
                FILE *lsfp;
                char path[1035];
                /* Open the command for reading. */
                lsfp = popen(command, "r");
                if (lsfp == NULL) {
                    printf("Failed to run command\n" );
                    break; //exit(1);
                }
                
                /* Read the output a line at a time - output it. */
                fgets(path, sizeof(path)-1, lsfp);
                
                /* close */
                pclose(lsfp);
                
                path[21] = '\0';
                strcat(imageName, "/");
                strcat(imageName, path);
                //printf("%s is emotion %c\n", imageName, emotion);
                
                strcpy(command, "cp ");
                strcpy(command + 3, imageName);
                
                char sourceName[100];
                strcpy(sourceName, " CK+Rearranged/");
                sourceName[15] = emotion;
                sourceName[16] = '/';
                strcpy(sourceName + 17, path);
                
                strcat(command, sourceName);
                //printf("%s\n", command);
                
                system(command);
                
            }
            closedir(edir);
            
        }
        closedir(sdir);
        
        
    }
    closedir(dir);
    
}