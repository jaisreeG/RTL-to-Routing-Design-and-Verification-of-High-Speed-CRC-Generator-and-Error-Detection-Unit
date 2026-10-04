############################################################
#              CRC_TOP - CLOCK TREE SYNTHESIS
############################################################
############################################################
# PRE-CLOCK SANITY CHECK
############################################################

check_design -checks pre_clock_tree_stage


############################################################
# CLOCK TREE SYNTHESIS USING CCD
############################################################


# Stage 1:
# Synthesize the clock tree

synthesize_clock_trees


############################################################
# STAGE 2:
# Enable CCD and local skew optimization
############################################################

set_app_options \
    -name cts.optimize.enable_local_skew \
    -value true

set_app_options \
    -name cts.compile.enable_local_skew \
    -value true

set_app_options \
    -name cts.compile.enable_global_route \
    -value false

set_app_options \
    -name clock_opt.flow.enable_ccd \
    -value true


############################################################
# BUILD CLOCK
############################################################

clock_opt -to build_clock


############################################################
# STAGE 3:
# CLOCK ROUTING
############################################################

clock_opt -from route_clock -to route_clock


############################################################
# FINAL CLOCK OPTIMIZATION
############################################################

clock_opt


############################################################
# CTS REPORTS
############################################################

report_clock_qor

report_clock_qor \
    -largest 2 \
    -show_verbose_paths


############################################################
# SAVE CTS DESIGN
############################################################

save_block -as crc_top_cts_CCD

save_lib

