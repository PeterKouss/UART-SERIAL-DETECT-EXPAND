`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/28 09:55:19
// Design Name: 
// Module Name: serial_detect
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

module serial_detect(
    input uart_16X_clk,
    input rst,
    input [7:0] data_in,
    input receive_sure,
    input send_status,
    output wire [3:0] hex0,
    output wire [3:0] hex1,
    output wire [3:0] hex2,
    output wire [3:0] hex3,
    output reg [7:0] data_out=0,
    output reg send_switch=0,
    output wire [3:0] stateoutputwire
    );

    wire fifo_empty;
    wire fifo_full;
    wire [7:0] data_out_fifo;
    reg rd_enable=0;

    reg [7:0] send_data_in=0;
    reg send_fifo_wr_en=0;
    reg send_rd_enable=0;
    wire [7:0] send_data_out_fifo;
    wire send_fifo_empty;
    wire send_fifo_full;


    reg [3:0] state=0;

    fifo_generator_0 fifo_0 (
    .clk(uart_16X_clk),      // input wire clk
    .din(data_in),      // input wire [7 : 0] din
    .wr_en(receive_sure),  // input wire wr_en
    .rd_en(rd_enable),  // input wire rd_en
    .dout(data_out_fifo),    // output wire [7 : 0] dout
    .full(fifo_full),    // output wire full
    .empty(fifo_empty)  // output wire empty
    );

    fifo_generator_1 fifo_1 (
    .clk(uart_16X_clk),      // input wire clk
    .din(send_data_in),      // input wire [7 : 0] din
    .wr_en(send_fifo_wr_en),  // input wire wr_en
    .rd_en(send_rd_enable),  // input wire rd_en
    .dout(send_data_out_fifo),    // output wire [7 : 0] dout
    .full(send_fifo_full),    // output wire full
    .empty(send_fifo_empty)  // output wire empty
    );
    
    reg judge_enable=0;
    wire judge_right;
    wire judgefinished;

    serial_judge judegseiral(
        .clk(uart_16X_clk),
        .rst(rst),
        .judge_data_in(data_out_fifo),
        .judge_enable(judge_enable),
        .judge_right(judge_right),
        .judgefinished(judgefinished),
        .result0(hex0),
        .result1(hex1),
        .result2(hex2),
        .result3(hex3),
        .state(stateoutputwire)
    );



    always @(posedge uart_16X_clk,posedge rst) begin
        if(rst)begin
            state<=4'd0;
            rd_enable<=0;
            send_fifo_wr_en<=0;
            judge_enable<=0;

        end
        else begin
            case (state)
                4'd0: begin
                    if(~fifo_empty)begin
                        state<=4'd1;
                        rd_enable<=1;
                        send_fifo_wr_en<=0;
                    end
                    else begin
                        state<=4'd0;
                        send_fifo_wr_en<=0;
                        rd_enable<=0;
                    end
                end

                4'd1:begin
                    state<=4'd2;
                    rd_enable<=0;
                end

                4'd2:begin
                    judge_enable<=1;
                    state<=4'd3;
                end


                4'd3:begin
                    if(judgefinished==1 && judge_right==1)begin
                        state<=4'd4;
                        judge_enable<=0;
                    end
                    else if(judgefinished==1 && judge_right==0)begin
                        state<=4'd0;
                        judge_enable<=0;
                    end
                    else begin
                        state<=state;
                        judge_enable<=0;
                    end
                end

                4'd4:begin
                    state<=4'd5;
                    send_fifo_wr_en<=1;//may problem
                    send_data_in<=hex3+8'h30; //高位数字的asc码
                    
                end

                4'd5:begin
                    state<=4'd6;
                    send_fifo_wr_en<=1;
                    send_data_in<=hex2+8'h30; //低位数字的asc码
                    
                end

                4'd6:begin
                    state<=4'd7;
                    send_fifo_wr_en<=1;
                    send_data_in<=hex1+8'h30;
                end

                4'd7:begin
                    state<=4'd8;
                    send_fifo_wr_en<=1;
                    send_data_in<=hex0+8'h30;
                end

                4'd8:begin
                    state<=4'd0;
                    send_fifo_wr_en<=1;
                    send_data_in<=8'h0A;
                end
        
                default: begin
                    state<=4'd0;
                end
            endcase
        end
    end

    reg [3:0] send_control_state=0;
    reg [3:0] counter=0;

    always @(posedge uart_16X_clk, posedge rst) begin
        if(rst)begin
            send_switch<=0;
            send_control_state<=0;
            send_rd_enable<=0;
        end
        else begin
            case (send_control_state)
                4'd0:begin
                    if(~send_fifo_empty)begin
                        send_control_state<=4'd1;
                        send_switch<=0;
                        send_rd_enable<=1;
                    end
                    else begin
                        send_control_state<=4'd0;
                        send_switch<=0;
                        send_rd_enable<=0;
                    end
                end

                4'd1:begin
                    send_rd_enable<=0;
                    send_control_state<=4'd2;
                end

                4'd2:begin
                    data_out<=send_data_out_fifo;
                    send_control_state<=4'd3;
                end

                4'd3:begin
                    if(send_status==0) begin
                        if(counter==4'd15) begin
                            counter<=0;
                            send_control_state<=4'd0;
                            send_switch<=1;
                        end
                        else begin
                            counter=counter+1;
                            send_switch<=1;
                        end
                    end
                    else begin
                        send_control_state<=4'd3;
                    end
                end
                default: begin
                    send_control_state<=4'd0;
                end
            endcase
        end
    end

endmodule
