file(GLOB_RECURSE _SRCS "*.h" "*.cc")

add_library(${PROJECT_NAME}_sat ${_SRCS})
set_target_properties(${PROJECT_NAME}_sat PROPERTIES CMAKE_CXX_STANDARD 11)
set_target_properties(${PROJECT_NAME}_sat PROPERTIES CMAKE_CXX_STANDARD_REQUIRED ON)
set_target_properties(${PROJECT_NAME}_sat PROPERTIES CMAKE_CXX_EXTENSIONS OFF)
set_target_properties(${PROJECT_NAME}_sat PROPERTIES POSITION_INDEPENDENT_CODE ON)

add_dependencies(${PROJECT_NAME}_sat ${PROJECT_NAME}Proto)
