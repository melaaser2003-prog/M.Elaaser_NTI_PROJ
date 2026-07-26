#create_clock -name sys_clk -period 10.0 [get_ports clk]
#create_clock -name v_clk -period 10.0 

#set_clock_uncertainty 0.5 [get_clocks sys_clk]
#set_clock_uncertainty 0.5 [get_clocks v_clk]

#set_input_delay -clock sys_clk -max 2.5 [get_ports in_data]
#set_input_delay -clock sys_clk -min 0.5 [get_ports in_data]

#set_output_delay -clock sys_clk -max 3.0 [get_ports out_data]
#set_output_delay -clock sys_clk -min 1.0 [get_ports out_data]

#set_max_delay -from [get_ports in_comb] -to [get_ports out_comb] 8.0
#set_min_delay -from [get_ports in_comb] -to [get_ports out_comb] 2.0

# =========================================================
# 1. Base Clock Period & Percentage Parameters
# =========================================================
set CLK_PERIOD 10.0

set PCT_UNCERTAINTY    0.05  ;
set PCT_INPUT_MAX      0.25  ;
set PCT_INPUT_MIN      0.05  ;
set PCT_OUTPUT_MAX     0.30  ;
set PCT_OUTPUT_MIN     0.10  ;
set PCT_MAX_DELAY      0.80  ;
set PCT_MIN_DELAY      0.20  ;

# =========================================================
# 2. Calculated Delay Values
# =========================================================
set clk_uncertainty    [expr {$CLK_PERIOD * $PCT_UNCERTAINTY}]
set input_delay_max    [expr {$CLK_PERIOD * $PCT_INPUT_MAX}]
set input_delay_min    [expr {$CLK_PERIOD * $PCT_INPUT_MIN}]
set output_delay_max   [expr {$CLK_PERIOD * $PCT_OUTPUT_MAX}]
set output_delay_min   [expr {$CLK_PERIOD * $PCT_OUTPUT_MIN}]
set comb_max_delay     [expr {$CLK_PERIOD * $PCT_MAX_DELAY}]
set comb_min_delay     [expr {$CLK_PERIOD * $PCT_MIN_DELAY}]

# =========================================================
# 3. Clock Definitions & Uncertainties
# =========================================================
create_clock -name sys_clk -period $CLK_PERIOD [get_ports clk]
create_clock -name v_clk   -period $CLK_PERIOD 

set_clock_uncertainty $clk_uncertainty [get_clocks sys_clk]
set_clock_uncertainty $clk_uncertainty [get_clocks v_clk]

# =========================================================
# 4. Input Delays (IN2REG)
# =========================================================
set_input_delay -clock sys_clk -max $input_delay_max [get_ports in_data]
set_input_delay -clock sys_clk -min $input_delay_min [get_ports in_data]

set_input_delay -clock v_clk -max $input_delay_max [get_ports in_comb]
set_input_delay -clock v_clk -min $input_delay_min [get_ports in_comb]

# =========================================================
# 5. Output Delays (REG2OUT)
# =========================================================
set_output_delay -clock sys_clk -max $output_delay_max [get_ports out_data]
set_output_delay -clock sys_clk -min $output_delay_min [get_ports out_data]

set_output_delay -clock v_clk -max $output_delay_max [get_ports out_comb]
set_output_delay -clock v_clk -min $output_delay_min [get_ports out_comb]

# =========================================================
# 6. Max / Min Delays (IN2OUT)
# =========================================================
set_max_delay -from [get_ports in_comb] -to [get_ports out_comb] $comb_max_delay
set_min_delay -from [get_ports in_comb] -to [get_ports out_comb] $comb_min_delay