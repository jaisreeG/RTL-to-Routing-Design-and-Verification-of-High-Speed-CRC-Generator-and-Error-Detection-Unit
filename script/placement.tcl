################################################################################
#                 CRC_TOP - POWER PLANNING
#                 Power Delivery Network (PDN)
################################################################################
################################################################################
# STEP 1: CREATE POWER AND GROUND NETS
################################################################################

create_net -power VDD
create_net -ground VSS


################################################################################
# CONNECT POWER AND GROUND NETS TO STANDARD CELLS
################################################################################

connect_pg_net -all_blocks -automatic


################################################################################
# STEP 2: CREATE POWER AND GROUND RING
################################################################################

create_pg_ring_pattern core_ring_pattern \
    -horizontal_layer M7 \
    -horizontal_width 0.4 \
    -horizontal_spacing 0.3 \
    -vertical_layer M8 \
    -vertical_width 0.4 \
    -vertical_spacing 0.3


set_pg_strategy core_power_ring \
    -core \
    -pattern {{name: core_ring_pattern} \
              {nets: {VDD VSS}} \
              {offset: {0.5 0.5}}}


compile_pg -strategies core_power_ring


################################################################################
# STEP 3: CREATE POWER MESH
################################################################################

create_pg_mesh_pattern mesh \
    -layers { \
        {{vertical_layer: M6} \
         {width: 0.34} \
         {spacing: interleaving} \
         {pitch: 5} \
         {offset: 0.5}} \
        {{horizontal_layer: M7} \
         {width: 0.38} \
         {spacing: interleaving} \
         {pitch: 5} \
         {offset: 0.5}} \
        {{vertical_layer: M8} \
         {width: 0.38} \
         {spacing: interleaving} \
         {pitch: 5} \
         {offset: 0.5}} \
    }


set_pg_strategy core_mesh \
    -pattern {{pattern: mesh} {nets: {VDD VSS}}} \
    -core \
    -extension {stop: innermost_ring}


compile_pg -strategies core_mesh


################################################################################
# STEP 4: CONNECT STANDARD-CELL POWER RAILS
################################################################################

create_pg_std_cell_conn_pattern std_cell_rail \
    -layers {M1} \
    -rail_width 0.06


set_pg_strategy rail_strat \
    -core \
    -pattern {{name: std_cell_rail} {nets: {VDD VSS}}}


compile_pg -strategies rail_strat


################################################################################
# STEP 5: CHECK POWER NETWORK
################################################################################

check_pg_connectivity


################################################################################
# STEP 6: SAVE DESIGN
################################################################################

save_block

save_lib
