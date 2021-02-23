#include "pgcd.h"

#define CATCH_CONFIG_MAIN  // This tells Catch to provide a main() - only do this in one cpp file
#include "catch.hpp"

TEST_CASE( "PGCD normal", "[pgcd]" ) {
	SECTION("A > B") {
		REQUIRE( PGCD(2, 1) == 1 );
		REQUIRE( PGCD(4, 2) == 2 );
		REQUIRE( PGCD(65535, 65534) == 1);
	}
	SECTION("A < B") {
		REQUIRE( PGCD(1, 2) == 1 );
		REQUIRE( PGCD(2, 4) == 2 );
		REQUIRE( PGCD(65534, 65535) == 1);
	}
	SECTION("A = B") {
		REQUIRE( PGCD(1, 1) == 1 );
		REQUIRE( PGCD(10, 10) == 10 );
		REQUIRE( PGCD(65535, 65535) == 65535);
	}
}


TEST_CASE( "PGCD excpetion", "[pgcd]" ) {
	REQUIRE( PGCD(0, 0) == 0);
	REQUIRE( PGCD(0, 1) == 1);
}