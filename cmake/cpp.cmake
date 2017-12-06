if (NOT BUILD_CXX)
	return()
endif()

include(utils)
set_version(VERSION)
project(ortools LANGUAGES CXX VERSION ${VERSION})

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

# Verify Dependencies
find_package(Threads REQUIRED)

check_target(Protobuf)
check_target(gflags)
check_target(glog)
check_target(Cbc)

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
target_link_libraries(${PROJECT_NAME} PUBLIC Protobuf gflags glog Cbc ${CMAKE_THREAD_LIBS_INIT})

# Generate/Build Protobuf sources
include_directories(${Protobuf_INCLUDE_DIRS})
find_package(Protobuf)
file(GLOB_RECURSE proto_files RELATIVE ${PROJECT_SOURCE_DIR} "ortools/*.proto")

#set(PROTOBUF_IMPORT_DIRS ${PROJECT_SOURCE_DIR})
set(PROTOBUF_GENERATE_CPP_APPEND_PATH OFF)
PROTOBUF_GENERATE_CPP(PROTO_SRCS PROTO_HDRS ${proto_files})
add_library(${PROJECT_NAME}_proto OBJECT ${PROTO_SRCS} ${PROTO_HDRS})
set_target_properties(${PROJECT_NAME}_proto PROPERTIES POSITION_INDEPENDENT_CODE ON)
target_include_directories(${PROJECT_NAME}_proto PRIVATE
	${PROJECT_SOURCE_DIR}
	${PROJECT_BINARY_DIR}
	)

# add_dependencies really Needed ?
add_dependencies(${PROJECT_NAME} ${PROJECT_NAME}_proto)
target_sources(${PROJECT_NAME} PRIVATE $<TARGET_OBJECTS:${PROJECT_NAME}_proto>)

IF(NOT Cbc_FOUND)
    IF(NOT MSVC)
        ADD_DEPENDENCIES(${PROJECT_NAME}_proto Cbc)
    ENDIF()
ENDIF()
IF(NOT glog_FOUND)
    ADD_DEPENDENCIES(${PROJECT_NAME}_proto glog)
ENDIF()

foreach(SUBPROJECT base port util data lp_data glop graph algorithms sat bop
		linear_solver constraint_solver)
    add_subdirectory(ortools/${SUBPROJECT})
		target_include_directories(${PROJECT_NAME}_${SUBPROJECT} PRIVATE
			${PROJECT_SOURCE_DIR}
			${PROJECT_BINARY_DIR}
			)
		target_sources(${PROJECT_NAME} PRIVATE $<TARGET_OBJECTS:${PROJECT_NAME}_${SUBPROJECT}>)
	# add_dependencies really Needed ?
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
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
		)

install(DIRECTORY ortools
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    COMPONENT Devel
    FILES_MATCHING PATTERN "*.h")
	install(DIRECTORY ${PROJECT_BINARY_DIR}/ortools
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    COMPONENT Devel
    FILES_MATCHING
		PATTERN "*.pb.h"
    PATTERN CMakeFiles EXCLUDE)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
	"${PROJECT_BINARY_DIR}/ortools/${PROJECT_NAME}ConfigVersion.cmake"
	COMPATIBILITY SameMajorVersion
	)
install(
	EXPORT ${PROJECT_NAME}Targets
	NAMESPACE ${PROJECT_NAME}::
	DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}"
	)
install(
	FILES
	"${PROJECT_SOURCE_DIR}/ortools/cmake/${PROJECT_NAME}Config.cmake"
	"${PROJECT_BINARY_DIR}/ortools/${PROJECT_NAME}ConfigVersion.cmake"
	DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}"
	COMPONENT Devel)
