cmake_minimum_required(VERSION 3.5)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include(ORToolsHelpers)
set_version(ORTOOLS_VERSION)
message(STATUS "Or-Tools Version: ${ORTOOLS_VERSION}")
project(ORTools LANGUAGES CXX VERSION ${ORTOOLS_VERSION})

option(ORTOOLS_BUILD_TESTS "Build Or-Tools's own tests." ON)

# config options
if (MSVC)
  # /wd4005  macro-redefinition
  # /wd4068  unknown pragma
  # /wd4244  conversion from 'type1' to 'type2'
  # /wd4267  conversion from 'size_t' to 'type2'
  # /wd4800  force value to bool 'true' or 'false' (performance warning)
  add_compile_options(/W3 /WX /wd4005 /wd4068 /wd4244 /wd4267 /wd4800)
  add_definitions(/DNOMINMAX /DWIN32_LEAN_AND_MEAN=1 /D_CRT_SECURE_NO_WARNINGS)
endif()

# find dependencies
## pthread
find_package(Threads REQUIRED)

check_target(gflags)
check_target(glog)
check_target(Cbc)
#check_target(absl)

# Todo: to remove (should be associated to each target)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)

add_library(${PROJECT_NAME} "")
set_target_properties(${PROJECT_NAME} PROPERTIES CMAKE_CXX_STANDARD 11)
set_target_properties(${PROJECT_NAME} PROPERTIES CMAKE_CXX_STANDARD_REQUIRED ON)
set_target_properties(${PROJECT_NAME} PROPERTIES CMAKE_CXX_EXTENSIONS OFF)
set_target_properties(${PROJECT_NAME} PROPERTIES POSITION_INDEPENDENT_CODE ON)

foreach(SUBPROJECT
		base
		port
		util
		data
		lp_data
		glop
		graph
		algorithms
		sat
		bop
		linear_solver
		constraint_solver)
    add_subdirectory(ortools/${SUBPROJECT})
		target_link_libraries(${PROJECT_NAME} ${PROJECT_NAME}_${SUBPROJECT})
endforeach()

if(ORTOOLS_BUILD_TESTS)
  enable_testing()
endif()

include(GNUInstallDirs)
install(TARGETS ${PROJECT_NAME}
	EXPORT ${PROJECT_NAME}Targets
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
	"${PROJECT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)
install(
	EXPORT ${PROJECT_NAME}Targets
	NAMESPACE ORTools::
	DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}"
)
install(
  FILES
	"${PROJECT_SOURCE_DIR}/cmake/${PROJECT_NAME}Config.cmake"
	"${PROJECT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
	DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}"
)

#[[
message(FATAL "Or-Tools sources: ${${PROJECT_NAME}_SOURCES}")
add_library(${PROJECT_NAME} ${${PROJECT_NAME}_SOURCES})

set_target_properties(${PROJECT_NAME} PROPERTIES CMAKE_CXX_STANDARD 11)
set_target_properties(${PROJECT_NAME} PROPERTIES CMAKE_CXX_STANDARD_REQUIRED ON)
set_target_properties(${PROJECT_NAME} PROPERTIES CMAKE_CXX_EXTENSIONS OFF)
set_target_properties(${PROJECT_NAME} PROPERTIES POSITION_INDEPENDENT_CODE ON)
]]
