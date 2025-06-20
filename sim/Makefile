SHELL=/bin/bash -o pipefail
.SHELLFLAGS += -e

PKG_ALL   := $(wildcard $(PWD)/../pkg/*.sv) $(wildcard $(PWD)/../pkg/*.svh)
PKG_SRCS  := \
	$(PWD)/../pkg/apu_core_package.sv \
	$(filter-out $(PWD)/../pkg/apu_core_package.sv,$(PKG_ALL))
	
HDL_SRCS  := $(shell find $(PWD)/../hdl -name '*.sv')
HVL_SRCS  := $(shell find $(PWD)/../hvl -name '*.sv' -o -name '*.v' -o -name '*.o' -o -name '*.so')
VCS_SRCS  := $(PKG_SRCS) $(HDL_SRCS) $(HVL_SRCS)

TIMEOUT   ?= 10000

export VCS_ARCH_OVERRIDE=linux
VCS_FLAGS    = +incdir+$(PWD)/../hvl/vcs \
	+incdir+$(PWD)/../pkg \
	+warn=none \
	+lint=none \
	-licqueue -full64 -lca -sverilog -timescale=1ps/1ps -debug_acc+all -kdb \
	-suppress=LCA_FEATURES_ENABLED -msg_config=../vcs_warn.config -assert svaext 

vcs/top_tb: $(VCS_SRCS)
	mkdir -p vcs
	cd vcs && vcs $(VCS_SRCS) $(VCS_FLAGS) -l compile.log -top top_tb -o top_tb
	# bash check_compile_error.sh

.PHONY: run_vcs_top_tb
run_vcs_top_tb: vcs/top_tb 
	rm -f vcs/dump.fsdb
	python3 $(PWD)/../bin/get_options.py clock
	cd vcs && ./top_tb -l simulation.log -exitstatus -suppress=ASLR_DETECTED_INFO \
		+TIMEOUT_ECE511=$(TIMEOUT) \
		+firmware=$(PWD)/../testcode/rtls_basline.hex
.PHONY: verdi
verdi:
	mkdir -p verdi
	cd verdi && timeout $(ECE411_GUI_TIMEOUT) $(VERDI_HOME)/bin/verdi -ssf $(PWD)/vcs/dump.fsdb

.PHONY: clean
clean:
	rm -rf bin vcs verdi

