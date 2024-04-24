`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.04.2024 13:21:41
// Design Name: 
// Module Name: adder
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


module adder #(parameter N = 8)(
    input [N-1:0] prod1,
    input [N-1:0] prod2,
    input [N-1:0] prod3,
    input [N-1:0] prod4,
    output [2*N-1:0] PROD
);

wire [N-1:0] a_reg, b_reg, c_reg;
wire [N/2-1:0] d_reg;
wire [N+N/2:0] p, g;
wire [2*N-1:0] s_reg;
wire c_in, c_out;
wire [2*N-1:0] c_i;

assign a_reg = {prod4[N/2-1:0], prod1[N-1:N/2]};
assign b_reg = prod2;
assign c_reg = prod3;
assign d_reg = prod4[N-1:N/2];

assign c_i[0] = c_in;
assign g[0] = 1'b0;
assign g[N+N/2:N+2] = 0;
assign p[N+N/2-1:N+1] = d_reg[N/2-1:1];
assign s_reg[N/2-1:0] = prod1[N/2-1:0];
assign PROD[15:0] = s_reg;
assign c_out = c_i[N+4];

// RCA part
genvar i;
generate
    begin : PG0
        LUT6_2 #(
            .INIT(32'h96969696E8E8E8E8)
        ) PG0_inst (
            .O6(p[0]),
            .O5(g[1]),
            .I5(1'b1),
            .I4(1'b1),
            .I3(1'b1),
            .I2(a_reg[0]),
            .I1(b_reg[0]),
            .I0(c_reg[0])
        );
    end

    genvar j;
    for (i = 1; i < N; i = i + 1) begin : genPG
        LUT6_2 #(
            .INIT(32'h69966996E8E8E8E8)
        ) PG_inst (
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

    begin : PGN
        LUT6_2 #(
            .INIT(32'h17E817E8E8E8E8E8)
        ) PGN_inst (
            .O6(p[N]),
            .O5(g[N+1]),
            .I5(1'b1),
            .I4(1'b1),
            .I3(d_reg[0]),
            .I2(a_reg[N-1]),
            .I1(b_reg[N-1]),
            .I0(c_reg[N-1])
        );
    end

    genvar k;
    for (i = 0; i < N/4; i = i + 1) begin : genCC
        CARRY4 CC_inst (
            .CO(c_i[4*i+4:4*i+1]),
            .O(s_reg[4*i+N-1:4*i+N/2]),
            .CI(c_i[4*i]),
            .CYINIT(1'b0),
            .DI(g[4*i+3:4*i]),
            .S(p[4*i+3:4*i])
        );
    end

    begin : CCN
        CARRY4 CCN_inst (
            .CO(c_i[N+4:N+1]),
            .O(s_reg[N+N-1:N+N/2]),
            .CI(c_i[N]),
             .CYINIT(1'b0),
            .DI(g[N+4:N+1]),
            .S(p[N+3:N])
        );
    end
endgenerate

endmodule
