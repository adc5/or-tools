set(ADD_CXXFLAGS "-DCBC_THREAD_SAFE -DCBC_NO_INTERRUPT")

foreach (COIN_PROJECT CoinUtils Osi Clp Cgl Cbc)
    SET(${COIN_PROJECT}_URL https://github.com/coin-or/${COIN_PROJECT}.git)
    SET(${COIN_PROJECT}_INCLUDE_DIRS ${CMAKE_CURRENT_BINARY_DIR}/install/include/coin)

    ExternalProject_Add(${COIN_PROJECT}_project
			#PREFIX ${COIN_PROJECT}
      GIT_REPOSITORY ${${COIN_PROJECT}_URL}
      GIT_TAG "releases/${${COIN_PROJECT}_VERSION}"
			#DOWNLOAD_DIR "${DOWNLOAD_LOCATION}"
			SOURCE_DIR ${CMAKE_BINARY_DIR}/${COIN_PROJECT}-src
			BUILD_IN_SOURCE 1
      UPDATE_COMMAND ""
      CONFIGURE_COMMAND ${CMAKE_BINARY_DIR}/${COIN_PROJECT}-src/configure
      --enable-silent-rules --disable-bzlib --without-lapack --with-pic
			--enable-static --prefix=${CMAKE_BINARY_DIR}/${COIN_PROJECT}-build
      ADD_CXXFLAGS=${ADD_CXXFLAGS}
			)

		# Specify include dir
		ExternalProject_Get_Property(${COIN_PROJECT}_project source_dir)
		set(${COIN_PROJECT}_INCLUDE_DIRS ${source_dir}/include)

		# Library
		ExternalProject_Get_Property(${COIN_PROJECT}_project binary_dir)
		set(${COIN_PROJECT}_LIBRARY_PATH
			${binary_dir}/lib/${CMAKE_FIND_LIBRARY_PREFIXES}${COIN_PROJECT}.a)
		set(${COIN_PROJECT}_LIBRARY ${COIN_PROJECT})
		add_library(${${COIN_PROJECT}_LIBRARY} STATIC IMPORTED)
		set_property(TARGET ${${COIN_PROJECT}_LIBRARY} PROPERTY IMPORTED_LOCATION
			${${COIN_PROJECT}_LIBRARY_PATH})
		set(${COIN_PROJECT}_LIBRARIES ${COIN_PROJECT})

		# Manage OsiCbc  CbcSolver OsiClp ClpSolver
    if (${COIN_PROJECT} STREQUAL "Cbc" OR ${COIN_PROJECT} STREQUAL "Clp")
			add_library(Osi${COIN_PROJECT} STATIC IMPORTED)
			set_property(TARGET Osi${COIN_PROJECT} PROPERTY IMPORTED_LOCATION
				${binary_dir}/lib/libOsi${COIN_PROJECT}.a)
			add_library(${COIN_PROJECT}Solver STATIC IMPORTED)
			set_property(TARGET ${COIN_PROJECT}Solver PROPERTY IMPORTED_LOCATION
				${binary_dir}/lib/lib${COIN_PROJECT}Solver.a)
    endif()

    add_dependencies(${COIN_PROJECT} ${COIN_PROJECT}_project)
endforeach()
set(Cbc_LIBRARIES Cbc OsiCbc CbcSolver ClpSolver OsiClp)

set_property(TARGET Osi PROPERTY INTERFACE_LINK_LIBRARIES CoinUtils)
set_property(TARGET Clp PROPERTY INTERFACE_LINK_LIBRARIES Osi)
set_property(TARGET OsiClp PROPERTY INTERFACE_LINK_LIBRARIES Clp)
set_property(TARGET ClpSolver PROPERTY INTERFACE_LINK_LIBRARIES Clp)
set_property(TARGET Cgl PROPERTY INTERFACE_LINK_LIBRARIES Clp)
set_property(TARGET Cbc PROPERTY INTERFACE_LINK_LIBRARIES Cgl)
set_property(TARGET OsiCbc PROPERTY INTERFACE_LINK_LIBRARIES Cbc)
set_property(TARGET CbcSolver PROPERTY INTERFACE_LINK_LIBRARIES Cbc)

add_dependencies(Osi_project CoinUtils_project)
add_dependencies(Clp_project Osi_project)
add_dependencies(Cgl_project Clp_project)
add_dependencies(Cbc_project Cgl_project)
