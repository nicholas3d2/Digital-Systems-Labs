vlib work

vlog part2.v

vsim main

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {SW[0]} 0 0ns, 1 {10ns} -r 20ns
force {SW[4]} 0 0ns, 1 {20ns} -r 40ns
force {SW[8]} 0
force {SW[1]} 0 
force {SW[5]} 0 
force {SW[2]} 0
force {SW[6]} 0

run 100ns

force {SW[1]} 0 0ns, 1 {10ns} -r 20ns
force {SW[5]} 0 0ns, 1 {20ns} -r 40ns

run 100 ns