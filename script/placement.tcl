############################################################
#              CRC TOP - PLACEMENT
############################################################
############################################################
# MODE AND SCENARIO SETUP
############################################################

set mode1 "func"
set corner1 "nom"
set scenario1 "${mode1}::${corner1}"

remove_modes -all
remove_corners -all
remove_scenarios -all

create_mode $mode1
create_corner $corner1

create_scenario \
    -name $scenario1 \
    -mode $mode1 \
    -corner $corner1

current_mode $mode1
current_scenario $scenario1


############################################################
# DESIGN CONSTRAINTS
############################################################

source ./../output/crc_top.sdc


############################################################
# PDK PATH
############################################################

set PDK_PATH ./../ref


############################################################
# PARASITIC TECHNOLOGY
############################################################

set parasitic1 "p1"

set tluplus_filep1 \
    "$PDK_PATH/tech/star_rcxt/saed32nm_1p9m_Cmax.tluplus"

set layer_map_filep1 \
    "$PDK_PATH/tech/star_rcxt/saed32nm_tf_itf_tluplus.map"


set parasitic2 "p2"

set tluplus_filep2 \
    "$PDK_PATH/tech/star_rcxt/saed32nm_1p9m_Cmin.tluplus"

set layer_map_filep2 \
    "$PDK_PATH/tech/star_rcxt/saed32nm_tf_itf_tluplus.map"


read_parasitic_tech \
    -tlup $tluplus_filep1 \
    -layermap $layer_map_filep1 \
    -name p1

read_parasitic_tech \
    -tlup $tluplus_filep2 \
    -layermap $layer_map_filep2 \
    -name p2


set_parasitic_parameters \
    -late_spec p1 \
    -early_spec p2


############################################################
# PLACEMENT OPTION
############################################################

set_app_options \
    -name place.coarse.continue_on_missing_scandef \
    -value true


############################################################
# PIN PLACEMENT
############################################################

place_pins -self


############################################################
# STANDARD CELL PLACEMENT
############################################################

place_opt


############################################################
# LEGALIZE PLACEMENT
############################################################

legalize_placement


############################################################
# CHECK PLACEMENT
############################################################

check_legality


############################################################
# REPORTS
############################################################

report_utilization
report_placement


############################################################
# SAVE PLACEMENT
############################################################

save_block -as crc_top_placement
save_lib


############################################################
# END OF PLACEMENT
############################################################
