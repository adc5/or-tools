set(Protobuf_URL https://github.com/google/protobuf)
find_package(ZLIB REQUIRED)

if (MSVC)
    set(Protobuf_ADDITIONAL_CMAKE_OPTIONS "${Protobuf_ADDITIONAL_CMAKE_OPTIONS} -G \"NMake MakeFiles\"")
endif()

ExternalProject_Add(Protobuf_project
	#PREFIX Protobuf
	GIT_REPOSITORY ${Protobuf_URL}
	GIT_TAG "v${Protobuf_VERSION}"
	#DOWNLOAD_DIR "${DOWNLOAD_LOCATION}"
	SOURCE_DIR ${CMAKE_BINARY_DIR}/Protobuf-src
	BINARY_DIR ${CMAKE_BINARY_DIR}/Protobuf-build
	#BUILD_IN_SOURCE 1
	UPDATE_COMMAND ""
	CONFIGURE_COMMAND ${CMAKE_COMMAND}
	-DBUILD_STATIC_LIBS=ON
	-Dprotobuf_BUILD_TESTS=OFF
	-DCMAKE_POSITION_INDEPENDENT_CODE=ON
	${Protobuf_ADDITIONAL_CMAKE_OPTIONS}
	../Protobuf-src/cmake
	BUILD_COMMAND ""
	INSTALL_COMMAND ""
	TEST_COMMAND ""
	CMAKE_CACHE_ARGS
	-DCMAKE_BUILD_TYPE:STRING=Release
	-DCMAKE_VERBOSE_MAKEFILE:BOOL=OFF
	-DCMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON
	LOG_DOWNLOAD ON
	LOG_CONFIGURE ON
	LOG_BUILD ON
	)

# Specify include dir
ExternalProject_Get_Property(Protobuf_project source_dir)
set(Protobuf_INCLUDE_DIRS ${source_dir}/include)

# Library
ExternalProject_Get_Property(Protobuf_project binary_dir)
set(Protobuf_LIBRARY_PATH ${binary_dir}/${CMAKE_FIND_LIBRARY_PREFIXES}Protobuf.a)
set(Protobuf_LIBRARY Protobuf)
add_library(${Protobuf_LIBRARY} STATIC IMPORTED)
set_property(TARGET ${Protobuf_LIBRARY} PROPERTY IMPORTED_LOCATION
	${Protobuf_LIBRARY_PATH})
set(Protobuf_LIBRARIES Protobuf ${ZLIB_LIBRARIES})

add_dependencies(${Protobuf_LIBRARY} Protobuf_project)

unset(Protobuf_PROTOC_EXECUTABLE CACHE)
add_executable(Protobuf_PROTOC_EXECUTABLE IMPORTED)
set_property(TARGET Protobuf_PROTOC_EXECUTABLE PROPERTY IMPORTED_LOCATION
	${binary_dir}/protoc)
	#	${CMAKE_BINARY_DIR}/protobuf_project/src/protobuf/protoc)
set(Protobuf_PROTOC_EXECUTABLE Protobuf_PROTOC_EXECUTABLE)

add_dependencies(Protobuf_PROTOC_EXECUTABLE Protobuf_project)
