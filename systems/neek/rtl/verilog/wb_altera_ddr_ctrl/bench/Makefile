all:
	@if [ ! -d ./work ]; then vlib ./work;  fi
	vlog -f src_files.scr -quiet +define+sg5B +define+x16 +define+FULL_MEM
	vsim  -c -do "run -all" work.wb_ddr_ctrl_tb
