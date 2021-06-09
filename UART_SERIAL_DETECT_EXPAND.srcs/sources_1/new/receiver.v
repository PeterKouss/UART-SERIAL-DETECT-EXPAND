`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/23 15:43:04
// Design Name: 
// Module Name: receover
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


module receiver(
    input s_in,
    input uart_16x_clock,
    input rst,
    output reg [7:0] p_out=0,
    output reg receiver_status=0
    );
    
    reg [3:0] output_state=0; 
    reg [7:0] p_out_reg=0;
    reg [3:0] counter=0;

    reg low_flag=0;
    reg up_flag=0;

    always @ (posedge uart_16x_clock, posedge rst)
    begin
        if(rst) begin
            counter<=0;
            receiver_status<=0;
            p_out_reg<=0;
            p_out<=0;
            output_state<=0;
            low_flag<=0;
        end
        else begin
            case (output_state)
                4'd0:begin //remain high wait flag low in (mayproblem)
                    if(s_in==0 || low_flag) begin
                        if(counter==4'd8)begin
                            if(s_in==0)begin
                                counter<=counter+1;
                                receiver_status<=0;
                            end
                            else begin
                                low_flag<=0;
                                output_state<=4'd0;
                                counter<=0;
                                receiver_status<=0;
                            end
                        end
                        else if(counter==4'd15) begin
                            counter<=0;
                            output_state<=4'd1;
                            receiver_status<=0;
                            low_flag<=0;
                        end
                        else begin
                            counter<=counter+1;
                            low_flag<=1;
                            receiver_status<=0;
                        end
                    end
                    else begin
                        counter<=0;
                        output_state<=0;
                        low_flag<=0;
                        p_out_reg<=0;
                        receiver_status<=0;
                    end
                end 
                4'd9:begin //read stop flag (mayproblem)
                    if(counter==4'd15) begin
                            counter<=0;
                            output_state<=4'd0;
                            receiver_status<=1;
                        end
                    else begin
                        counter<=counter+1;
                        receiver_status<=0;
                        p_out<=p_out_reg;
                    end
                end

                default: begin //read 1st-8th bit
                    if(counter==4'd8)begin
                        p_out_reg[output_state-1]<=s_in;
                        counter<=counter+1;
                    end
                    else if(counter==4'd15)begin
                        counter<=0;
                        output_state<=output_state+1;
                    end
                    else begin
                        counter<=counter+1;
                    end
                end

            endcase
        end
    end

    

endmodule
