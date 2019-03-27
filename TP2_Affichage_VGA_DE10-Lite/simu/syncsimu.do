#avant tout, changer de directory pour se placer dans la librairie de travail
# ou alors rajouter la ligne suivante:
# cd ~/VHDL/myproject

# creation de la librairie de travail work
vlib work

#compilation des fichiers vhdl, l'ordre de compilation est important
#commencer par le package, les composants, le top design, le test-bench et enfin la config
vcom -93 ../src/countVH.vhd
vcom -93 ../src/syncVH.vhd
vcom -93 ../src/syncGen.vhd
vcom -93 SyncGen_tb.vhd

#lancer la simulation avec le nom de la config (si elle existe)
#sinon avec le nom du testbench (si il existe)
#sinon avec le nom du top design
#pour chacun des cas precisez le nom de l'entite, pas le nom du fichier
vsim SyncGen_tb

#pour visualiser tout les signaux du design:
view signals
#view structure
add wave clk
add wave rst
add wave hor_sync
add wave ver_sync
add wave /UUT/c_v
add wave /UUT/c_h


#lance la simulation:
run -all



