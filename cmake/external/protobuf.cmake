find_package(ZLIB REQUIRED)

set(Protobuf_INCLUDE_DIRS ${CMAKE_CURRENT_BINARY_DIR}/protobuf_project/src/protobuf/src)
set(Protobuf_URL https://github.com/google/protobuf)

if (MSVC)
    set(Protobuf_ADDITIONAL_CMAKE_OPTIONS "${Protobuf_ADDITIONAL_CMAKE_OPTIONS} -G \"NMake MakeFiles\"")
endif()

ExternalProject_Add(Protobuf_project
        PREFIX Protobuf
        GIT_REPOSITORY ${Protobuf_URL}
        GIT_TAG "v${Protobuf_VERSION}"
        DOWNLOAD_DIR "${DOWNLOAD_LOCATION}"
        UPDATE_COMMAND ""
        BUILD_IN_SOURCE 1
        SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/protobuf_project/src/protobuf
        CONFIGURE_COMMAND ${CMAKE_COMMAND} cmake/
        -Dprotobuf_BUILD_TESTS=OFF
        -DBUILD_STATIC_LIBS=ON
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON
        ${Protobuf_ADDITIONAL_CMAKE_OPTIONS}
        INSTALL_COMMAND ""
        CMAKE_CACHE_ARGS
        -DCMAKE_BUILD_TYPE:STRING=Release
        -DCMAKE_VERBOSE_MAKEFILE:BOOL=OFF
        -DCMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON)

add_library(Protobuf STATIC IMPORTED)
set_property(TARGET Protobuf PROPERTY IMPORTED_LOCATION ${CMAKE_CURRENT_BINARY_DIR}/protobuf_project/src/protobuf/libprotobuf.a)
add_dependencies(Protobuf Protobuf_project)
set(Protobuf_LIBRARIES "")
list(APPEND Protobuf_LIBRARIES Protobuf ${ZLIB_LIBRARIES})

UNSET(Protobuf_PROTOC_EXECUTABLE CACHE)
ADD_EXECUTABLE(Protobuf_PROTOC_EXECUTABLE IMPORTED)
SET_PROPERTY(TARGET Protobuf_PROTOC_EXECUTABLE PROPERTY IMPORTED_LOCATION ${CMAKE_CURRENT_BINARY_DIR}/protobuf_project/src/protobuf/protoc)
ADD_DEPENDENCIES(Protobuf_PROTOC_EXECUTABLE Protobuf_project)

SET(Protobuf_PROTOC_EXECUTABLE Protobuf_PROTOC_EXECUTABLE)
