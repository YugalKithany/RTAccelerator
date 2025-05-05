SHELL=/bin/bash -o pipefail
.SHELLFLAGS += -e

FSDB2SAIF_START = $(shell head -n1 ../sim/vcs/time.txt)
FSDB2SAIF_END   = $(shell tail -n1 ../sim/vcs/time.txt)

PKG_ALL   := $(wildcard $(PWD)/../pkg/*.sv) $(wildcard $(PWD)/../pkg/*.svh)
export PKG_SRCS  := \
	$(PWD)/../pkg/apu_core_package.sv \
	$(filter-out $(PWD)/../pkg/apu_core_package.sv,$(PKG_ALL))
export HDL_SRCS = $(shell find $(PWD)/../hdl -name '*.sv')
export DESIGN_TOP = riscv_core

export STD_CELL_LIB=$(FREEPDK45)/stdcells.db
export STD_CELL_ALIB=$(FREEPDK45)/alib

export SNPSLMD_QUEUE=true

.IGNORE:

.PHONY: synth
synth: clean
	$(MAKE) outputs/synth.ddc

outputs/synth.ddc:
	mkdir -p reports outputs
	python3 $(PWD)/../bin/get_options.py min_power
	python3 $(PWD)/../bin/get_options.py synth_cmd
	python3 $(PWD)/../bin/get_options.py synth_cmd_inc
	python3 $(PWD)/../bin/get_options.py synth_inc_iter
	export ECE411_MIN_POWER=$(shell python3 $(PWD)/../bin/get_options.py min_power) ;\
	export ECE411_COMPILE_CMD="$(shell python3 $(PWD)/../bin/get_options.py synth_cmd)" ;\
	export ECE411_COMPILE_CMD_INC="$(shell python3 $(PWD)/../bin/get_options.py synth_cmd_inc)" ;\
	export ECE411_COMPILE_ITER="$(shell python3 $(PWD)/../bin/get_options.py synth_inc_iter)" ;\
	export ECE411_DC_CORES=4 ;\
	dc_shell -f synthesis.tcl |& tee reports/synthesis.log
	rm -f  *.log
	rm -f  default.svf
	rm -rf work
	bash check_synth_error.sh

../sim/vcs/dump.fsdb.saif: ../sim/vcs/dump.fsdb
	cd ../sim/vcs && fsdb2saif dump.fsdb -bt $(FSDB2SAIF_START)ps -et $(FSDB2SAIF_END)ps -s top_tb/dut

.PHONY: power
power: outputs/synth.ddc ../sim/vcs/dump.fsdb.saif
	mkdir -p reports outputs
	dc_shell -f power.tcl |& tee reports/power.log

.PHONY: dv
dv:
	timeout $(ECE411_GUI_TIMEOUT) design_vision -f dv.tcl

.PHONY: clean
clean:
	rm -f  *.log
	rm -f  default.svf
	rm -rf work
	rm -rf reports
	rm -rf outputs