`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/23 20:02:00
// Design Name: 
// Module Name: UART_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module UART_top(
    input sys_clk,
    input reset,
    input s_in,
    input bluetooth_s_in,
    input sw_ctrl_bt_power,
    input sw_bt_master_slave,
    input sw_bt_sw_hw,
    input sw_bt_rst_n,
    input sw_bt_sw,
    input sw_in,
    input sw_out,
    output wire s_out,
    output wire [3:0] an,
    output wire [7:0] sseg,
    output wire [3:0] ledshowstate,
    output wire bluetooth_s_out,
    output wire bt_pw_on,
    output wire bt_master_slave,
    output wire bt_sw_hw,
    output wire bt_rst_n,
    output wire bt_sw
    );

    parameter [12:0] buderate_code = 13'd325;

 

    wire s_in_select;
    wire s_out_select;

    assign s_in_select=(sw_in && bluetooth_s_in)||(~sw_in && s_in);
    assign bluetooth_s_out=sw_out && s_out_select;
    assign s_out=(~sw_out) && s_out_select;

    assign bt_pw_on=sw_ctrl_bt_power;
    assign bt_master_slave=sw_bt_master_slave;
    assign bt_sw_hw=sw_bt_sw_hw;
    assign bt_rst_n=sw_bt_rst_n;
    assign bt_sw=sw_bt_sw;


    //assign s_in_select=bluetooth_s_in;
    //assign bluetooth_s_out=s_out_select;

    assign rst = ~reset;
    wire uart_clock_16x;
    wire [7:0] p_out;
    wire [7:0] p_in;
    wire rcv_st;
    wire sd_st;
    wire sd_sw;

    wire [3:0] hex0;
    wire [3:0] hex1;
    wire [3:0] hex2;
    wire [3:0] hex3;

    clock_generate clk_generate(
        .sys_clk(sys_clk),
        .buderate_code(buderate_code), //13d'325 as 9600Hz, 13d'27 as 115200Hz
        .uart_clk_16x(uart_clock_16x)
    );

    receiver rcv(
    .s_in(s_in_select),
    .uart_16x_clock(uart_clock_16x),
    .rst(rst),
    .p_out(p_out),
    .receiver_status(rcv_st)
    );

    serial_detect sd(
    .uart_16X_clk(uart_clock_16x),
    .rst(rst),
    .data_in(p_out),
    .receive_sure(rcv_st),
    .send_status(sd_st),
    .hex0(hex0),
    .hex1(hex1),
    .hex2(hex2),
    .hex3(hex3),
    .data_out(p_in),
    .send_switch(sd_sw),
    .stateoutputwire(ledshowstate)
    );

    sender sder(
    .uart_16x_clock(uart_clock_16x),
    .p_in(p_in),
    .send_switch(sd_sw),
    .rst(rst),
    .send_status(sd_st), //1 means oquipyed
    .s_out(s_out_select)
    );

    scan_led_hex_disp led_dis(
    .clk(sys_clk),
    .reset(rst),
    .hex3(hex3),
    .hex2(hex2),
    .hex1(hex1),
    .hex0(hex0),
    .dp_in(0),
    .an(an),
    .sseg(sseg)         
     );

endmodule
