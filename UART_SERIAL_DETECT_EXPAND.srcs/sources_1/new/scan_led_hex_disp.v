`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2016 03:37:16 PM
// Design Name: 
// Module Name: scan_led_hex_disp
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


module scan_led_hex_disp  
   (input  clk,reset,
     input [3:0] hex3,hex2,hex1,hex0,
     input [3:0] dp_in,
     output reg [3:0] an,
          output reg [7:0] sseg         
     );
//     localparam N = 18; //对输入50MHz时钟进行分频(50 MHz/2^16)
     localparam N = 19; //对输入100MHz时钟进行分频(100 MHz/2^17)
//     localparam N = 9; //对输入100MHz时钟进行分频(100 MHz/2^17)

       reg [N-1:0]  regN;
reg [3:0] hex_in;
reg dp;
        always @(posedge clk,posedge reset) 
         if (reset)
           regN <= 0;
         else
            regN <= regN + 1;

      always @*
	    case (regN[N-1:N-2])
		  2'b00:
			begin
				an = 4'b0001;
				hex_in = hex0;
				dp = dp_in[0];
			end
		 2'b01:
			begin
				an = 4'b0010;
				hex_in = hex1;
				dp = dp_in[1];
			end
		 2'b10:
			begin
				an = 4'b0100;
				hex_in = hex2;
				dp = dp_in[2];
			end
		 default:
			begin
				an = 4'b1000;
				hex_in = hex3;
				dp = dp_in[3];
			end
	    endcase
  always @*
begin
	 case (hex_in)
		4'h0: sseg [6:0] = 7'b1111110;
        4'h1: sseg [6:0] = 7'b0110000;
        4'h2: sseg [6:0] = 7'b1101101;
        4'h3: sseg [6:0] = 7'b1111001;
        4'h4: sseg [6:0] = 7'b0110011;
        4'h5: sseg [6:0] = 7'b1011011;
        4'h6: sseg [6:0] = 7'b1011111;
        4'h7: sseg [6:0] = 7'b1110000;
        4'h8: sseg [6:0] = 7'b1111111;
        4'h9: sseg [6:0] = 7'b1111011;
        4'ha: sseg [6:0] = 7'b1110111;
        4'hb: sseg [6:0] = 7'b0011111;
        4'hc: sseg [6:0] = 7'b1001110;
        4'hd: sseg [6:0] = 7'b0111101;
        4'he: sseg [6:0] = 7'b1001111;
        default: sseg[6:0] = 7'b1000111;  //4'hf
	  endcase
	sseg[7] = dp;
	    end
      endmodule

