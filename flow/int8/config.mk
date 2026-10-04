export DESIGN_NICKNAME = mac_array
export DESIGN_NAME     = systolic
export PLATFORM        = nangate45

export VERILOG_FILES = $(sort $(wildcard $(DESIGN_HOME)/src/$(DESIGN_NICKNAME)/*.v))
export SDC_FILE      = $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/constraint.sdc

export CORE_UTILIZATION = 30
export PLACE_DENSITY_LB_ADDON = 0.20
