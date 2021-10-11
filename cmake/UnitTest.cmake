function(define_test TEST_NAME TEST_DESCRIPTION SOURCE_LIST LINK_LIBRARIES)
    add_executable(${TEST_NAME} ${SOURCE_LIST})
    target_include_directories(${TEST_NAME} PRIVATE test/)
    target_include_directories(${TEST_NAME} PRIVATE $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/src>)
    target_link_libraries(${TEST_NAME} 
        PRIVATE gtest_main
                gmock_main
                build_options
                project_warnings
                ${LINK_LIBRARIES}
    )
    add_test(NAME ${TEST_DESCRIPTION} COMMAND ${TEST_NAME})
endfunction()