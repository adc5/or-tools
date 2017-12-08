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
	set_target_properties(${COIN_PROJECT} PROPERTIES IMPORTED_LOCATION
		${install_dir}/lib/${CMAKE_FIND_LIBRARY_PREFIXES}${COIN_PROJECT}.a)
	# INTERFACE_INCLUDE_DIRECTORIES does not allow non-existent directories
	# cf https://gitlab.kitware.com/cmake/cmake/issues/15052
	file(MAKE_DIRECTORY ${install_dir}/include/coin)
	set_target_properties(${COIN_PROJECT} PROPERTIES INTERFACE_INCLUDE_DIRECTORIES
		${install_dir}/include/coin)
	# Can't Alias imported target.
	#add_library(coin::${COIN_PROJECT} ALIAS ${COIN_PROJECT})
	add_dependencies(${COIN_PROJECT} ${COIN_PROJECT}_project)

	# Manage OsiCbc  CbcSolver OsiClp ClpSolver
	if (${COIN_PROJECT} STREQUAL "Cbc" OR ${COIN_PROJECT} STREQUAL "Clp")
		add_library(Osi${COIN_PROJECT} STATIC IMPORTED)
		set_target_properties(Osi${COIN_PROJECT} PROPERTIES IMPORTED_LOCATION
			${install_dir}/lib/libOsi${COIN_PROJECT}.a)
		set_target_properties(Osi${COIN_PROJECT} PROPERTIES INTERFACE_INCLUDE_DIRECTORIES
			${install_dir}/include/coin)
		# Can't Alias imported target.
		#add_library(coin::Osi${COIN_PROJECT} ALIAS Osi${COIN_PROJECT})
		add_dependencies(Osi${COIN_PROJECT} ${COIN_PROJECT}_project)

		add_library(${COIN_PROJECT}Solver STATIC IMPORTED)
		set_target_properties(${COIN_PROJECT}Solver PROPERTIES IMPORTED_LOCATION
			${install_dir}/lib/lib${COIN_PROJECT}Solver.a)
		set_target_properties(${COIN_PROJECT}Solver PROPERTIES INTERFACE_INCLUDE_DIRECTORIES
			${install_dir}/include/coin)
		# Can't Alias imported target.
		#add_library(coin::${COIN_PROJECT}Solver ALIAS ${COIN_PROJECT}Solver)
		add_dependencies(${COIN_PROJECT}Solver ${COIN_PROJECT}_project)
	endif()
endforeach()

set(Cbc_LIBRARIES Cbc OsiCbc CbcSolver ClpSolver OsiClp)
set_target_properties(Cbc PROPERTIES INTERFACE_LINK_LIBRARIES
	"OsiCbc;CbcSolver;OsiClp;ClpSolver")

set_property(TARGET Osi APPEND PROPERTY INTERFACE_LINK_LIBRARIES CoinUtils)
set_property(TARGET Clp APPEND PROPERTY INTERFACE_LINK_LIBRARIES Osi)
set_property(TARGET OsiClp APPEND PROPERTY INTERFACE_LINK_LIBRARIES Clp)
set_property(TARGET ClpSolver APPEND PROPERTY INTERFACE_LINK_LIBRARIES Clp)
set_property(TARGET Cgl APPEND PROPERTY INTERFACE_LINK_LIBRARIES Clp)
set_property(TARGET Cbc APPEND PROPERTY INTERFACE_LINK_LIBRARIES Cgl)
set_property(TARGET OsiCbc APPEND PROPERTY INTERFACE_LINK_LIBRARIES Cbc)
set_property(TARGET CbcSolver APPEND PROPERTY INTERFACE_LINK_LIBRARIES Cbc)

add_dependencies(Osi_project CoinUtils_project)
add_dependencies(Clp_project Osi_project)
add_dependencies(Cgl_project Clp_project)
add_dependencies(Cbc_project Cgl_project)
