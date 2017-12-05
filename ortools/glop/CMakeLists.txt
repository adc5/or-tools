file(GLOB_RECURSE _SRCS "*.h" "*.cc")

add_library(${PROJECT_NAME}_glop ${_SRCS})
set_target_properties(${PROJECT_NAME}_glop PROPERTIES CMAKE_CXX_STANDARD 11)
set_target_properties(${PROJECT_NAME}_glop PROPERTIES CMAKE_CXX_STANDARD_REQUIRED ON)
set_target_properties(${PROJECT_NAME}_glop PROPERTIES CMAKE_CXX_EXTENSIONS OFF)
set_target_properties(${PROJECT_NAME}_glop PROPERTIES POSITION_INDEPENDENT_CODE ON)

add_dependencies(${PROJECT_NAME}_glop ${PROJECT_NAME}Proto)
