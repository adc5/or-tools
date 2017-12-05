cmake_minimum_required(VERSION 3.5)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include(ORToolsHelpers)
set_version(ORTOOLS_VERSION)
message(STATUS "Or-Tools Version: ${ORTOOLS_VERSION}")
project(ortools LANGUAGES CXX VERSION ${ORTOOLS_VERSION})

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

check_target(Protobuf)
check_target(gflags)
check_target(glog)
check_target(Cbc)
#check_target(absl)

# Main Target
add_library(${PROJECT_NAME} "")
set_target_properties(${PROJECT_NAME} PROPERTIES CMAKE_CXX_STANDARD 11)
set_target_properties(${PROJECT_NAME} PROPERTIES CMAKE_CXX_STANDARD_REQUIRED ON)
set_target_properties(${PROJECT_NAME} PROPERTIES CMAKE_CXX_EXTENSIONS OFF)
set_target_properties(${PROJECT_NAME} PROPERTIES POSITION_INDEPENDENT_CODE ON)
set_target_properties(${PROJECT_NAME} PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(${PROJECT_NAME}
	${Protobuf_LIBRARIES}
	${gflags_LIBRARIES}
	${glog_LIBRARIES}
	${Cbc_LIBRARIES}
	${CMAKE_THREAD_LIBS_INIT})

include_directories(${PROJECT_SOURCE_DIR})

# Generate/Build Protobuf sources
include_directories(${Protobuf_INCLUDE_DIRS})
include_directories(${CMAKE_CURRENT_BINARY_DIR})
file(GLOB_RECURSE PROTO_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "*.proto")
message(STATUS "proto files: ${PROTO_FILES}")
protobuf_generate_cpp(PROTO_SRCS PROTO_HDRS ${PROTO_FILES})
protobuf_generate_cpp(PROTO_SRCS PROTO_HDRS EXPORT_MACRO DLL_EXPORT	${PROTO_FILES})
add_library(${PROJECT_NAME}_proto OBJECT ${PROTO_SRCS} ${PROTO_HDRS})
set_target_properties(${PROJECT_NAME}_proto PROPERTIES POSITION_INDEPENDENT_CODE ON)
target_sources(${PROJECT_NAME} PUBLIC $<TARGET_OBJECTS:${PROJECT_NAME}_proto>)
# add_dependencies() really Needed ?
add_dependencies(${PROJECT_NAME} ${PROJECT_NAME}_proto)

foreach(SUBPROJECT base port	util data lp_data glop graph algorithms sat	bop
		linear_solver	constraint_solver)
	add_subdirectory(ortools/${SUBPROJECT})
	target_sources(${PROJECT_NAME} PUBLIC $<TARGET_OBJECTS:${PROJECT_NAME}_${SUBPROJECT}>)
	# add_dependencies() really Needed ?
	add_dependencies(${PROJECT_NAME}_${SUBPROJECT} ${PROJECT_NAME}_proto)
endforeach()

if(ORTOOLS_BUILD_TESTS)
	enable_testing()
endif()

# Install rules
include(GNUInstallDirs)
install(TARGETS ${PROJECT_NAME}
	EXPORT ${PROJECT_NAME}Targets
	RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
	LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
	ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
	)

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

