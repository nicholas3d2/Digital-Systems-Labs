vlib work

vlog part3.v

vsim main

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {SW} 0
force {KEY[0]} 0 0ns, 1 {5ns} -r 10ns

#RESET REGISTER

force {SW[9]} 1

run 5ns

force {SW[9]} 0

#LOAD DATA
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 1
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 0
force {SW[7]} 1

run 5ns

#ROTATE RIGHT
force {KEY[1]} 0
force {KEY[2]} 0
force {KEY[3]} 1

run 40ns

#ROTATE LEFT
force {KEY[1]} 0
force {KEY[2]} 1
force {KEY[3]} 1

run 40ns

#ASRIGHT
force {KEY[1]} 0
force {KEY[2]} 0
force {KEY[3]} 0

run 40ns
