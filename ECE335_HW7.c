#include <stdio.h>
#include <stdlib.h>

int main() {
	pid_t pid = fork();
	FILE *fptr = fopen("./text.txt", "r");
	char buff[256] = "";
	if(pid == 0) {
		if(fgets(buff, sizeof(buff), fptr) != NULL) {
			fgets(buff, sizeof(buff), fptr);
			printf("Child Reads: %s", buff);
		}
		else {
			printf("No Read");
		}
		exit(1);
	}
	else if(pid > 0) {
		if(fgets(buff, sizeof(buff), fptr) != NULL) {
			sleep(5);
			printf("Parent Reads: %s", buff);
		}
		else {
			printf("No Read");
		}
		exit(1);
	}
	else {
		printf("No Fork");
		return 0;
	}
	return 0;
}