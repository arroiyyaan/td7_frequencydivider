#######################################################
#
# contient toutes les informations dépendant du design 
#
#######################################################
set DESIGN_NAME compteur_gray


set_db hdl_use_cw_first true 

# definit les chemins vers les fichiers
set_db init_hdl_search_path  ../SOURCES

#
# charge le design
#
read_hdl -vhdl [list  \
    ../SOURCES/td4/myfuncs_package.vhd \
    ../SOURCES/td4/myfuncs_body.vhd \
    ../SOURCES/td4/compteur_gray_e.vhd \
    ../SOURCES/td4/compteur_gray_a5.vhd \
]

#
# conserve la hiérarchie des processus en créant des groupes pour chaque processus
#
set_db [get_db hdl_procedures *P0] .group P0
set_db [get_db hdl_procedures *P1] .group P1
set_db [get_db hdl_procedures *P2] .group P2
set_db [get_db hdl_procedures *P3] .group P3
set_db [get_db hdl_procedures *P4] .group P4

#
# elaboration
#
elaborate

# contrainte pour forcer à conserver la hiérarchie
set_db [get_db hinsts *P*]   .ungroup_ok false


