`timescale 1ns / 1ps

module mult_4x4_approx(input clk, input [3:0]a,input [3:0]b, output digit, output [7:0]m, output Seven_Seg);
  reg [15:0] cnt = 16'd0;
  reg [1:0] selectSSD = 2'b00;
  wire [7:0] Seven_Seg;
  reg [3:0] val, digit;

 
  mult_4x4_app mult_approx(a, b, m);
         
  always @ (posedge clk) begin
    if (cnt == 14'd10000)
    begin
    cnt = 0;
    selectSSD = selectSSD + 1;
      if(selectSSD == 2)
        selectSSD <= 2'b00;
    end
  else
    cnt = cnt + 1; end

  //decode the digit select to enable digit select pins
  always @ (selectSSD)
    begin
      case (selectSSD) // for Edge board
      2'b00 : digit = 4'b0100; // enable digit[0]
      2'b01 : digit = 4'b1000; // enable digit[1]
      endcase
    end
  always @ (selectSSD)
    case (selectSSD)
      2'b00: val = m[7:4]; // display 1
      2'b01: val = m[3:0]; // display 2
    endcase
	
   decoder dec0(val, Seven_Seg);
endmodule