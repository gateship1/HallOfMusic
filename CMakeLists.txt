cmake_minimum_required(VERSION 3.20)

project(music
    LANGUAGES CXX)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")
include(InternalHelperFunctions)
include(PreventInSourceBuilds)
include(ProjectSettings)
add_custom_target(buildconfig COMMAND ${CMAKE_COMMAND} -E echo "Building - $<CONFIG>")

include(CompilerSettings)

add_library(project_warnings INTERFACE)
set_compiler_settings(TARGET project_warnings)

add_library(build_options INTERFACE)
set_cxx_compiler_standard(TARGET build_options)

add_subdirectory(include)
add_subdirectory(src)

option(ENABLE_TESTING "Enable Test Builds" ON)
if (ENABLE_TESTING)
    find_package(GTest)

    if (NOT GTest)
        include(FetchDependencies)
        message(AUTHOR_WARNING "Google test is used, but not installed. Will fetch...")
        get_google_test()
    endif()
    
    include(UnitTest)

    add_subdirectory(test)
endif()