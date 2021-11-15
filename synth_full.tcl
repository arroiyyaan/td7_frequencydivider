#######################################################
# Ce programme a été développé à CENTRALE-SUPELEC
# Merci de conserver ce cartouche
# Copyright  (c) 2020  CENTRALE-SUPELEC   
# Département Systèmes électroniques
# ---------------------------------------------------
#
# fichier : synth_full.tcl
# auteur  : P.BENABES   
# Copyright (c) 2020 CENTRALE-SUPELEC
# Revision: 3.70  Date: 01/02/2020
#
# ---------------------------------------------------
# ---------------------------------------------------
#
# DESCRIPTION DU SCRIPT :
#   ce script permet de lancer une synthèse complete 
#   du ciruit
#
#######################################################

# 
# Réglages de multithreadingc
# 
set_db max_cpus_per_server 8 
set_db super_thread_servers "localhost" 
set_db optimize_constant_0_flops false
set_db optimize_constant_1_flops false

  
# *********************************************************
# chargement du design et des informations physiques
# *********************************************************

source libraries.tcl
source design4.tcl
init_design

set_db lp_power_unit uW 
uniquify $DESIGN_NAME

# autorise la mise en place des pull up et pull down
set_db use_tiehilo_for_const  duplicate


# *********************************************************
# synthese initiale
# *********************************************************
set_db syn_global_effort high
#set_db [get_db modules *]  .retime true 

syn_generic 
syn_map 

# *********************************************************
# réalise l'optimisation de la synthese 
# *********************************************************

set_db syn_opt_effort high     
syn_opt


# *********************************************************
# génère les fichiers de rapport 
# *********************************************************
report_qor                       > qor.txt
report_timing -cost_group clock1 > timing1.txt
report_timing -cost_group clock2 > timing2.txt
report_area                      > area.txt

# *********************************************************
# génère les fichiers résultat 
# *********************************************************
write_hdl                             > ${DESIGN_NAME}.v
write_sdc  -view typ_functional_mode  > ${DESIGN_NAME}.sdc


