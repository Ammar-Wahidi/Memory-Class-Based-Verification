Vlog Memory.sv Memory_package.sv Memory_tb.sv +cover
vsim Memory_tb -novopt -cover -coverage -suppress 12110 
add wave -r /*
add wave -position end  /Memory_tb/DUT/memory
coverage save Memory_tb.ucdb -onexit
run -all; 
vcover report Memory_tb.ucdb -details -all -annotate -output mem_ENV_cvr.txt