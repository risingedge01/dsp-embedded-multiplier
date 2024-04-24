`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2024 21:56:31
// Design Name: 
// Module Name: mult_8x8_Cc
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

module mult_8x8_Cc (
    input wire [7:0] A,
    input wire [7:0] B,
    output wire [15:0] PROD
);

// Define signals and components
wire [7:0] prod1, prod2, prod3, prod4;
wire [8:0] sum;

// Instantiate the accurate multipliers
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

// Instantiate LUTs and perform addition
genvar k, l;
generate
    for (k = 0; k < 4; k = k + 1) begin: pp_add
        LUT6_2 #(
            .INIT(64'h9696969696969696)
        ) lut_inst0 (
            .I0(prod1[k+4]),
            .I1(prod2[k]),
            .I2(prod3[k]),
            .I3(1'b1),
            .I4(1'b1),
            .I5(1'b1),
            .O6(sum[k])
        );
    end
endgenerate

generate
    for (l = 0; l < 4; l = l + 1) begin: pp_add1
        LUT6_2 #(
            .INIT(64'h9696969696969696)
        ) lut_inst1 (
            .I0(prod2[l+4]),
            .I1(prod3[l+4]),
            .I2(prod4[l]),
            .I3(1'b1),
            .I4(1'b1),
            .I5(1'b1),
            .O6(sum[l+4])
        );
    end
endgenerate

// Assign values to PROD
genvar r, s, t;
generate
    for (r = 0; r < 4; r = r + 1) begin: assign_values0
        assign PROD[r] = prod1[r];
    end
endgenerate

generate
    for (s = 0; s < 8; s = s + 1) begin: assign_values1
        assign PROD[s + 4] = sum[s];
    end
endgenerate

generate
    for (t = 4; t < 8; t = t + 1) begin: assign_values3
        assign PROD[t + 8] = prod4[t];
    end
endgenerate

endmodule
