onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib Bcolor_Mem_opt

do {wave.do}

view wave
view structure
view signals

do {Bcolor_Mem.udo}

run -all

quit -force
