if(DOXYGEN_FOUND)

    set(DOXYGEN_IN ${PROJECT_SOURCE_DIR}/cmake/Doxyfile.in)
    set(DOXYGEN_OUT ${CMAKE_BINARY_DIR}/Doxyfile)

    string(JOIN " " DOXYGEN_INPUT_DIRS_STR ${DOXYGEN_INPUT_DIRS})
    string(JOIN " " DOXYGEN_EXCLUDE_DIRS_STR ${DOXYGEN_EXCLUDE_DIRS})

    file(MAKE_DIRECTORY ${DOXYGEN_OUTPUT_DIRECTORY})

    configure_file(
        ${DOXYGEN_IN}
        ${DOXYGEN_OUT}
        @ONLY
    )

    add_custom_target(docs
        COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_OUT}
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        COMMENT "Generating Doxygen documentation (MPI Benchmarks)"
        VERBATIM
    )

else()

    message(STATUS "Doxygen not found, docs target unavailable")

endif()
