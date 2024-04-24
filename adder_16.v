`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2024 23:11:43
// Design Name: 
// Module Name: adder_16
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


module adder_16 #(parameter N = 16)
(
    input [N-1:0] prod1,
    input [N-1:0] prod2,
    input [N-1:0] prod3,
    input [N-1:0] prod4,
    output [2*N-1:0] PROD
);

// Signal Declarations
wire [N-1:0] a_reg, b_reg, c_reg;
wire [N/2-1:0] d_reg;
wire [N+N/2:0] p, g;
wire [2*N-1:0] s_reg;
wire c_in, c_out;
wire [2*N-1:0] c_i;

//  assign a_reg = {N{1'b0}};
//  assign  b_reg = {N{1'b0}};
//  assign  c_reg = {N{1'b0}};
//  assign  d_reg = {N/2{1'b0}};
//  assign  p = {N+N/2+1{1'b0}};
//  assign  g = {N+N/2+1{1'b0}};
//  assign  s_reg = {2*N{1'b0}};
//  assign  c_in = 1'b0;
//  assign  c_out = 1'b0;
//  assign  c_i = {2*N{1'b0}};

// Signal Assignment
assign a_reg = {prod4[N/2-1:0], prod1[N-1:N/2]};
assign b_reg = prod2;
assign c_reg = prod3;
assign d_reg = prod4[N-1:N/2];
assign c_i[0] = c_in;
assign g[0] = 0;
assign g[N+N/2:N+2] = 0;
assign p[N+N/2-1:N+1] = d_reg[N/2-1:1];
assign s_reg[N/2-1:0] = prod1[N/2-1:0];
assign PROD[31:0] = s_reg;
assign c_out = c_i[N+4];

// RCA Part
genvar i;
generate
    for (i = 1; i < N-1; i = i + 1) begin : PGi_loop
        LUT6_2 #(
            .INIT(64'h96969696E8E8E8E8) // P1 and P2
        ) PGi (
            .O6(p[i]),
            .O5(g[i+1]),
            .I5(1'b1),
            .I4(1'b1),
            .I3(g[i]),
            .I2(a_reg[i]),
            .I1(b_reg[i]),
            .I0(c_reg[i])
        );
    end
endgenerate

LUT6_2 #(
            .INIT(64'h96969696E8E8E8E8) // P1 and P2
        ) PG0 (
            .O6(p[0]),
            .O5(g[1]),
            .I5(1'b1),
            .I4(1'b1),
            .I3(1'b1),
            .I2(a_reg[0]),
            .I1(b_reg[0]),
            .I0(c_reg[0])
 );

LUT6_2 #(
    .INIT(64'h17E817E8E8E8E8E8) // P1 and P2
) PGN (
    .O6(p[N]),
    .O5(g[N+1]),
    .I5(1'b1),
    .I4(1'b1),
    .I3(d_reg[0]),
    .I2(a_reg[N-1]),
    .I1(b_reg[N-1]),
    .I0(c_reg[N-1])
); // PGN instance

// Carry Chains
CARRY4 CCi1 (
    .CO(c_i[4:1]),
    .O(s_reg[11:8]),
    .CI(c_i[0]),
    .CYINIT(1'b0),
    .DI(g[3:0]),
    .S(p[3:0])
);

CARRY4 CCi2 (
    .CO(c_i[8:5]),
    .O(s_reg[15:12]),
    .CI(c_i[4]),
    .CYINIT(1'b0),
    .DI(g[7:4]),
    .S(p[7:4])
);

CARRY4 CCi3 (
    .CO(c_i[12:9]),
    .O(s_reg[19:16]),
    .CI(c_i[8]),
    .CYINIT(1'b0),
    .DI(g[11:8]),
    .S(p[11:8])
);

CARRY4 CCi4 (
    .CO(c_i[16:13]),
    .O(s_reg[23:20]),
    .CI(c_i[12]),
    .CYINIT(1'b0),
    .DI(g[15:12]),
    .S(p[15:12])
);

CARRY4 CCi5 (
    .CO(c_i[20:17]),
    .O(s_reg[27:24]),
    .CI(c_i[16]),
    .CYINIT(1'b0),
    .DI(g[19:16]),
    .S(p[19:16])
);

CARRY4 CCi6 (
    .CO(c_i[24:21]),
    .O(s_reg[31:28]),
    .CI(c_i[20]),
    .CYINIT(1'b0),
    .DI(g[23:20]),
    .S(p[23:20])
);

endmodule
