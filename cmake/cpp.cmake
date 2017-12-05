if (NOT BUILD_CXX)
	return()
endif()

include(utils)
set_version(VERSION)
project(ortools LANGUAGES CXX VERSION ${VERSION})

# Verify Dependencies
find_package(Threads REQUIRED)

check_target(Protobuf)
check_target(gflags)
check_target(glog)
check_target(Cbc)

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
        ${CMAKE_THREAD_LIBS_INIT}
				)

#include_directories(${CMAKE_SOURCE_DIR})

# Generate/Build Protobuf sources
find_package(Protobuf)
include_directories(${Protobuf_INCLUDE_DIRS})
include_directories(${CMAKE_CURRENT_BINARY_DIR})
file(GLOB_RECURSE proto_files RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "ortools/*.proto")
PROTOBUF_GENERATE_CPP(PROTO_SRCS PROTO_HDRS ${proto_files})
#ADD_CUSTOM_TARGET(${PROJECT_NAME}ProtoSources ALL DEPENDS ${PROTO_SRCS})
add_library(${PROJECT_NAME}_proto OBJECT ${PROTO_SRCS} ${PROTO_HDRS})
set_target_properties(${PROJECT_NAME}_proto PROPERTIES POSITION_INDEPENDENT_CODE ON)
target_sources(${PROJECT_NAME} PUBLIC $<TARGET_OBJECTS:${PROJECT_NAME}_proto>)
# add_dependencies really Needed ?
add_dependencies(${PROJECT_NAME} ${PROJECT_NAME}_proto)

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
		target_sources(${PROJECT_NAME} PUBLIC	$<TARGET_OBJECTS:${PROJECT_NAME}_${SUBPROJECT}>)
	# add_dependencies really Needed ?
		add_dependencies(${PROJECT_NAME}_${SUBPROJECT} ${PROJECT_NAME}_proto)
endforeach()

# Install rules
include(GenerateExportHeader)
GENERATE_EXPORT_HEADER(${PROJECT_NAME})
SET_PROPERTY(TARGET ${PROJECT_NAME} PROPERTY VERSION ${PROJECT_VERSION})
SET_PROPERTY(TARGET ${PROJECT_NAME} PROPERTY SOVERSION ${PROJECT_VERSION_MAJOR})
SET_PROPERTY(TARGET ${PROJECT_NAME} PROPERTY INTERFACE_${PROJECT_NAME}_MAJOR_VERSION ${PROJECT_VERSION_MAJOR})
SET_PROPERTY(TARGET ${PROJECT_NAME} APPEND PROPERTY COMPATIBLE_INTERFACE_STRING ${PROJECT_NAME}_MAJOR_VERSION)

include(GNUInstallDirs)
INSTALL(TARGETS ${PROJECT_NAME}
    EXPORT ${PROJECT_NAME}Targets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
INSTALL(DIRECTORY ortools
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    COMPONENT Devel
    FILES_MATCHING PATTERN "*.h")
INSTALL(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/ortools
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    COMPONENT Devel
    FILES_MATCHING PATTERN "*.pb.h"
    PATTERN CMakeFiles EXCLUDE)

include(CMakePackageConfigHelpers)
WRITE_BASIC_PACKAGE_VERSION_FILE("${CMAKE_CURRENT_BINARY_DIR}/ortools/${PROJECT_NAME}ConfigVersion.cmake"
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY AnyNewerVersion)
EXPORT(EXPORT ${PROJECT_NAME}Targets
    FILE "${CMAKE_CURRENT_BINARY_DIR}/ortools/${PROJECT_NAME}Targets.cmake"
    NAMESPACE ${PROJECT_NAME}::)
CONFIGURE_FILE(cmake/ortoolsConfig.cmake.in
    "${CMAKE_CURRENT_BINARY_DIR}/ortools/${PROJECT_NAME}Config.cmake"
    @ONLY)

SET(ConfigPackageLocation ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})
INSTALL(EXPORT ${PROJECT_NAME}Targets
    FILE ${PROJECT_NAME}Targets.cmake
    NAMESPACE ${PROJECT_NAME}::
    DESTINATION ${ConfigPackageLocation})
INSTALL(FILES
    "${CMAKE_CURRENT_BINARY_DIR}/ortools/${PROJECT_NAME}Config.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/ortools/${PROJECT_NAME}ConfigVersion.cmake"
    DESTINATION ${ConfigPackageLocation}
    COMPONENT Devel)
