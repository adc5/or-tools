set(Protobuf_URL https://github.com/google/protobuf)
find_package(ZLIB REQUIRED)

if (MSVC)
    set(Protobuf_ADDITIONAL_CMAKE_OPTIONS "${Protobuf_ADDITIONAL_CMAKE_OPTIONS} -G \"NMake MakeFiles\"")
endif()

set_property(DIRECTORY PROPERTY EP_BASE dependencies)

ExternalProject_Add(Protobuf_project
	GIT_REPOSITORY ${Protobuf_URL}
	GIT_TAG "v${Protobuf_VERSION}"
	UPDATE_COMMAND ""
	CONFIGURE_COMMAND ${CMAKE_COMMAND} <SOURCE_DIR>/cmake
	-DBUILD_STATIC_LIBS=ON
	-Dprotobuf_BUILD_TESTS=OFF
	-DCMAKE_POSITION_INDEPENDENT_CODE=ON
	${Protobuf_ADDITIONAL_CMAKE_OPTIONS}
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
ExternalProject_Get_Property(Protobuf_project binary_dir)

# Old way
set(Protobuf_INCLUDE_DIRS ${source_dir}/src)
set(Protobuf_LIBRARIES Protobuf ${ZLIB_LIBRARIES})

# Library
add_library(Protobuf STATIC IMPORTED)
set_property(TARGET Protobuf PROPERTY IMPORTED_LOCATION
	${binary_dir}/${CMAKE_FIND_LIBRARY_PREFIXES}protobuf.a)
set_property(TARGET Protobuf PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${source_dir}/src)

add_dependencies(Protobuf Protobuf_project)

unset(Protobuf_PROTOC_EXECUTABLE CACHE)
add_executable(Protobuf_PROTOC_EXECUTABLE IMPORTED)
set_property(TARGET Protobuf_PROTOC_EXECUTABLE PROPERTY IMPORTED_LOCATION
	${binary_dir}/protoc)
set(Protobuf_PROTOC_EXECUTABLE ${binary_dir}/protoc)

add_dependencies(Protobuf_PROTOC_EXECUTABLE Protobuf_project)
