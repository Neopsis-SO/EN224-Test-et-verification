#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include "assert.h"
#include "time.h"
#include "pgcd.h"

int main (int argc, char * argv []) 
{
	int tab[][2] = {{1,1},
					{1,2},
					{2,4},
					{10,10},
					{100,100},
					{BORNESUP, BORNESUP},
					{0,2},
					{2,0},
					{0,0}};

	printf("(II) Starting PGCD program\n");

	assert(PGCD(tab[0][0], tab[0][1]) == 1);
	assert(PGCD(tab[1][0], tab[1][1]) == 1);
	assert(PGCD(tab[2][0], tab[2][1]) == 2);
	assert(PGCD(tab[3][0], tab[3][1]) == 10);
	assert(PGCD(tab[4][0], tab[4][1]) == 100);
	assert(PGCD(tab[5][0], tab[5][1]) == BORNESUP);
	assert(PGCD(tab[6][0], tab[6][1]) == 2);
	assert(PGCD(tab[7][0], tab[7][1]) == 2);
	assert(PGCD(tab[8][0], tab[8][1]) == 0);

	printf("(II) End of PGCD program\n");

  return 0;
}
