#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include "assert.h"
#include "time.h"

#define NB_TESTS 20000
#define BORNESUP 65535
#define BORNEINF 1

int PGCD(const int A, const int B)
{
	printf("A = %d, B = %d\n", A, B);	//Test permettant de vérifier le ouple de valeur pour lequel la fonction ne va pas
	int a = A;
	int b = B;

	assert(A >= BORNEINF && A <= BORNESUP);
    assert(B >= BORNEINF && B <= BORNESUP);

	//Cas particulier quand a ou b vaut 0
	if(a == 0)
		a = b;
	else if (b == 0)
		b = a;

	while(a != b)
	{
		if(a > b)
			a = a - b;
		else
			b = b - a;
	}
	return a;
}

int RandA(void)
{
	int temp = rand();
	return temp % BORNESUP;
}

int RandB(void)
{
	int temp = rand();
	return temp % BORNESUP;
}

int main (int argc, char * argv []) 
{
	int a = 0;
	int b = 0;
	PGCD(a,b);	//Permet de prouver que les assertion sont desactivé avec -DNDEBUG

	printf("(II) Starting PGCD program\n");
	
	for(int i = 1; i <= NB_TESTS; i++)
	{
		a = RandA() + 1; //Ajout de +1 pour éviter d'avoir 0 dans le PGCD
		b = RandB() + 1; //Ajout de +1 pour éviter d'avoir 0 dans le PGCD
		PGCD(a,b);
		// printf("Test %d : a = %d, b = %d, result = %d\n", i, a, b, PGCD(a,b));
	}

	printf("(II) End of PGCD program\n");

  return 0;
}
