vlib work

vlog part1.v

vsim main

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 0
force {SW[6]} 1
force {SW[7]} 0 0ns, 1 {10ns} -r 20ns
force {SW[8]} 0 0ns, 1 {20ns} -r 40ns
force {SW[9]} 0 0ns, 1 {40ns} -r 80ns

run 100ns
