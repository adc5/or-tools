set(gflags_URL https://github.com/gflags/gflags)

if (MSVC)
    set(gflags_ADDITIONAL_CMAKE_OPTIONS "-G \"NMake MakeFiles\"")
endif()

set_property(DIRECTORY PROPERTY EP_BASE dependencies)

ExternalProject_Add(gflags_project
	GIT_REPOSITORY ${gflags_URL}
	GIT_TAG "v${gflags_VERSION}"
	UPDATE_COMMAND ""
	CONFIGURE_COMMAND ${CMAKE_COMMAND} <SOURCE_DIR>
	-DBUILD_STATIC_LIBS=ON
	-DBUILD_TESTING=OFF
	-DCMAKE_POSITION_INDEPENDENT_CODE=ON
	${gflags_ADDITIONAL_CMAKE_OPTIONS}
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

ExternalProject_Get_Property(gflags_project source_dir)
ExternalProject_Get_Property(gflags_project binary_dir)

# Old way
set(gflags_INCLUDE_DIRS ${binary_dir}/include)
set(gflags_LIBRARIES gflags)

# Library
add_library(gflags STATIC IMPORTED)
set_property(TARGET gflags PROPERTY IMPORTED_LOCATION
	${binary_dir}/lib/${CMAKE_FIND_LIBRARY_PREFIXES}gflags.a)
set_property(TARGET gflags PROPERTY INTERFACE_INCLUDE_DIRECTORIES
	${binary_dir}/include)

add_dependencies(gflags gflags_project)
