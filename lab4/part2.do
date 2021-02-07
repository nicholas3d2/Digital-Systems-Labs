vlib work

vlog part2.v

vsim main

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {SW} 0
force {KEY[0]} 0 0ns, 1 {5ns} -r 10ns


#RESET

force {SW[9]} 0
run 5ns

force {SW[9]} 1

#case 0

force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 1

force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1

run 5ns

#RESET

force {SW[9]} 0
run 5ns

force {SW[9]} 1

#case 1

force {KEY[1]} 0
force {KEY[2]} 1
force {KEY[3]} 1

force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1

run 5ns

#RESET

force {SW[9]} 0
run 5ns

force {SW[9]} 1

#case 2?


#case 3

force {KEY[1]} 0
force {KEY[2]} 0
force {KEY[3]} 1

force {SW[0]} 0 0ns, 1 {10ns} 
force {SW[1]} 0 0ns 
force {SW[2]} 0 0ns, 1 {10ns} 
force {SW[3]} 0 0ns, 1 {10ns} 

run 10ns

#RESET

force {SW[9]} 0
run 5ns

force {SW[9]} 1

#case 4

force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 1

force {SW[0]} 1 
force {SW[1]} 1 
force {SW[2]} 1 
force {SW[3]} 1

run 5 ns

force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 0 

run 5ns

#case 5

force {KEY[1]} 0
force {KEY[2]} 1
force {KEY[3]} 0

force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0

run 10ns

#case 6

force {KEY[1]} 0
force {KEY[2]} 0
force {KEY[3]} 1

force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0

run 5ns

#case 7

force {KEY[1]} 0
force {KEY[2]} 0
force {KEY[3]} 0

force {SW[0]} 0 0ns, 1 {10ns} -r 20ns
force {SW[1]} 0 0ns, 1 {20ns} -r 40ns
force {SW[2]} 0 0ns, 1 {40ns} -r 80ns
force {SW[3]} 0 0ns, 1 {80ns} -r 160ns

run 30ns