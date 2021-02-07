vlib work

vlog part3.v

vsim main

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

#RESET

force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0

force {KEY[0]} 0
force {KEY[1]} 1

run 5 ns

#A
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0

force {KEY[0]} 1
force {KEY[1]} 0
run 5 ns
force {KEY[1]} 1

run 6 sec

#B
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0

force {KEY[0]} 1
force {KEY[1]} 0
run 5 ns
force {KEY[1]} 1

run 6 sec

#C
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0

force {KEY[0]} 1
force {KEY[1]} 0
run 5 ns
force {KEY[1]} 1

run 6 sec

#D
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0

force {KEY[0]} 1
force {KEY[1]} 0
run 5 ns
force {KEY[1]} 1

run 6 sec

#E
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1

force {KEY[0]} 1
force {KEY[1]} 0
run 5 ns
force {KEY[1]} 1

run 6 sec

#F
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1

force {KEY[0]} 1
force {KEY[1]} 0
run 5 ns
force {KEY[1]} 1

run 6 sec

#G
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 1

force {KEY[0]} 1
force {KEY[1]} 0
run 5 ns
force {KEY[1]} 1

run 6 sec

#H
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1

force {KEY[0]} 1
force {KEY[1]} 0
run 5 ns
force {KEY[1]} 1

run 6 sec