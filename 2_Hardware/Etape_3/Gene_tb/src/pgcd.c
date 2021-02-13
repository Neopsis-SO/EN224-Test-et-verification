#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include "assert.h"
#include "pgcd.h"

#define BORNEINF 1
#define BORNESUP 65535

int PGCD(int A, int B)
{			

	assert(A >= BORNEINF && A <= BORNESUP);
	assert(B >= BORNEINF && B <= BORNESUP);
	
	if(A==0)
		return B;
	else if(B==0)
		return A;
		
	while(A != B){
		if(A>B)
			A = A - B;
		else
			B = B - A;
	}
	assert(A > 0 && A <= BORNESUP);
	return A;
}

int PGCD_euclide(int A, int B)
{			
    assert(A >= BORNEINF && A <= BORNESUP);
	assert(B >= BORNEINF && B <= BORNESUP);
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
    assert(A > 0 && A <= BORNESUP);
	return A;
}


int myRand(){
	return rand()%BORNESUP;
}