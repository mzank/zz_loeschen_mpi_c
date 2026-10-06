#include <catch2/catch_test_macros.hpp>

#include "zz_loeschen_mpi_c/arithmeticaloperation.h"

TEST_CASE("add works")
{
    REQUIRE(add(2, 3) == 5);
    REQUIRE(add(-1, 1) == 0);
}
