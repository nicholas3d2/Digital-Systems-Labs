vlib work

vlog part1.v

vsim main

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {KEY[0]} 0 0ns, 1 {5ns} -r 10ns

force {SW[0]} 0 

run 5 ns

force {SW[0]} 1

run 100 ns