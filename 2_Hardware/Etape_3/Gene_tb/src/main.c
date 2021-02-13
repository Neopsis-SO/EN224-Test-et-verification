#include "stdio.h"
#include "stdlib.h"
#include "assert.h"
#include "pgcd.h"



//Permet de produire un paragraphe de test de PGCD pour le testbench en VHDL avec PGCD(A,B) = C
int main (int argc, char * argv []){

	if(argc != 4){
		printf("Use the program like this : './bin/main A B C' with PGCD(A,B) = C");
		return EXIT_FAILURE;
	}

	printf("\n");
	printf("\n");

	printf("idata_a  <= STD_LOGIC_VECTOR( TO_UNSIGNED( %s, 32) );\n", argv[1]);
	printf("idata_b  <= STD_LOGIC_VECTOR( TO_UNSIGNED( %s, 32) );\n", argv[2]);
	printf("idata_en <= '1';\n");
	printf("wait for clock_period;\n");
	printf("while odata_en = '0' loop\n");
	printf("    idata_en <= '0';\n");
	printf("    wait for clock_period\n");
	printf("end loop;\n");
	printf("ASSERT UNSIGNED( odata = TO_UNSIGNED( %s, 32) ) SEVERITY FAILURE;\n", argv[3]);
	printf("\n");
	printf("\n");
	
  return 0;
}
