# Version:1.0 MMMC View Definition File
# Do Not Remove Above Line

# Create library sets


create_library_set -name slow_liberty -timing $LIBSET_SLOWHV
create_library_set -name fast_liberty -timing $LIBSET_FASTHV	 
create_library_set -name typ_liberty -timing  $LIBSET_TYPHV 


create_timing_condition -name typ_timing   -library_sets typ_liberty 
create_timing_condition -name fast_timing  -library_sets fast_liberty 
create_timing_condition -name slow_timing  -library_sets slow_liberty 

# RC corners
create_rc_corner -name typ_rc   -qrc_tech ${XKIT}/cadence/QRC_assura/$XKITOPT/QRC-Typ/qrcTechFile
create_rc_corner -name max_rc   -qrc_tech ${XKIT}/cadence/QRC_assura/$XKITOPT/QRC-Max/qrcTechFile
create_rc_corner -name min_rc   -qrc_tech ${XKIT}/cadence/QRC_assura/$XKITOPT/QRC-Min/qrcTechFile 


# Delay corners
create_delay_corner -name typ_corner   -timing_condition typ_timing   -rc_corner typ_rc 
create_delay_corner -name fast_corner  -timing_condition fast_timing  -rc_corner min_rc
create_delay_corner -name slow_corner  -timing_condition slow_timing  -rc_corner max_rc


# Constraint mode
create_constraint_mode -name functional_mode -sdc_files [list ../GENUS/constraints.tcl] 

# Analysis views
create_analysis_view -name typ_functional_mode  -constraint_mode functional_mode -delay_corner typ_corner
create_analysis_view -name slow_functional_mode -constraint_mode functional_mode -delay_corner slow_corner
create_analysis_view -name fast_functional_mode -constraint_mode functional_mode -delay_corner fast_corner

# apply analysis views
# set_analysis_view -setup {slow_functional_mode} -hold {fast_functional_mode}
set_analysis_view -setup {typ_functional_mode} -hold {typ_functional_mode}

