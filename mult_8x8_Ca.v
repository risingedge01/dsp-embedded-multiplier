`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.04.2024 13:50:03
// Design Name: 
// Module Name: mult_8x8_Ca
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


module mult_8x8_Ca #(parameter word_size = 8)
(
    input [7:0] A,
    input [7:0] B,
    output [15:0] PROD
);

    // Signals for holding multiplication results
    wire [7:0] prod1, prod2, prod3, prod4;

    // Module instantiation for multiplication components
    mult_accurate inst1_mult (
        .a(A[3:0]),
        .b(B[3:0]),
        .prod(prod1)
    );

    mult_accurate inst2_mult (
        .a(A[7:4]),
        .b(B[3:0]),
        .prod(prod2)
    );

    mult_accurate inst3_mult (
        .a(A[3:0]),
        .b(B[7:4]),
        .prod(prod3)
    );

    mult_accurate inst4_mult (
        .a(A[7:4]),
        .b(B[7:4]),
        .prod(prod4)
    );

    // Module instantiation for adder component
    adder inst_add (
        .prod1(prod1),
        .prod2(prod2),
        .prod3(prod3),
        .prod4(prod4),
        .PROD(PROD)
    );

endmodule
