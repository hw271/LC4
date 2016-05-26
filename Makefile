#----------------------------
# pipes/Makefile
#
# contents:
#   --- How to build the LC4 assembler, kasm
#   --- How to build the LC4 simulation program
#   --- How to assemble an LC4 assenbly language program
#   --- How to run the LC4 simulation
#----------------------------

# ----- How to build the LC4 assembler, kasm
# 
#    (1) in a terminal window, do "make kasm"

kasm: kasm-v3.c
	cc -Wall kasm-v3.c -o kasm

#------ How to build the LC4 simulation program
# 
#   (1) in Electric, open the simulation cell, 0_LC4_sim{sch}
#   (2) in Electric, do Tools.Simulation.WriteVerilogDeck
#   (3) in terminal window, do "make sim"

sim: 0_LC4_sim.v
	iverilog 0_LC4_sim.v -o sim

#------ How to assemble an LC4 assenbly language program
#    (1) edit the assembly language source code file, prog.asm
#    (2) in a terminal window, do "make prog.bin"

prog.bin::
	./kasm < prog.asm > prog.bin

#------ How to run the LC4 simulation
#    (1) in a terminal window, do "make run"

run::
	vvp sim
