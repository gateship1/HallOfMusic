function(SET_DEFAULT_BUILD_TYPE)
    message(STATUS "Setting build type to 'Debug' as none was specified.")
    set(CMAKE_BUILD_TYPE
        Debug
        CACHE STRING "Choose the type of build." FORCE)
    set_property(
      CACHE CMAKE_BUILD_TYPE
      PROPERTY STRINGS
               "Debug"
               "Release"
               "MinSizeRel"
               "RelWithDebInfo")
endfunction(SET_DEFAULT_BUILD_TYPE)

function(SET_PROJECT_BUILD_TYPE)
    if(NOT CMAKE_BUILD_TYPE)
        set_default_build_type()
    else()
        message(STATUS "Setting build type to '${CMAKE_BUILD_TYPE}' as specified.")
    endif()
endfunction(SET_PROJECT_BUILD_TYPE)

function(SET_PROJECT_SETTINGS)
    set_project_build_type()
endfunction(SET_PROJECT_SETTINGS)

set_project_settings()
