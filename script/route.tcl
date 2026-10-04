
############################################################
#                 CRC_TOP - ROUTING
############################################################
############################################################
# ROUTING APP OPTIONS
############################################################

# Global route

set_app_options \
    -name route.global.timing_driven \
    -value true

set_app_options \
    -name route.global.crosstalk_driven \
    -value false


# Track assignment

set_app_options \
    -name route.track.timing_driven \
    -value true

set_app_options \
    -name route.track.crosstalk_driven \
    -value true


# Detailed route

set_app_options \
    -name route.detail.timing_driven \
    -value true

set_app_options \
    -name route.detail.save_after_iterations \
    -value false

set_app_options \
    -name route.detail.force_max_number_iterations \
    -value false

set_app_options \
    -name route.detail.antenna \
    -value true

set_app_options \
    -name route.detail.antenna_fixing_preference \
    -value use_diodes


############################################################
# ANTENNA DIODE CELL
############################################################

set antenna_cells [get_lib_cells */ANTENNA_RVT]

if {[sizeof_collection $antenna_cells] > 0} {

    set_app_options \
        -name route.detail.diode_libcell_names \
        -value */ANTENNA_RVT

} else {

    puts "WARNING: ANTENNA_RVT cell was not found in the reference library."
    puts "Antenna diode insertion will not be explicitly specified."

}


############################################################
# GLOBAL ROUTING
############################################################

route_global

save_block -as crc_top_route_global


############################################################
# TRACK ASSIGNMENT
############################################################

route_track

save_block -as crc_top_route_track


############################################################
# DETAILED ROUTING
############################################################

route_detail

save_block -as crc_top_route_detail


############################################################
# ROUTING OPTIMIZATION
############################################################

route_opt


############################################################
# ROUTING CHECKS
############################################################

check_routes


############################################################
# REPORTS
############################################################

report_qor

report_timing

report_area


############################################################
# WRITE FINAL ROUTED NETLIST
############################################################

write_verilog \
    ./../output/crc_top_routed.v


############################################################
# WRITE FINAL SDC
############################################################

write_sdc \
    -output ./../output/crc_top_routed.sdc


############################################################
# WRITE SPEF
############################################################

write_parasitics \
    -format spef \
    -output ./../output/crc_top_func_nom.spef


############################################################
# SAVE FINAL ROUTED DESIGN
############################################################

save_block -as crc_top_routed

save_lib

