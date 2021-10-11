include(FetchContent)

function(GET_GOOGLE_TEST)
    FetchContent_Declare(googletest
        GIT_REPOSITORY https://github.com/google/googletest.git
        GIT_TAG 703bd9caab50b139428cea1aaff9974ebee5742e # release-1.10.0
    )

    FetchContent_GetProperties(googletest)
    if(NOT googletest_POPULATED)
        FetchContent_Populate(googletest)
        add_subdirectory(${googletest_SOURCE_DIR} ${googletest_BINARY_DIR})
    endif(NOT googletest_POPULATED)

    message(STATUS "googletest source directory: ${googletest_SOURCE_DIR}")
    message(STATUS "googletest binary directory: ${googletest_BINARY_DIR}")
endfunction(GET_GOOGLE_TEST)