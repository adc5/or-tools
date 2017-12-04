cmake_minimum_required(VERSION 3.5)
project(ortools-meta NONE)

include(CTest)

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

include(GNUInstallDirs)
include(CMakeDependentOption)

option(BUILD_CXX "Build C++ library" ON)
CMAKE_DEPENDENT_OPTION(BUILD_PYTHON "Build Python Library" ON "BUILD_CXX" OFF)
set(DOWNLOAD_LOCATION "${CMAKE_CURRENT_BINARY_DIR}/dependencies/sources" CACHE PATH "Location where external projects will be downloaded.")
mark_as_advanced(DOWNLOAD_LOCATION)
option(BUILD_DEPS "Force re-build of all dependencies" OFF)

message(STATUS "Build CXX library: ${BUILD_CXX}")
message(STATUS "Build Python library: ${BUILD_PYTHON}")
message(STATUS "Build all dependencies: ${BUILD_DEPS}")

if (BUILD_CXX)
    include(dependencies)
    include(cpp)
		#add_subdirectory(ortools)
		#add_subdirectory(examples/cpp)
endif()

if (BUILD_PYTHON)
    include(python)
		#add_subdirectory(examples/python)
endif()
