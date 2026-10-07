cmake_minimum_required(VERSION 3.21)

project(zz_loeschen_mpi_c
        VERSION 0.1.0
        LANGUAGES C
)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY
        ${CMAKE_BINARY_DIR}/bin
)


# ---------------------------------------------------------------------------
# Common warning flags
# ---------------------------------------------------------------------------

add_library(project_warnings INTERFACE)

target_compile_options(project_warnings INTERFACE
        -Wall
        -Wextra
        -Wpedantic
)


# ---------------------------------------------------------------------------
# Library
# ---------------------------------------------------------------------------

add_library(zz_loeschen_mpi_c STATIC
        src/arithmeticaloperation.c
)

add_library(zz_loeschen_mpi_c::zz_loeschen_mpi_c ALIAS zz_loeschen_mpi_c)

target_compile_features(zz_loeschen_mpi_c
        PUBLIC
        c_std_11
)

set_target_properties(zz_loeschen_mpi_c PROPERTIES
        C_EXTENSIONS OFF
)

target_include_directories(zz_loeschen_mpi_c
        PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/include
)

target_link_libraries(zz_loeschen_mpi_c
        PRIVATE
        project_warnings
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
        project_warnings
)

target_compile_features(example
        PRIVATE
        c_std_11
)

set_target_properties(example PROPERTIES
        C_EXTENSIONS OFF
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

option(ENABLE_DOCS "Build Doxygen documentation" OFF)

if (ENABLE_DOCS)

    find_package(Doxygen)

    if (Doxygen_FOUND)

        set(DOXYGEN_PROJECT_NAME
                "ZZ Loeschen MPI C"
        )

        set(DOXYGEN_OUTPUT_DIRECTORY
                "${CMAKE_BINARY_DIR}"
        )

        set(DOXYGEN_USE_MDFILE_AS_MAINPAGE
                "${PROJECT_SOURCE_DIR}/README.md"
        )

        set(DOXYGEN_EXTRACT_ALL
                YES
        )

        set(DOXYGEN_EXTRACT_STATIC
                YES
        )

        # Silence progress chatter; warnings still go to stderr, so CI logs
        # keep showing them.
        set(DOXYGEN_QUIET
                YES
        )

        # Doc-rot guard: any doxygen warning fails the docs build. Warnings
        # are collected instead of aborting at the first one, but doxygen
        # still exits non-zero. FAIL_ON_WARNINGS exists only since 1.9.0.
        if (DOXYGEN_VERSION VERSION_LESS "1.9.0")
            set(DOXYGEN_WARN_AS_ERROR
                    YES
            )
        else ()
            set(DOXYGEN_WARN_AS_ERROR
                    FAIL_ON_WARNINGS
            )
        endif ()

        # Call and caller graphs require graphviz dot; doxygen_add_docs()
        # derives HAVE_DOT from whether dot was found, so it is not set here.
        if (Doxygen_dot_FOUND)
            set(DOXYGEN_CALL_GRAPH
                    YES
            )
            set(DOXYGEN_CALLER_GRAPH
                    YES
            )
            set(DOXYGEN_DOT_IMAGE_FORMAT
                    svg
            )
        endif ()

        doxygen_add_docs(docs
                "${PROJECT_SOURCE_DIR}/include"
                "${PROJECT_SOURCE_DIR}/src"
                "${PROJECT_SOURCE_DIR}/README.md"
                COMMENT "Generating Doxygen documentation (ZZ Loeschen MPI C)"
        )

    else ()

        message(WARNING
                "Doxygen not found. "
                "Documentation target 'docs' will not be available."
        )

    endif ()

endif ()
