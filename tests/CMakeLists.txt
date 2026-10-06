# The tests are the only C++ in the project, so CXX is enabled here
# instead of in the top-level project() call.
enable_language(CXX)

# Prefer a system/packaged Catch2, fall back to fetching a pinned version.
find_package(Catch2 3 CONFIG QUIET)

if (Catch2_FOUND)
    # Catch2's helper modules (Catch.cmake) are installed next to its
    # config file, which is not on the module path by default.
    list(APPEND CMAKE_MODULE_PATH "${Catch2_DIR}")
else ()
    include(FetchContent)

    FetchContent_Declare(
            Catch2
            GIT_REPOSITORY https://github.com/catchorg/Catch2.git
            GIT_TAG v3.16.0
            GIT_SHALLOW TRUE
    )

    FetchContent_MakeAvailable(Catch2)
endif ()

add_executable(unit_tests
        test_arithmeticaloperation.cpp
)

target_compile_features(unit_tests
        PRIVATE
        cxx_std_17
)

set_target_properties(unit_tests PROPERTIES
        CXX_EXTENSIONS OFF
)

target_link_libraries(unit_tests
        PRIVATE
        zz_loeschen_mpi_c
        project_warnings
        Catch2::Catch2WithMain
)

include(Catch)

# Discover tests when ctest runs, not at build time: this keeps the build
# from executing binaries and works when cross-compiling.
catch_discover_tests(unit_tests
        DISCOVERY_MODE PRE_TEST
)
