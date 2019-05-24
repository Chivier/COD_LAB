onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib Gcolor_Mem_opt

do {wave.do}

view wave
view structure
view signals

do {Gcolor_Mem.udo}

run -all

quit -force
