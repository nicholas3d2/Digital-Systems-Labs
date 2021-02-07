vlib work

vlog part3.v

vsim main

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {SW} 0

#case 0

force {KEY[0]} 1
force {KEY[1]} 1
force {KEY[2]} 1

force {SW[0]} 0 0ns, 1 {10ns} -r 20ns
force {SW[1]} 0 0ns, 1 {20ns} -r 40ns
force {SW[2]} 0 0ns, 1 {40ns} -r 80ns
force {SW[3]} 0 0ns, 1 {80ns} -r 160ns

force {SW[4]} 0 0ns, 1 {10ns} -r 20ns
force {SW[5]} 0 0ns, 1 {20ns} -r 40ns
force {SW[6]} 0 0ns, 1 {40ns} -r 80ns
force {SW[7]} 0 0ns, 1 {80ns} -r 160ns

run 100ns

#case 1

force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 1

force {SW[0]} 0 0ns, 1 {10ns} -r 20ns
force {SW[1]} 0 0ns, 1 {20ns} -r 40ns
force {SW[2]} 0 0ns, 1 {40ns} -r 80ns
force {SW[3]} 0 0ns, 1 {80ns} -r 160ns

force {SW[4]} 0 0ns, 1 {10ns} -r 20ns
force {SW[5]} 0 0ns, 1 {20ns} -r 40ns
force {SW[6]} 0 0ns, 1 {40ns} -r 80ns
force {SW[7]} 0 0ns, 1 {80ns} -r 160ns

run 100ns

#case 2

force {KEY[0]} 1
force {KEY[1]} 0
force {KEY[2]} 1

force {SW[0]} 0 0ns, 1 {10ns} -r 20ns
force {SW[1]} 0 0ns, 1 {20ns} -r 40ns
force {SW[2]} 0 0ns, 1 {40ns} -r 80ns
force {SW[3]} 0 0ns, 1 {80ns} -r 160ns

force {SW[4]} 0 0ns, 1 {10ns} -r 20ns
force {SW[5]} 0 0ns, 1 {20ns} -r 40ns
force {SW[6]} 0 0ns, 1 {40ns} -r 80ns
force {SW[7]} 0 0ns, 1 {80ns} -r 160ns

run 100ns

#case 3

force {KEY[0]} 0
force {KEY[1]} 0
force {KEY[2]} 1

force {SW[0]} 0 0ns, 1 {10ns} 
force {SW[1]} 0 0ns, 1 {10ns} 
force {SW[2]} 0 0ns, 1 {10ns} 
force {SW[3]} 0 0ns, 1 {10ns} 

force {SW[4]} 0 0ns, 1 {10ns}
force {SW[5]} 0 0ns, 1 {10ns} 
force {SW[6]} 0 0ns, 1 {10ns} 
force {SW[7]} 0 0ns, 1 {10ns} 

run 100ns

#case 4

force {KEY[0]} 1
force {KEY[1]} 1
force {KEY[2]} 0

force {SW[0]} 1 
force {SW[1]} 1 
force {SW[2]} 1 
force {SW[3]} 1 

force {SW[4]} 1 
force {SW[5]} 1 
force {SW[6]} 1 
force {SW[7]} 1 

run 100ns

#case 5

force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 0

force {SW[0]} 0 0ns, 1 {10ns} -r 20ns
force {SW[1]} 0 0ns, 1 {20ns} -r 40ns
force {SW[2]} 0 0ns, 1 {40ns} -r 80ns
force {SW[3]} 0 0ns, 1 {80ns} -r 160ns

force {SW[4]} 0 0ns, 1 {10ns} -r 20ns
force {SW[5]} 0 0ns, 1 {20ns} -r 40ns
force {SW[6]} 0 0ns, 1 {40ns} -r 80ns
force {SW[7]} 0 0ns, 1 {80ns} -r 160ns

run 100ns