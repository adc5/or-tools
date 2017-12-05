if (NOT BUILD_CXX)
  return()
endif()

include(GNUInstallDirs)

add_library(${PROJECT_NAME}_examples SHARED
        cvrptw_lib.cc
        parse_dimacs_assignment.cc
        fap_model_printer.cc
        fap_parser.cc
        fap_utilities.cc)
target_link_libraries(${PROJECT_NAME}_examples ${PROJECT_NAME})
add_dependencies(${PROJECT_NAME}_examples ${PROJECT_NAME}_proto)

install(TARGETS ${PROJECT_NAME}_examples
            EXPORT ${PROJECT_NAME}_Exports
            ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
            LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
            RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

foreach(EXECUTABLE
        costas_array
        cryptarithm
        cvrp_disjoint_tw
        cvrptw
        cvrptw_with_breaks
        cvrptw_with_refueling
        cvrptw_with_resources
        cvrptw_with_stop_times_and_resources
        dimacs_assignment
        dobble_ls
        flow_api
        frequency_assignment_problem
        golomb
        integer_programming
        jobshop
        jobshop_earlytardy
        jobshop_ls
        jobshop_sat
        linear_assignment_api
        linear_programming
        linear_solver_protocol_buffers
        ls_api
        magic_square
        model_util
        mps_driver
        multidim_knapsack
        network_routing
        nqueens
        pdptw
        rcpsp_sat
        shift_minimization_sat
        solve
        sports_scheduling
        strawberry_fields_with_column_generation
        tsp
        weighted_tardiness_sat)
    add_executable(${EXECUTABLE}_example ${EXECUTABLE}.cc)
    target_link_libraries(${EXECUTABLE}_example ${PROJECT_NAME}_examples ${PROJECT_NAME})
		add_test(NAME ${EXECUTABLE}_example COMMAND ${EXECUTABLE}_example)
    install(TARGETS ${EXECUTABLE}_example RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
ENDFOREACH()
