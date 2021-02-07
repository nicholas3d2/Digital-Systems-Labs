vlib work

vlog part2.v

vsim fulladder

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {b} 0 0ns, 1 {10ns} -r 20ns
force {a} 0 0ns, 1 {20ns} -r 40ns
force {ci} 0 0ns, 1 {40ns} -r 80ns

run 100ns