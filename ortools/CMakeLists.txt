if (NOT BUILD_CXX)
	return()
endif()

cmake_minimum_required(VERSION 3.5)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include(ORToolsHelpers)
set_version(ORTOOLS_VERSION)
project(ortools LANGUAGES CXX VERSION ${ORTOOLS_VERSION})

# Project use ortools as root include dir aka #include "ortools/x/y.h" not #include "x/y.h"
get_filename_component(PARENT_SOURCE_DIR ${PROJECT_SOURCE_DIR} DIRECTORY)
set(PROJECT_SOURCE_DIR ${PARENT_SOURCE_DIR})
get_filename_component(PARENT_BINARY_DIR ${PROJECT_BINARY_DIR} DIRECTORY)
set(PROJECT_BINARY_DIR ${PARENT_BINARY_DIR})

# SWIG Python Java tools
if (BUILD_PYTHON OR BUILD_JAVA)
	find_package(SWIG REQUIRED)
	include(UseSWIG)
endif()

if (BUILD_PYTHON)
	# Specify python version
	set(Python_ADDITIONAL_VERSIONS "3.6;3.5;2.7"
		CACHE STRING "available python version")
	find_package(PythonInterp REQUIRED)
	find_package(PythonLibs REQUIRED)
endif()

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

check_target(Protobuf)
check_target(gflags)
check_target(glog)
check_target(Cbc)
#check_target(absl)

# Main Target
add_library(${PROJECT_NAME} SHARED "")
set_target_properties(${PROJECT_NAME} PROPERTIES CMAKE_CXX_STANDARD 11)
set_target_properties(${PROJECT_NAME} PROPERTIES CMAKE_CXX_STANDARD_REQUIRED ON)
set_target_properties(${PROJECT_NAME} PROPERTIES CMAKE_CXX_EXTENSIONS OFF)
set_target_properties(${PROJECT_NAME} PROPERTIES POSITION_INDEPENDENT_CODE ON)
set_target_properties(${PROJECT_NAME} PROPERTIES LINKER_LANGUAGE CXX)
target_include_directories(${PROJECT_NAME} INTERFACE
	$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}>
	$<BUILD_INTERFACE:${PROJECT_BINARY_DIR}>
  $<INSTALL_INTERFACE:include>
	)
target_link_libraries(${PROJECT_NAME}
	${Protobuf_LIBRARIES}
	${gflags_LIBRARIES}
	${glog_LIBRARIES}
	${Cbc_LIBRARIES}
	${CMAKE_THREAD_LIBS_INIT}
	)

# Generate/Build Protobuf sources
include_directories(${Protobuf_INCLUDE_DIR})
find_package(Protobuf)
file(GLOB_RECURSE PROTO_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "*.proto")

set(PROTOBUF_IMPORT_DIRS ${PROJECT_SOURCE_DIR})
set(PROTOBUF_GENERATE_CPP_APPEND_PATH OFF)
PROTOBUF_GENERATE_CPP(PROTO_SRCS PROTO_HDRS ${PROTO_FILES})
add_library(${PROJECT_NAME}_proto OBJECT ${PROTO_SRCS} ${PROTO_HDRS})
set_target_properties(${PROJECT_NAME}_proto PROPERTIES POSITION_INDEPENDENT_CODE ON)
target_include_directories(${PROJECT_NAME}_proto PRIVATE
	${PROJECT_SOURCE_DIR}
	${PROJECT_BINARY_DIR}
	${PROJECT_BINARY_DIR}/ortools
	)

# add_dependencies() really Needed ?
add_dependencies(${PROJECT_NAME} ${PROJECT_NAME}_proto)
target_sources(${PROJECT_NAME} PRIVATE $<TARGET_OBJECTS:${PROJECT_NAME}_proto>)

foreach(SUBPROJECT base port	util data lp_data glop graph algorithms sat	bop
		linear_solver	constraint_solver)
	add_subdirectory(${SUBPROJECT})
	target_include_directories(${PROJECT_NAME}_${SUBPROJECT} PUBLIC
		${PROJECT_SOURCE_DIR}
		${PROJECT_BINARY_DIR}
		)
	target_sources(${PROJECT_NAME} PRIVATE $<TARGET_OBJECTS:${PROJECT_NAME}_${SUBPROJECT}>)
	# add_dependencies() really Needed ?
	add_dependencies(${PROJECT_NAME}_${SUBPROJECT} ${PROJECT_NAME}_proto)
endforeach()

# Install rules
include(GenerateExportHeader)
GENERATE_EXPORT_HEADER(${PROJECT_NAME})
set_property(TARGET ${PROJECT_NAME} PROPERTY VERSION ${PROJECT_VERSION})
set_property(TARGET ${PROJECT_NAME} PROPERTY SOVERSION ${PROJECT_VERSION_MAJOR})
set_property(TARGET ${PROJECT_NAME} PROPERTY INTERFACE_${PROJECT_NAME}_MAJOR_VERSION ${PROJECT_VERSION_MAJOR})
set_property(TARGET ${PROJECT_NAME} APPEND PROPERTY COMPATIBLE_INTERFACE_STRING ${PROJECT_NAME}_MAJOR_VERSION)

include(GNUInstallDirs)
install(TARGETS ${PROJECT_NAME}
	EXPORT ${PROJECT_NAME}Targets
	RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
	LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
	ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
	)

install(DIRECTORY ortools
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    COMPONENT Devel
    FILES_MATCHING
		PATTERN "*.h")
install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/ortools
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    COMPONENT Devel
    FILES_MATCHING
		PATTERN "*.pb.h"
    PATTERN CMakeFiles EXCLUDE)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
	"${PROJECT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
	COMPATIBILITY SameMajorVersion
	)
install(
	EXPORT ${PROJECT_NAME}Targets
	NAMESPACE ${PROJECT_NAME}::
	DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}"
	)
install(
	FILES
	"${PROJECT_SOURCE_DIR}/cmake/${PROJECT_NAME}Config.cmake"
	"${PROJECT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
	DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}"
	COMPONENT Devel)
