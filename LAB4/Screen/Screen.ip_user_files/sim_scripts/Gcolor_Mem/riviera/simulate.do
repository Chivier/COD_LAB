onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+Gcolor_Mem -L dist_mem_gen_v8_0_12 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.Gcolor_Mem xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {Gcolor_Mem.udo}

run -all

endsim

quit -force
