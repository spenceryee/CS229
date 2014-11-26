#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <fcntl.h>
#include <dirent.h>

int main(int argc, char *argv[]) {
    DIR *dir = opendir("Images");
    struct dirent *dp;
    char name[16];
    char imageName[100];
    strncpy(name, "Images/", 10);
    name[15] = '\0';
    char emotionName[100];
    char emotion;
    
    while ((dp = readdir(dir)) != NULL) {
        if (dp->d_name[0] == '.') continue;
        strcpy(name + 7, dp->d_name);
        
        DIR *sdir = opendir(name);
        struct dirent *sdp;
        name[11] = '/';
        while ((sdp = readdir(sdir)) != NULL) {
            if (sdp->d_name[0] == '.') continue;
            strcpy(name + 12, sdp->d_name);
            
            DIR *edir = opendir(name);
            struct dirent *edp;
            while ((edp = readdir(edir)) != NULL) {
                if (edp->d_name[0] == '.') continue;
                
                char command[100];
                strcpy(command, "ls ");
                strcpy(command + 3, name);
                strcpy(command + 18, " | head -1");
                
                FILE *lsfp;
                char path[1035];
                
                lsfp = popen(command, "r");
                if (lsfp == NULL) {
                    printf("Failed to run command\n" );
                    break;
                }
                
                
                fgets(path, sizeof(path)-1, lsfp);
                path[strlen(path) - 1] = '\0';
                
                pclose(lsfp);
                
                strcpy(command, "cp ");
                strcpy(command + 3, name);
                strcat(command, "/");
                strcat(command, path);
                char sourceName[100];
                strcpy(sourceName, " CK+Rearranged/0/");
                strcat(sourceName, path);
                strcat(command, sourceName);
                system(command);
                //printf("%s\n", command);
                break;
                
                //path[21] = '\0';
                //strcat(imageName, "/");
                //strcat(imageName, path);
                
                //printf("%s is emotion %c\n", imageName, emotion);
                
                /*strcpy(command, "cp ");
                strcpy(command + 3, imageName);
                
                char sourceName[100];
                strcpy(sourceName, " CK+Rearranged/");
                sourceName[15] = emotion;
                sourceName[16] = '/';
                strcpy(sourceName + 17, path);
                
                strcat(command, sourceName);*/
                //printf("%s\n", command);
                
                //system(command);
                
            }
            closedir(edir);
            
        }
        closedir(sdir);
        
        
    }
    closedir(dir);
    
}