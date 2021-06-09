`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/28 10:25:17
// Design Name: 
// Module Name: serial_judge
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


module serial_judge(
    input clk,
    input rst,
    input [7:0] judge_data_in,
    input judge_enable,
    output reg judge_right=0,
    output reg judgefinished=0,
    output reg [3:0] result0=0,
    output reg [3:0] result1=0,
    output reg [3:0] result2=0,
    output reg [3:0] result3=0,
    output reg [3:0] state=0
    );

    //reg [3:0] state=0;

    reg count_switch=0;

always @(posedge clk, posedge rst) begin
    if (rst) begin
        state<=0;
        judgefinished<=0;
        judge_right<=0;
    end
    else begin
            case (state)
                4'd0:begin
                if(judge_enable==1 && judge_data_in==8'h6c)begin
                    state<=4'd1;
                    judgefinished<=1;
                    judge_right<=0;
                end
                else if(judge_enable==1 && judge_data_in!=8'h6c) begin
                    state<=0;
                    judgefinished<=1;
                    judge_right<=0;
                end
                else begin
                    state<=state;
                    judgefinished<=0;
                    judge_right<=0;
                end 
                end

                4'd1:begin
                if(judge_enable==1 && judge_data_in==8'h69)begin
                    state<=4'd2;
                    judgefinished<=1;
                    judge_right<=0;
                end
                else if(judge_enable==1 && judge_data_in==8'h6c) begin
                    state<=4'd1;
                    judgefinished<=1;
                    judge_right<=0;
                end
                else if(judge_enable==1) begin
                    state<=4'd0;
                    judgefinished<=1;
                    judge_right<=0;
                end
                else begin
                    state<=state;
                    judgefinished<=0;
                    judge_right<=0;
                end
                end

                4'd2:begin
                if(judge_enable==1 && judge_data_in==8'h6b)begin
                    state<=4'd3;
                    judgefinished<=1;
                    judge_right<=0;
                end
                else if(judge_enable==1 && judge_data_in==8'h6c) begin
                    state<=4'd1;
                    judgefinished<=1;
                    judge_right<=0;
                end
                else if(judge_enable==1) begin
                    state<=4'd0;
                    judgefinished<=1;
                    judge_right<=0;
                end    
                else begin
                    state<=state;
                    judgefinished<=0;
                    judge_right<=0;
                end
                    
                end

                4'd3:begin
                if(judge_enable==1 && judge_data_in==8'h75)begin
                    state<=4'd4;
                    judgefinished<=1;
                    judge_right<=0;
                end
                else if(judge_enable==1 && judge_data_in==8'h6c) begin
                    state<=4'd1;
                    judgefinished<=1;
                    judge_right<=0;
                end
                else if(judge_enable==1) begin
                    state<=4'd0;
                    judgefinished<=1;
                    judge_right<=0;
                end
                else begin
                    state<=state;
                    judgefinished<=0;
                    judge_right<=0;
                end
                    
                end

                4'd4:begin
                if(judge_enable==1 && judge_data_in==8'h6e)begin            
                    state<=4'd5;
                    judgefinished<=1;
                    judge_right<=0;
                end
                else if(judge_enable==1 && judge_data_in==8'h6c) begin
                    state<=4'd1;
                    judgefinished<=1;
                    judge_right<=0;
                end
                else if(judge_enable==1) begin
                    state<=4'd0;
                    judgefinished<=1;
                    judge_right<=0;
                end
                else begin
                    state<=state;
                    judgefinished<=0;
                    judge_right<=0;
                end
                end

                4'd5:begin
                if(judge_enable==1 && judge_data_in==8'h32)begin
                    state<=4'd6;
                    judgefinished<=1;
                    judge_right<=0;
                end
                else if(judge_enable==1 && judge_data_in==8'h6c) begin
                    state<=4'd1;
                    judgefinished<=1;
                    judge_right<=0;
                end
                else if(judge_enable==1) begin
                    state<=4'd0;
                    judgefinished<=1;
                    judge_right<=0;
                end
                else begin
                    state<=state;
                    judgefinished<=0;
                    judge_right<=0;
                end
                    
                end

                4'd6:begin
                if(judge_enable==1 && judge_data_in==8'h36)begin
                    state<=4'd7;
                    judgefinished<=1;
                    judge_right<=0;
                end
                else if(judge_enable==1 && judge_data_in==8'h6c) begin
                    state<=4'd1;
                    judgefinished<=1;
                    judge_right<=0;
                end
                else if(judge_enable==1) begin
                    state<=4'd0;
                    judgefinished<=1;
                    judge_right<=0;
                end
                else begin
                    state<=state;
                    judgefinished<=0;
                    judge_right<=0;
                end
                end

                4'd7:begin
                if(judge_enable==1 && judge_data_in==8'h30)begin
                    state<=4'd8;
                    judgefinished<=1;
                    judge_right<=0;
                end
                else if(judge_enable==1 && judge_data_in==8'h6c) begin
                    state<=4'd1;
                    judgefinished<=1;
                    judge_right<=0;
                end
                else if(judge_enable==1) begin
                    state<=4'd0;
                    judgefinished<=1;
                    judge_right<=0;
                end
                else begin
                    state<=state;
                    judgefinished<=0;
                    judge_right<=0;
                end

                end

                4'd8:begin
                if(judge_enable==1 && judge_data_in==8'h30)begin
                    state<=4'd9;
                    judgefinished<=1;
                    judge_right<=0;
                end
                else if(judge_enable==1 && judge_data_in==8'h6c) begin
                    state<=4'd1;
                    judgefinished<=1;
                    judge_right<=0;
                end
                else if(judge_enable==1) begin
                    state<=4'd0;
                    judgefinished<=1;
                    judge_right<=0;
                end
                else begin
                    state<=state;
                    judgefinished<=0;
                    judge_right<=0;
                end  
                end

                4'd9:begin
                if(judge_enable==1 && judge_data_in==8'h31)begin
                    state<=4'd10;
                    count_switch<=1;
                    judgefinished<=0;
                    judge_right<=0;
                end
                else if(judge_enable==1 && judge_data_in==8'h6c) begin
                    state<=4'd1;
                    judgefinished<=1;
                    judge_right<=0;
                end
                else if(judge_enable==1) begin
                    state<=4'd0;
                    judgefinished<=1;
                    judge_right<=0;
                end
                else begin
                    state<=state;
                    judgefinished<=0;
                    judge_right<=0;
                end    
                end

                4'd10:begin
                    state<=4'd11;
                    count_switch<=0;
                    judgefinished<=0;
                    judge_right<=0;
                end

                4'd11:begin
                    judgefinished<=1;
                    judge_right<=1;
                    state<=0;
                end

                default: begin
                    state<=0;
                end
            endcase
        end
    end


always @ (posedge clk, posedge rst) begin
    if(rst)begin
        result0<=0;
    end
    else begin
        if(count_switch && result0==4'd9)begin
            result0<=4'd0;
        end
        else if(count_switch) begin
            result0<=result0+1;
        end
    end
end

always @ (posedge clk, posedge rst) begin
    if(rst)begin
        result1<=0;
    end
    else begin
        if(count_switch && result1==4'd9 && result0==4'd9)begin
            result1<=4'd0;
        end
        else if(count_switch && result0==4'd9) begin
            result1<=result1+1;
        end
    end
end

always @ (posedge clk, posedge rst) begin
    if(rst)begin
        result2<=0;
    end
    else begin
        if(count_switch && result2==4'd9 && result1==4'd9 && result0==4'd9)begin
            result2<=4'd0;
        end
        else if(count_switch && result1==4'd9 && result0==4'd9) begin
            result2<=result2+1;
        end
    end
end

always @ (posedge clk, posedge rst) begin
    if(rst)begin
        result3<=0;
    end
    else begin
        if(count_switch && result3==4'd9 && result2==4'd9 && result1==4'd9 && result0==4'd9)begin
            result3<=4'd0;
        end
        else if(count_switch && result2==4'd9 && result1==4'd9 && result0==4'd9) begin
            result3<=result3+1;
        end
    end
end



endmodule
