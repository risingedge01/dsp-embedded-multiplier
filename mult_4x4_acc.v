`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2024 15:31:26
// Design Name: 
// Module Name: mult_4x4_acc
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


module mult_accurate (
    input [3:0] a,
    input [3:0] b,
    output wire [7:0] prod
);

wire [5:0] pp0, pp1;
wire [7:0] gen, prop, carries1, out;
wire [7:0] gen1, prop1, carries2, output1;

// LUT6_2 instantiation
LUT6_2 #(
    .INIT(64'hB4CCF00066AACC00) // P1 and P2
) lut_inst1 (
    .O6(pp0[2]), // 1-bit LUT6 output
    .O5(pp0[1]), // 1-bit lower LUT5 output
    .I0(a[0]),   // 1-bit LUT input
    .I1(a[1]),   // 1-bit LUT input
    .I2(a[2]),   // 1-bit LUT input
    .I3(b[0]),   // 1-bit LUT input
    .I4(b[1]),   // 1-bit LUT input
    .I5(1'b1)    // 1-bit LUT input
);

LUT6_2 #(
    .INIT(64'hC738F0F0FF000000) // P3
) lut_inst2 (
    .O6(pp0[3]),
   // .O5(1'b0),
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
    .O6(pp0[4]),
   // .O5(1'b0),
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
    .O6(pp0[5]),
   // .O5(1'b0),
    .I0(a[0]),
    .I1(a[1]),
    .I2(a[2]),
    .I3(a[3]),
    .I4(b[0]),
    .I5(b[1])
);

LUT6_2 #(
    .INIT(64'hA0A0A0A088888888) // P0 and P0
) lut_inst4a (
    .O6(pp1[0]),
    .O5(pp0[0]),
    .I0(a[0]),
    .I1(b[0]),
    .I2(b[2]),
    .I3(1'b1),
    .I4(1'b1),
    .I5(1'b1)
);

LUT6_2 #(
    .INIT(64'hB4CCF00066AACC00) // P1 and P2
) lut_inst6 (
    .O6(pp1[2]),
    .O5(pp1[1]),
    .I0(a[0]),
    .I1(a[1]),
    .I2(a[2]),
    .I3(b[2]),
    .I4(b[3]),
    .I5(1'b1)
);

LUT6_2 #(
    .INIT(64'hC738F0F0FF000000) // P3
) lut_inst7 (
    .O6(pp1[3]),
   // .O5(1'b0),
    .I0(a[0]),
    .I1(a[1]),
    .I2(a[2]),
    .I3(a[3]),
    .I4(b[2]),
    .I5(b[3])
);

LUT6_2 #(
    .INIT(64'h07C0FF0000000000) // P4
) lut_inst8 (
    .O6(pp1[4]),
   // .O5(1'b0),
    .I0(a[0]),
    .I1(a[1]),
    .I2(a[2]),
    .I3(a[3]),
    .I4(b[2]),
    .I5(b[3])
);

LUT6_2 #(
    .INIT(64'hF800000000000000) // P5
) lut_inst9 (
    .O6(pp1[5]),
  //  .O5(1'b0),
    .I0(a[0]),
    .I1(a[1]),
    .I2(a[2]),
    .I3(a[3]),
    .I4(b[2]),
    .I5(b[3])
);

LUT6_2 #(
    .INIT(64'h6666666688888888)
) lut_inst11 (
    .O6(prop[0]),
    .O5(gen[0]),
    .I0(pp0[2]),
    .I1(pp1[0]),
    .I2(1'b1),
    .I3(1'b1),
    .I4(1'b1),
    .I5(1'b1)
);

LUT6_2 #(
    .INIT(64'h6666666688888888)
) lut_inst12 (
    .O6(prop[1]),
    .O5(gen[1]),
    .I0(pp0[3]),
    .I1(pp1[1]),
    .I2(1'b1),
    .I3(1'b1),
    .I4(1'b1),
    .I5(1'b1)
);

LUT6_2 #(
    .INIT(64'h6666666688888888)
) lut_inst13 (
    .O6(prop[2]),
    .O5(gen[2]),
    .I0(pp0[4]),
    .I1(pp1[2]),
    .I2(1'b1),
    .I3(1'b1),
    .I4(1'b1),
    .I5(1'b1)
);

LUT6_2 #(
    .INIT(64'h6666666688888888)
) lut_inst14 (
    .O6(prop[3]),
    .O5(gen[3]),
    .I0(pp0[5]),
    .I1(pp1[3]),
    .I2(1'b1),
    .I3(1'b1),
    .I4(1'b1),
    .I5(1'b1)
);



// Carry chain instantiation
CARRY4 carry_inst1 (
    .DI(gen[3:0]),
    .S(prop[3:0]),
    .O(out[3:0]),
    .CO(carries1[3:0]),
    .CI(1'b0),
    .CYINIT(1'b0)
);

CARRY4 carry_inst2 (
    .DI(gen[7:4]),
    .S(prop[7:4]),
    .O(out[7:4]),
    .CO(carries1[7:4]),
    .CI(carries1[3]),
    .CYINIT(1'b0)
);



// Output assignment
    assign gen[7:4] = 4'b0000;
    assign prop[4] = pp1[4];
    assign prop[5] = pp1[5];
    assign prop[6] = 1'b0;
    assign prop[7] = 1'b0;

    assign prod[7:2] = out[5:0];
    assign prod[1] = pp0[1];
    assign prod[0] = pp0[0];

endmodule
