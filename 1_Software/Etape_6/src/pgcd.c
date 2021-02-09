#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include "assert.h"
#include "time.h"

#include "pgcd.h"

int PGCD(const int A, const int B)
{
	// printf("A = %d, B = %d\n", A, B);	//Test permettant de vérifier le ouple de valeur pour lequel la fonction ne va pas
	int a = A;
	int b = B;

    // Pre condition
	assert(A >= BORNEINF);
	assert(A <= BORNESUP);
    assert(B >= BORNEINF);
	assert(B <= BORNESUP);

	//Cas particulier quand a ou b vaut 0
	if(a == 0)
		return B;
	else if (b == 0)
		return A;

    // Cas normal
	while(a != b)
	{
		if(a > b)
			a = a - b;
		else
			b = b - a;
	}

    // Post condition
	assert(a >= BORNEINF && a <= BORNESUP);
    assert(a <= A);
    assert(b <= B);
	assert(A % a == 0);
	assert(B % a == 0);

    // Resultat
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