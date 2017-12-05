file(GLOB_RECURSE _SRCS "*.h" "*.cc")
list(REMOVE_ITEM _SRCS "${CMAKE_CURRENT_SOURCE_DIR}/hungarian_test.cc")

add_library(${PROJECT_NAME}_algorithms OBJECT ${_SRCS})
set_target_properties(${PROJECT_NAME}_algorithms PROPERTIES CMAKE_CXX_STANDARD 11)
set_target_properties(${PROJECT_NAME}_algorithms PROPERTIES CMAKE_CXX_STANDARD_REQUIRED ON)
set_target_properties(${PROJECT_NAME}_algorithms PROPERTIES CMAKE_CXX_EXTENSIONS OFF)
set_target_properties(${PROJECT_NAME}_algorithms PROPERTIES POSITION_INDEPENDENT_CODE ON)
