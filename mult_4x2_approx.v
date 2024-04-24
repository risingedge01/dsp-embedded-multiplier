`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.04.2024 14:13:17
// Design Name: 
// Module Name: mult_4x2
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


module mult_4x2_approx(
    input [3:0] a, // multiplicand
    input [1:0] b, // multiplier
    output wire [5:0] prod // output
);

wire O5_1, O6_1;
wire O6_2;
wire O6_3;
wire O6_4;

LUT6_2 #(
    .INIT(64'hB4CCF00066AACC00) // P1 and P2
) lut_inst1 (
    .O5(O5_1),
    .O6(O6_1),
    .I0(a[0]),
    .I1(a[1]),
    .I2(a[2]),
    .I3(b[0]),
    .I4(b[1]),
    .I5(1'b1)
);

LUT6_2 #(
    .INIT(64'hC738F0F0FF000000) // P3
) lut_inst2 (
    .O6(O6_2),
    .I0(a[0]),
    .I1(a[1]),
    .I2(a[2]),
    .I3(a[3]),
    .I4(b[0]),
    .I5(b[1])
);

LUT6_2 #(
    .INIT(64'h07C0FF0000000000) // P4
) lut_inst3 (
    .O6(O6_3),
    .I0(a[0]),
    .I1(a[1]),
    .I2(a[2]),
    .I3(a[3]),
    .I4(b[0]),
    .I5(b[1])
);

LUT6_2 #(
    .INIT(64'hF800000000000000) // P5
) lut_inst4 (
    .O6(O6_4),
    .I0(a[0]),
    .I1(a[1]),
    .I2(a[2]),
    .I3(a[3]),
    .I4(b[0]),
    .I5(b[1])
); 

assign prod[0] = 1'b0;
assign prod[1] = O5_1;
assign prod[2] = O6_1;
assign prod[3] = O6_2;
assign prod[4] = O6_3;
assign prod[5] = O6_4;

endmodule
