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
	// printf("A = %d, B = %d\n", A, B);	//Test permettant de vérifier le ouple de valeur pour lequel la fonction ne va pas
	int a = A;
	int b = B;

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

int PGCD_euclide(int A, int B)
{			
	int C = 0;
	if(A == 0)
		return B;
	else if(B == 0)
		return A;

	while(B != 0){
		C = A % B;
		A = B;
		B = C;
	}
	return A;
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
	int r1 = 0;
	int r2 = 0;

	printf("(II) Starting PGCD program\n");
	
	for(int i = 1; i <= NB_TESTS; i++)
	{
		a = RandA();
		b = RandB();
		r1 = PGCD(a,b);
		r2 = PGCD_euclide(a,b);
		if (r1 != r2)
			printf("Test %d : a = %d, b = %d, r1 = %d, r2 = %d\n", i, a, b, r1, r2);
	}

	printf("(II) End of PGCD program\n");

  return 0;
}
