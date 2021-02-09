#include "stdio.h"
#include "stdlib.h"
#include "math.h"

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

int main (int argc, char * argv []){
	int i = 1;
	int a = 1;
	int b = 1;

	printf("(II) Starting PGCD program\n");
	
	a = 1;
	b = 1;
	printf("Test %d : a = %d, b = %d, result = %d\n", i++, a, b, PGCD(a,b));
	a = 2;
	b = 4;
	printf("Test %d : a = %d, b = %d, result = %d\n", i++, a, b, PGCD(a,b));
	a = 65535;
	b = 65535;
	printf("Test %d : a = %d, b = %d, result = %d\n", i++, a, b, PGCD(a,b));
	a = 65535;
	b = 60000;
	printf("Test %d : a = %d, b = %d, result = %d\n", i++, a, b, PGCD(a,b));
	a = 60000;
	b = 65535;
	printf("Test %d : a = %d, b = %d, result = %d\n", i++, a, b, PGCD(a,b));
	a = 65535;
	b = 1;
	printf("Test %d : a = %d, b = %d, result = %d\n", i++, a, b, PGCD(a,b));
	a = 65535;
	b = 25;
	printf("Test %d : a = %d, b = %d, result = %d\n", i++, a, b, PGCD(a,b));
	a = 40;
	b = 35;
	printf("Test %d : a = %d, b = %d, result = %d\n", i++, a, b, PGCD(a,b));
	a = 6535;
	b = 687;
	printf("Test %d : a = %d, b = %d, result = %d\n", i++, a, b, PGCD(a,b));
	a = 4325;
	b = 8543;
	printf("Test %d : a = %d, b = %d, result = %d\n", i++, a, b, PGCD(a,b));

	printf("(II) End of PGCD program\n");

  return 0;
}
