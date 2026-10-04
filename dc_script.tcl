
# ============================================================
# CRC_TOP - DESIGN COMPILER SYNTHESIS SCRIPT
# ============================================================
# ============================================================
# PROJECT SETUP
# ============================================================

set project_path ../

source ../common_setup.tcl

set search_path [list \
    . \
    $project_path/inputs \
    /home/ams5/synopsys/x/SAED32_EDK/lib/stdcell_rvt/db_nldm \
]

set_app_var target_library \
    [list saed32rvt_ss0p75vn40c.db]

set_app_var link_library \
    [list "*" saed32rvt_ss0p75vn40c.db]


# ============================================================
# READ RTL
# ============================================================

read_file -format sverilog ../rtl/crc.sv


# ============================================================
# ELABORATE DESIGN
# ============================================================

elaborate crc_top

current_design crc_top


# ============================================================
# LINK DESIGN
# ============================================================

link


# ============================================================
# DESIGN QUALITY CHECK
# ============================================================

check_design


# ============================================================
# WRITE ELABORATED DESIGN
# ============================================================

write_file -format verilog \
    -output ../output/crc_top_elaborated.v


# ============================================================
# CLOCK DEFINITIONS
# ============================================================

# Testbench clock:
# forever #5 clk = ~clk
# Clock period = 10 ns
# Duty cycle = 50%

create_clock \
    -name CLK \
    -period 10.0 \
    -waveform {0 5} \
    [get_ports clk]

report_clock


# ============================================================
# CLOCK LATENCY AND UNCERTAINTY
# ============================================================

set_clock_latency 0.4 \
    [get_clocks CLK]

set_clock_uncertainty 0.1 \
    [get_clocks CLK]


# ============================================================
# INPUT DELAY
# ============================================================

# All inputs except clock

set DATA_INPUTS \
    [remove_from_collection \
        [all_inputs] \
        [get_ports clk]]


# Maximum input delay

set_input_delay 1.0 \
    -clock CLK \
    $DATA_INPUTS


# Minimum input delay

set_input_delay 0.1 \
    -clock CLK \
    -min \
    $DATA_INPUTS


# ============================================================
# OUTPUT DELAY
# ============================================================

# Maximum output delay

set_output_delay 0.5 \
    -clock CLK \
    [all_outputs]


# Minimum output delay

set_output_delay 0.1 \
    -clock CLK \
    -min \
    [all_outputs]


# ============================================================
# OUTPUT LOAD
# ============================================================

set_load 25 \
    [all_outputs]


# ============================================================
# INPUT TRANSITION
# ============================================================

set_input_transition 0.3 \
    $DATA_INPUTS


# ============================================================
# DESIGN RULE CONSTRAINTS
# ============================================================

set_max_transition 0.5 \
    [current_design]


# ============================================================
# CHECK TIMING CONSTRAINTS
# ============================================================

check_timing

report_port -verbose


# ============================================================
# WRITE CONSTRAINTS
# ============================================================

write_sdc \
    ../output/crc_top.sdc


# ============================================================
# INITIAL COMPILE
# ============================================================

compile


# ============================================================
# WRITE INITIAL NETLIST
# ============================================================

write_file -format verilog \
    -output ../output/crc_top_pre.v


# ============================================================
# FINAL SYNTHESIS
# ============================================================

compile_ultra


# ============================================================
# WRITE FINAL SYNTHESIZED NETLIST
# ============================================================

write_file -format verilog \
    -output ../output/crc_top.v


# ============================================================
# WRITE DDC
# ============================================================

write \
    -format ddc \
    -hierarchy \
    -output ../output/crc_top.ddc


# ============================================================
# WRITE FINAL SDC
# ============================================================

write_sdc \
    ../output/crc_top.sdc


# ============================================================
# REPORT CONSTRAINTS
# ============================================================

report_constraint \
    -all_violators \
    > ../report/constraint.rep


# ============================================================
# REPORT QUALITY OF RESULTS
# ============================================================

report_qor \
    > ../report/qor.rep


# ============================================================
# REPORT AREA
# ============================================================

report_area \
    > ../report/area.rep


# ============================================================
# REPORT TIMING
# ============================================================

report_timing \
    > ../report/timing.rep


# ============================================================
# REPORT POWER
# ============================================================

report_power \
    > ../report/power.rep


# ============================================================
# FINAL DESIGN CHECK
# ============================================================

check_design

check_timing


# ============================================================
# END
# ============================================================

exit
```
