#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include "assert.h"
#include "time.h"
#include "pgcd.h"

void exit_if(int condition, const char *prefix)
{
    if (condition) {
        perror(prefix);
        exit(1);
    }
}

int main (int argc, char * argv []) 
{
	int a;
	int b;
	int c;
	int aFinished = 1;
	int bFinished = 1;
	int first = 0;

	FILE* fd_refA;
	FILE* fd_refB;
	FILE* fd_resuC;
	fd_refA = fopen("./src/ref_A.txt", "r");
	exit_if(fd_refA == NULL, "Fail oppening ref_A");
	fd_refB = fopen("./src/ref_B.txt", "r");
	exit_if(fd_refB == NULL, "Fail oppening ref_B");
	fd_resuC = fopen("./src/resu_C.txt", "w");
	exit_if(fd_resuC == NULL, "Fail oppening resu_C");

	printf("(II) Starting PGCD program\n");

	do {
		aFinished = fscanf(fd_refA, "%d\n", &a);
		bFinished = fscanf(fd_refB, "%d\n", &b);
		if (aFinished != EOF && bFinished != EOF)
		{
			c = PGCD(a,b);
			if(!first) 
			{
				fprintf(fd_resuC, "%d", c);
				first++;
			} else  {
				fprintf(fd_resuC, "\n%d", c);
			}
		}
	} while(aFinished != EOF && bFinished != EOF);

	printf("(II) End of PGCD program\n");

	fclose(fd_refA);
	fclose(fd_refB);
	fclose(fd_resuC);

  return 0;
}
