#include "stdio.h"
#include "stdlib.h"
#include "math.h"

#define NB_TESTS 20
#define BORNESUP 65535
#define BORNEINF 1

int PGCD(const int A, const int B)
{
	int a = A;
	int b = B;

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

int main (int argc, char * argv []){
	int a = 0;
	int b = 0;

	printf("(II) Starting PGCD program\n");
	
	for(int i = 1; i <= NB_TESTS; i++)
	{
		a = RandA();
		b = RandB();
		printf("Test %d : a = %d, b = %d, result = %d\n", i, a, b, PGCD(a,b));
	}

	printf("(II) End of PGCD program\n");

  return 0;
}
