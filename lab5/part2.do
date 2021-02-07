vlib work

vlog part2.v

vsim main

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {SW[0]} 0
force {SW[1]} 0
force {SW[9]} 1

run 5 ns

force {SW[0]} 0
force {SW[1]} 0
force {SW[9]} 0

run 40 ns

force {SW[0]} 1
force {SW[1]} 0
force {SW[9]} 0

run 1 sec

force {SW[0]} 0
force {SW[1]} 1
force {SW[9]} 0

run 2 sec

force {SW[0]} 1
force {SW[1]} 1
force {SW[9]} 0

run 4 sec
