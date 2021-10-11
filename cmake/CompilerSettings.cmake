function(SET_COMPILER_DIAGNOSTICS)
    if(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang")
        add_compile_options(-fcolor-diagnostics)
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        add_compile_options(-fdiagnostics-color=always)
    else()
        message(STATUS "No colored compiler diagnostic set for '${CMAKE_CXX_COMPILER_ID}' compiler.")
    endif()
endfunction(SET_COMPILER_DIAGNOSTICS)

function(SET_PROJECT_WARNINGS)
    
    set(prefix ARGS)
    set(single_value_args TARGET)
    cmake_parse_arguments(
        PARSE_ARGV 0 ${prefix}
        "" "${single_value_args}" ""
    )
    error_for_unparsed(ARGS)

    option(WARNINGS_AS_ERRORS "Treat compiler warnings as errors" ON)

    set(MSVC_WARNINGS
        /W4
        /w14242
        /w14254
        /w14263
        /w14265
        /w14287
        /we4289
        /w14296
        /w14311
        /w14545
        /w14546
        /w14547
        /w14549
        /w14555
        /w14619
        /w14640
        /w14826
        /w14905
        /w14906
        /w14928
        /permissive-
    )

    set(CLANG_WARNINGS
        -Wall
        -Wextra
        -Wshadow
        -Wnon-virtual-dtor
        -Wold-style-cast
        -Wcast-align
        -Wunused
        -Woverloaded-virtual
        -Wpedantic
        -Wconversion
        -Wsign-conversion
        -Wnull-dereference
        -Wdouble-promotion
        -Wformat=2
        -Wimplicit-fallthrough
    )

    if(WARNINGS_AS_ERRORS)
        set(CLANG_WARNINGS ${CLANG_WARNINGS} -Werror)
        set(MSVC_WARNINGS ${MSVC_WARNINGS} /WX)
    endif()

    set(GCC_WARNINGS
        ${CLANG_WARNINGS}
        -Wmisleading-indentation
        -Wduplicated-cond
        -Wduplicated-branches
        -Wlogical-op
        -Wuseless-cast
    )

    if(MSVC)
        set(PROJECT_WARNINGS ${MSVC_WARNINGS})
    elseif(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang")
        set(PROJECT_WARNINGS ${CLANG_WARNINGS})
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        set(PROJECT_WARNINGS ${GCC_WARNINGS})
    else()
        message(AUTHOR_WARNING "No compiler warnings set for '${CMAKE_CXX_COMPILER_ID}' compiler.")
    endif()

    target_compile_options(${ARGS_TARGET} INTERFACE ${PROJECT_WARNINGS})

endfunction(SET_PROJECT_WARNINGS)

function(SET_COMPILER_SETTINGS)
    message(STATUS "CXX compiler ID: '${CMAKE_CXX_COMPILER_ID}'")
    cmake_parse_arguments(PARSE_ARGV 0 FWD "" "" "")
    if (NOT ${FWD_UNPARSED_ARGUMENTS})
        message(FATAL_ERROR "No targets for compiler settings!")
    endif()
    set_compiler_diagnostics()
    set_project_warnings(${FWD_UNPARSED_ARGUMENTS})
endfunction(SET_COMPILER_SETTINGS)

function(SET_CXX_COMPILER_STANDARD)
    
    set(prefix ARGS)
    set(single_value_args TARGET)
    cmake_parse_arguments(
        PARSE_ARGV 0 ${prefix}
        "" "${single_value_args}" ""
    )
    error_for_unparsed(ARGS)
    
    set(CMAKE_CXX_STANDARD 17)
    message(STATUS "CXX standard: ${CMAKE_CXX_STANDARD}")

    target_compile_features(${ARGS_TARGET} INTERFACE cxx_std_17)

endfunction(SET_CXX_COMPILER_STANDARD)