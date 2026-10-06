include(FetchContent)

FetchContent_Declare(
        Catch2
        GIT_REPOSITORY https://github.com/catchorg/Catch2.git
        GIT_TAG v3.16.0
)

FetchContent_MakeAvailable(Catch2)

add_executable(unit_tests
        test_arithmeticaloperation.cpp
)

target_link_libraries(unit_tests
        PRIVATE
        zz_loeschen_mpi_c
        project_warnings
        Catch2::Catch2WithMain
)

include(Catch)

catch_discover_tests(unit_tests)
