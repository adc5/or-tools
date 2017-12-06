set_property(DIRECTORY PROPERTY EP_BASE dependencies)

set(ADD_CXXFLAGS "-DCBC_THREAD_SAFE -DCBC_NO_INTERRUPT")

foreach (COIN_PROJECT CoinUtils Osi Clp Cgl Cbc)
    set(${COIN_PROJECT}_URL https://github.com/coin-or/${COIN_PROJECT}.git)

    ExternalProject_Add(${COIN_PROJECT}_project
      GIT_REPOSITORY ${${COIN_PROJECT}_URL}
      GIT_TAG "releases/${${COIN_PROJECT}_VERSION}"
			INSTALL_DIR dependencies/Install/coin
			BUILD_IN_SOURCE 1
      UPDATE_COMMAND ""
			CONFIGURE_COMMAND <SOURCE_DIR>/configure
      --enable-silent-rules --disable-bzlib --without-lapack --with-pic
			--enable-static --prefix=<INSTALL_DIR>
      ADD_CXXFLAGS=${ADD_CXXFLAGS}
			TEST_COMMAND ""
			)

		ExternalProject_Get_Property(${COIN_PROJECT}_project source_dir)
		ExternalProject_Get_Property(${COIN_PROJECT}_project install_dir)

		# Old way
		set(${COIN_PROJECT}_INCLUDE_DIRS ${install_dir}/include/coin)
		set(${COIN_PROJECT}_LIBRARIES ${COIN_PROJECT})

		# Library
		add_library(${COIN_PROJECT} STATIC IMPORTED)
		set_property(TARGET ${COIN_PROJECT} PROPERTY IMPORTED_LOCATION
			${install_dir}/lib/${CMAKE_FIND_LIBRARY_PREFIXES}${COIN_PROJECT}.a)
    set_property(TARGET ${COIN_PROJECT} PROPERTY INCLUDE_DIRECTORIES ${install_dir}/include/coin>)

		# Manage OsiCbc  CbcSolver OsiClp ClpSolver
    if (${COIN_PROJECT} STREQUAL "Cbc" OR ${COIN_PROJECT} STREQUAL "Clp")
			add_library(Osi${COIN_PROJECT} STATIC IMPORTED)
			set_property(TARGET Osi${COIN_PROJECT} PROPERTY IMPORTED_LOCATION
				${install_dir}/lib/libOsi${COIN_PROJECT}.a)
    	set_property(TARGET Osi${COIN_PROJECT} PROPERTY INCLUDE_DIRECTORIES
				${install_dir}/include/coin>)
			add_library(${COIN_PROJECT}Solver STATIC IMPORTED)
			set_property(TARGET ${COIN_PROJECT}Solver PROPERTY IMPORTED_LOCATION
				${install_dir}/lib/lib${COIN_PROJECT}Solver.a)
			set_property(TARGET ${COIN_PROJECT}Solver PROPERTY INCLUDE_DIRECTORIES
				${install_dir}/include/coin>)
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
