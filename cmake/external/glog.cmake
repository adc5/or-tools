set(glog_URL https://github.com/google/glog)
#SET(glog_INCLUDE_DIRS ${CMAKE_CURRENT_BINARY_DIR}/glog_project/src/glog/)
#LIST(APPEND glog_INCLUDE_DIRS ${CMAKE_CURRENT_BINARY_DIR}/glog_project/src/glog/src/)

if (NOT gflags_FOUND)
    ExternalProject_Get_Property(gflags_project source_dir)
    SET(glog_ADDITIONAL_CMAKE_OPTIONS "-DCMAKE_PREFIX_PATH=${source_dir}")
endif()

if (MSVC)
    set(gflags_ADDITIONAL_CMAKE_OPTIONS "${glog_ADDITIONAL_CMAKE_OPTIONS} -G \"NMake MakeFiles\"")
endif()

ExternalProject_Add(glog_project
	#PREFIX glog
	GIT_REPOSITORY ${glog_URL}
	GIT_TAG "v${glog_VERSION}"
	#DOWNLOAD_DIR "${DOWNLOAD_LOCATION}"
	SOURCE_DIR ${CMAKE_BINARY_DIR}/glog-src
	BINARY_DIR ${CMAKE_BINARY_DIR}/glog-build
	#BUILD_IN_SOURCE 1
	UPDATE_COMMAND ""
	PATCH_COMMAND git am -3 ${CMAKE_SOURCE_DIR}/patches/glog_includedir_fix.patch
	CONFIGURE_COMMAND ${CMAKE_COMMAND}
	-DWITH_GFLAGS=ON
	-DBUILD_TESTING=OFF
	-DCMAKE_POSITION_INDEPENDENT_CODE=ON
	${glog_ADDITIONAL_CMAKE_OPTIONS}
	../glog-src
	BUILD_COMMAND ""
	INSTALL_COMMAND ""
	CMAKE_CACHE_ARGS
	-DCMAKE_BUILD_TYPE:STRING=Release
	-DCMAKE_VERBOSE_MAKEFILE:BOOL=OFF
	-DCMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON
	LOG_DOWNLOAD ON
	LOG_CONFIGURE ON
	LOG_BUILD ON
	)

if(NOT gflags_FOUND)
    add_dependencies(glog_project gflags_project)
endif()

# Specify include dir
ExternalProject_Get_Property(glog_project source_dir)
set(glog_INCLUDE_DIRS ${source_dir}/include)

# Library
ExternalProject_Get_Property(glog_project binary_dir)
set(glog_LIBRARY_PATH ${binary_dir}/${CMAKE_FIND_LIBRARY_PREFIXES}glog.a)
set(glog_LIBRARY glog)
add_library(${glog_LIBRARY} STATIC IMPORTED)
set_property(TARGET ${glog_LIBRARY} PROPERTY IMPORTED_LOCATION
	${glog_LIBRARY_PATH})
set(glog_LIBRARIES glog)

add_dependencies(${glog_LIBRARY} glog_project)
