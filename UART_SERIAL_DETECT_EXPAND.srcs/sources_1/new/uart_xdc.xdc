#/////////////////////////////系统时钟和复位////////////////////////////////////
set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports sys_clk]
set_property -dict {PACKAGE_PIN P15 IOSTANDARD LVCMOS33} [get_ports reset]

#/////////////////////////////串口/////////////////////////////////////////////
set_property -dict {PACKAGE_PIN N5 IOSTANDARD LVCMOS33} [get_ports s_in]
set_property -dict {PACKAGE_PIN T4 IOSTANDARD LVCMOS33} [get_ports s_out]

#------------------------------数码管片选信号-------------------------------
set_property -dict {PACKAGE_PIN G2 IOSTANDARD LVCMOS33} [get_ports {an[3]}]
set_property -dict {PACKAGE_PIN C2 IOSTANDARD LVCMOS33} [get_ports {an[2]}]
set_property -dict {PACKAGE_PIN C1 IOSTANDARD LVCMOS33} [get_ports {an[1]}]
set_property -dict {PACKAGE_PIN H1 IOSTANDARD LVCMOS33} [get_ports {an[0]}]
#------------------------------数码管段选信号-------------------------------
set_property -dict {PACKAGE_PIN B4 IOSTANDARD LVCMOS33} [get_ports {sseg[6]}]
set_property -dict {PACKAGE_PIN A4 IOSTANDARD LVCMOS33} [get_ports {sseg[5]}]
set_property -dict {PACKAGE_PIN A3 IOSTANDARD LVCMOS33} [get_ports {sseg[4]}]
set_property -dict {PACKAGE_PIN B1 IOSTANDARD LVCMOS33} [get_ports {sseg[3]}]
set_property -dict {PACKAGE_PIN A1 IOSTANDARD LVCMOS33} [get_ports {sseg[2]}]
set_property -dict {PACKAGE_PIN B3 IOSTANDARD LVCMOS33} [get_ports {sseg[1]}]
set_property -dict {PACKAGE_PIN B2 IOSTANDARD LVCMOS33} [get_ports {sseg[0]}]
set_property -dict {PACKAGE_PIN D5 IOSTANDARD LVCMOS33} [get_ports {sseg[7]}]

#//----------------------LED-----------------------------------
set_property -dict {PACKAGE_PIN K6 IOSTANDARD LVCMOS33} [get_ports {ledshowstate[3]}]
set_property -dict {PACKAGE_PIN L1 IOSTANDARD LVCMOS33} [get_ports {ledshowstate[2]}]
set_property -dict {PACKAGE_PIN M1 IOSTANDARD LVCMOS33} [get_ports {ledshowstate[1]}]
set_property -dict {PACKAGE_PIN K3 IOSTANDARD LVCMOS33} [get_ports {ledshowstate[0]}]

#//-------------------------bluetooth----------
set_property -dict {PACKAGE_PIN L3 IOSTANDARD LVCMOS33} [get_ports bluetooth_s_in]
set_property -dict {PACKAGE_PIN N2 IOSTANDARD LVCMOS33} [get_ports bluetooth_s_out]
set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVCMOS33} [get_ports bt_pw_on        ]
set_property -dict {PACKAGE_PIN C16 IOSTANDARD LVCMOS33} [get_ports bt_master_slave ]
set_property -dict {PACKAGE_PIN H15 IOSTANDARD LVCMOS33} [get_ports bt_sw_hw        ]
set_property -dict {PACKAGE_PIN M2  IOSTANDARD LVCMOS33} [get_ports bt_rst_n        ]
set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS33} [get_ports bt_sw           ]

#//----------------------bomakaiguan-------------------
set_property -dict {PACKAGE_PIN P5 IOSTANDARD LVCMOS33} [get_ports {sw_ctrl_bt_power}]
set_property -dict {PACKAGE_PIN P4 IOSTANDARD LVCMOS33} [get_ports {sw_bt_master_slave}]
set_property -dict {PACKAGE_PIN P3 IOSTANDARD LVCMOS33} [get_ports {sw_bt_sw_hw}]
set_property -dict {PACKAGE_PIN P2 IOSTANDARD LVCMOS33} [get_ports {sw_bt_rst_n}]
set_property -dict {PACKAGE_PIN R2 IOSTANDARD LVCMOS33} [get_ports {sw_bt_sw}]
set_property -dict {PACKAGE_PIN M4 IOSTANDARD LVCMOS33} [get_ports {sw_in}]
set_property -dict {PACKAGE_PIN N4 IOSTANDARD LVCMOS33} [get_ports {sw_out}]