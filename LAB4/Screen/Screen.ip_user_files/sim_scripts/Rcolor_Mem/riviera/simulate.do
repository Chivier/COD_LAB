onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+Rcolor_Mem -L dist_mem_gen_v8_0_12 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.Rcolor_Mem xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {Rcolor_Mem.udo}

run -all

endsim

quit -force
