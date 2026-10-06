cmake_minimum_required(VERSION 3.20)

project(zz_loeschen_mpi_c
        VERSION 0.1
        LANGUAGES C CXX
)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY
        ${CMAKE_BINARY_DIR}/bin
)


# ---------------------------------------------------------------------------
# Library
# ---------------------------------------------------------------------------

add_library(zz_loeschen_mpi_c STATIC
        src/arithmeticaloperation.c
)

target_include_directories(zz_loeschen_mpi_c
        PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
)


target_compile_options(zz_loeschen_mpi_c
        PRIVATE
        -Wall
        -Wextra
        -Wpedantic
)


# ---------------------------------------------------------------------------
# Example
# ---------------------------------------------------------------------------

add_executable(example
        example.c
)

target_link_libraries(example
        PRIVATE
        zz_loeschen_mpi_c
)


# ---------------------------------------------------------------------------
# Tests
# ---------------------------------------------------------------------------

include(CTest)

if (BUILD_TESTING)
    add_subdirectory(tests)
endif ()


# ---------------------------------------------------------------------------
# Documentation
# ---------------------------------------------------------------------------

option(ENABLE_DOCS "Build Doxygen documentation" ON)

if (ENABLE_DOCS)

    find_package(Doxygen)

    if (DOXYGEN_FOUND)

        set(DOXYGEN_PROJECT_NAME
                "ZZ Loeschen MPI C"
        )

        set(DOXYGEN_PROJECT_NUMBER
                "${PROJECT_VERSION}"
        )

        set(DOXYGEN_OUTPUT_DIRECTORY
                "${CMAKE_BINARY_DIR}/docs"
        )

        set(DOXYGEN_INPUT_DIRS
                "${CMAKE_SOURCE_DIR}"
                "${CMAKE_SOURCE_DIR}/README.md"
        )

        set(DOXYGEN_MAINPAGE
                "${CMAKE_SOURCE_DIR}/README.md"
        )

        include(cmake/Doxygen.cmake)

    else ()

        message(WARNING
                "Doxygen not found. "
                "Documentation target 'docs' will not be available."
        )

    endif ()

endif ()
