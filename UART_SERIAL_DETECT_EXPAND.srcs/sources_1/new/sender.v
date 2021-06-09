`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/23 16:26:32
// Design Name: 
// Module Name: sender
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


module sender(
    input uart_16x_clock,
    input [7:0] p_in,
    input send_switch,
    input rst,
    output reg send_status=0, //1 means oquipyed
    output reg s_out=1
    );

    reg [3:0] counter=0;
    reg [3:0] status=0;
    reg [7:0] p_in_reg=0;


    always @ (posedge uart_16x_clock, posedge rst) begin
        if(rst)
        begin
            counter<=0;
            s_out<=1;
            send_status<=0;
            status<=0;
            p_in_reg<=0;
        end
        else begin
            case (status)
                4'd0:begin 
                    if(send_switch)begin
                        if(counter==4'd15)begin
                            status<=4'd1;
                            p_in_reg<=p_in;
                            send_status<=1;
                            counter<=0;
                            s_out<=0;
                        end
                        else begin
                            counter<=counter+1;
                            s_out<=0;
                            p_in_reg<=p_in;
                        end
                    end
                    else begin
                        counter<=0;
                        status<=4'd0;
                        s_out<=1;
                        send_status<=0;
                    end
                end

                4'd9:begin
                    if(counter==4'd15)begin
                            status<=4'd0;
                            p_in_reg<=0;
                            counter<=0;
                            s_out<=1;
                            send_status<=0;
                        end
                    else begin
                        counter<=counter+1;
                        s_out<=1;
                    end
                end
                
                default: begin
                    if(counter==4'd15)begin
                        status<=status+1;
                        s_out<=p_in_reg[status-1];
                        counter<=0;
                    end
                    else begin
                        counter<=counter+1;
                        s_out<=p_in_reg[status-1];
                    end
                end
            endcase
        end
    end


endmodule
