set(gflags_URL https://github.com/gflags/gflags)

if (MSVC)
    set(gflags_ADDITIONAL_CMAKE_OPTIONS "-G \"NMake MakeFiles\"")
endif()

ExternalProject_Add(gflags_project
	PREFIX gflags_project
	GIT_REPOSITORY ${gflags_URL}
	GIT_TAG "v${gflags_VERSION}"
	SOURCE_DIR ${CMAKE_BINARY_DIR}/gflags-src
	BINARY_DIR ${CMAKE_BINARY_DIR}/gflags-build
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

# Specify include dir
set(gflags_INCLUDE_DIRS ${binary_dir}/include)

# Library
set(gflags_LIBRARY_PATH ${binary_dir}/lib/${CMAKE_FIND_LIBRARY_PREFIXES}gflags.a)
set(gflags_LIBRARY gflags)
add_library(${gflags_LIBRARY} STATIC IMPORTED)
set_property(TARGET ${gflags_LIBRARY} PROPERTY IMPORTED_LOCATION
	${gflags_LIBRARY_PATH})
set(gflags_LIBRARIES gflags)

add_dependencies(${gflags_LIBRARY} gflags_project)
