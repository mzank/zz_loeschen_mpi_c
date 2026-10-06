cmake_minimum_required(VERSION 3.21)

project(zz_loeschen_mpi_c
        VERSION 0.1.0
        LANGUAGES C
)

include(GNUInstallDirs)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY
        ${CMAKE_BINARY_DIR}/bin
)


# ---------------------------------------------------------------------------
# Common warning flags
# ---------------------------------------------------------------------------

add_library(project_warnings INTERFACE)

target_compile_options(project_warnings INTERFACE
        $<$<C_COMPILER_ID:GNU,Clang,AppleClang>:-Wall;-Wextra;-Wpedantic>
        $<$<CXX_COMPILER_ID:GNU,Clang,AppleClang>:-Wall;-Wextra;-Wpedantic>
        $<$<C_COMPILER_ID:MSVC>:/W4>
        $<$<CXX_COMPILER_ID:MSVC>:/W4>
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
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

target_link_libraries(zz_loeschen_mpi_c
        PRIVATE
        $<BUILD_INTERFACE:project_warnings>
)


# ---------------------------------------------------------------------------
# Installation and package export
# ---------------------------------------------------------------------------

set(ZZ_LOESCHEN_MPI_C_INSTALL_CMAKEDIR
        "${CMAKE_INSTALL_LIBDIR}/cmake/zz_loeschen_mpi_c"
)

install(TARGETS zz_loeschen_mpi_c
        EXPORT zz_loeschen_mpi_cTargets
        ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}"
        LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
        RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
        INCLUDES DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

install(DIRECTORY include/
        DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

install(EXPORT zz_loeschen_mpi_cTargets
        FILE zz_loeschen_mpi_cTargets.cmake
        NAMESPACE zz_loeschen_mpi_c::
        DESTINATION "${ZZ_LOESCHEN_MPI_C_INSTALL_CMAKEDIR}"
)

include(CMakePackageConfigHelpers)

configure_package_config_file(
        cmake/zz_loeschen_mpi_cConfig.cmake.in
        "${CMAKE_CURRENT_BINARY_DIR}/zz_loeschen_mpi_cConfig.cmake"
        INSTALL_DESTINATION "${ZZ_LOESCHEN_MPI_C_INSTALL_CMAKEDIR}"
)

write_basic_package_version_file(
        "${CMAKE_CURRENT_BINARY_DIR}/zz_loeschen_mpi_cConfigVersion.cmake"
        VERSION "${PROJECT_VERSION}"
        COMPATIBILITY SameMajorVersion
)

install(FILES
        "${CMAKE_CURRENT_BINARY_DIR}/zz_loeschen_mpi_cConfig.cmake"
        "${CMAKE_CURRENT_BINARY_DIR}/zz_loeschen_mpi_cConfigVersion.cmake"
        DESTINATION "${ZZ_LOESCHEN_MPI_C_INSTALL_CMAKEDIR}"
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
                "${PROJECT_SOURCE_DIR}/include"
                "${PROJECT_SOURCE_DIR}/src"
                "${PROJECT_SOURCE_DIR}/README.md"
        )

        set(DOXYGEN_EXCLUDE_DIRS
                "${CMAKE_BINARY_DIR}"
        )

        set(DOXYGEN_MAINPAGE
                "${PROJECT_SOURCE_DIR}/README.md"
        )

        include(cmake/Doxygen.cmake)

    else ()

        message(WARNING
                "Doxygen not found. "
                "Documentation target 'docs' will not be available."
        )

    endif ()

endif ()
