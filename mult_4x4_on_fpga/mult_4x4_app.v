`timescale 1ns / 1ps

//library IEEE;
//use IEEE.STD_LOGIC_1164.ALL;

//use IEEE.NUMERIC_STD.ALL;
//use IEEE.STD_LOGIC_UNSIGNED.ALL;

//library UNISIM;
//use UNISIM.VComponents.all;
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 18.04.2024 16:44:01
// Design Name:
// Module Name: mult4x4_app
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


module mult_4x4_app (
    input [3:0] a,
    input [3:0] b,
    output wire [7:0] prod
);

wire [5:0] pp0, pp1;
wire [7:0] gen, prop, carries1, out;

// LUT instantiations
LUT6_2 #( // P1 and P2
   .INIT(64'hB4CCF00066AACC00) // Specify LUT Contents
) LUT6_2_inst0 (
   .O6(pp0[2]), // 1-bit LUT6 output
   .O5(pp0[1]), // 1-bit lower LUT5 output
   .I0(a[0]), // 1-bit LUT input
   .I1(a[1]), // 1-bit LUT input
   .I2(a[2]), // 1-bit LUT input
   .I3(b[0]), // 1-bit LUT input
   .I4(b[1]), // 1-bit LUT input
   .I5(1)  // 1-bit LUT input (fast MUX select only available to O6 output)
);

LUT6_2 #( // P3
   .INIT(64'hC738F0F0FF000000) // Specify LUT Contents
) LUT6_2_inst1 (
   .O6(pp0[3]), // 1-bit LUT6 output
   //.O5(pp0[1]), // 1-bit lower LUT5 output
   .I0(a[0]), // 1-bit LUT input
   .I1(a[1]), // 1-bit LUT input
   .I2(a[2]), // 1-bit LUT input
   .I3(a[3]), // 1-bit LUT input
   .I4(b[0]), // 1-bit LUT input
   .I5(b[1])  // 1-bit LUT input (fast MUX select only available to O6 output)
);

LUT6_2 #( // P4
   .INIT(64'h07C0FF0000000000) // Specify LUT Contents
) LUT6_2_inst2 (
   .O6(pp0[4]), // 1-bit LUT6 output
   //.O5(pp0[1]), // 1-bit lower LUT5 output
   .I0(a[0]), // 1-bit LUT input
   .I1(a[1]), // 1-bit LUT input
   .I2(a[2]), // 1-bit LUT input
   .I3(a[3]), // 1-bit LUT input
   .I4(b[0]), // 1-bit LUT input
   .I5(b[1])  // 1-bit LUT input (fast MUX select only available to O6 output)
);

LUT6_2 #( // P5
   .INIT(64'hF800000000000000) // Specify LUT Contents
) LUT6_2_inst3 (
   .O6(pp0[5]), // 1-bit LUT6 output
   //.O5(pp0[1]), // 1-bit lower LUT5 output
   .I0(a[0]), // 1-bit LUT input
   .I1(a[1]), // 1-bit LUT input
   .I2(a[2]), // 1-bit LUT input
   .I3(a[3]), // 1-bit LUT input
   .I4(b[0]), // 1-bit LUT input
   .I5(b[1])  // 1-bit LUT input (fast MUX select only available to O6 output)
);
// Add other LUT instantiations here
    assign pp0[0] = 0;
    assign pp1[0] = 0;
  //  assign prod[2] = 0;
   
LUT6_2 #( // P1 and p2
   .INIT(64'hB4CCF00066AACC00) // Specify LUT Contents
) LUT6_2_inst4 (
   .O6(pp1[2]), // 1-bit LUT6 output
   .O5(pp1[1]), // 1-bit lower LUT5 output
   .I0(a[0]), // 1-bit LUT input
   .I1(a[1]), // 1-bit LUT input
   .I2(a[2]), // 1-bit LUT input
   .I3(b[2]), // 1-bit LUT input
   .I4(b[3]), // 1-bit LUT input
   .I5(1)  // 1-bit LUT input (fast MUX select only available to O6 output)
);

LUT6_2 #( // P3
   .INIT(64'hC738F0F0FF000000) // Specify LUT Contents
) LUT6_2_inst5 (
   .O6(pp1[3]), // 1-bit LUT6 output
   //.O5(pp1[1]), // 1-bit lower LUT5 output
   .I0(a[0]), // 1-bit LUT input
   .I1(a[1]), // 1-bit LUT input
   .I2(a[2]), // 1-bit LUT input
   .I3(a[3]), // 1-bit LUT input
   .I4(b[2]), // 1-bit LUT input
   .I5(b[3])  // 1-bit LUT input (fast MUX select only available to O6 output)
);

LUT6_2 #( // P4
   .INIT(64'hF800000000000000) // Specify LUT Contents
) LUT6_2_inst6 (
   .O6(gen[3]), // 1-bit LUT6 output
   //.O5(pp1[1]), // 1-bit lower LUT5 output
   .I0(a[0]), // 1-bit LUT input
   .I1(a[1]), // 1-bit LUT input
   .I2(a[2]), // 1-bit LUT input
   .I3(a[3]), // 1-bit LUT input
   .I4(b[2]), // 1-bit LUT input
   .I5(b[3])  // 1-bit LUT input (fast MUX select only available to O6 output)
);

LUT6_2 #( // P1 and p2
   .INIT(64'h5FA05FA088888888) // Specify LUT Contents
) LUT6_2_inst7 (
   .O6(prod[2]), // 1-bit LUT6 output
   .O5(prod[0]), // 1-bit lower LUT5 output
   .I0(a[0]), // 1-bit LUT input
   .I1(b[0]), // 1-bit LUT input
   .I2(b[2]), // 1-bit LUT input
   .I3(pp0[2]), // 1-bit LUT input
   .I4(1), // 1-bit LUT input
   .I5(1)  // 1-bit LUT input (fast MUX select only available to O6 output)
);

LUT6_2 #( // P4
   .INIT(64'h007F7F80FFEAEA00) // Specify LUT Contents
) LUT6_2_inst8 (
   .O6(prop[0]), // 1-bit LUT6 output
   .O5(gen[0]), // 1-bit lower LUT5 output
   .I0(pp0[2]), // 1-bit LUT input
   .I1(a[0]), // 1-bit LUT input
   .I2(b[2]), // 1-bit LUT input
   .I3(pp0[3]), // 1-bit LUT input
   .I4(pp1[1]), // 1-bit LUT input
   .I5(1)  // 1-bit LUT input (fast MUX select only available to O6 output)
);

LUT6_2 #( // P4
   .INIT(64'h6666666688888888) // Specify LUT Contents
) LUT6_2_inst9 (
   .O6(prop[1]), // 1-bit LUT6 output
   .O5(gen[1]), // 1-bit lower LUT5 output
   .I0(pp0[4]), // 1-bit LUT input
   .I1(pp1[2]), // 1-bit LUT input
   .I2(1), // 1-bit LUT input
   .I3(1), // 1-bit LUT input
   .I4(1), // 1-bit LUT input
   .I5(1)  // 1-bit LUT input (fast MUX select only available to O6 output)
);

LUT6_2 #( // P4
   .INIT(64'h6666666688888888) // Specify LUT Contents
) LUT6_2_inst10 (
   .O6(prop[2]), // 1-bit LUT6 output
   .O5(gen[2]), // 1-bit lower LUT5 output
   .I0(pp0[5]), // 1-bit LUT input
   .I1(pp1[3]), // 1-bit LUT input
   .I2(1), // 1-bit LUT input
   .I3(1), // 1-bit LUT input
   .I4(1), // 1-bit LUT input
   .I5(1)  // 1-bit LUT input (fast MUX select only available to O6 output)
);

LUT6_2 #( // P4
   .INIT(64'h07C0FF0000000000) // Specify LUT Contents
) LUT6_2_inst11 (
   .O6(prop[3]), // 1-bit LUT6 output
   //.O5(gen[0]), // 1-bit lower LUT5 output
   .I0(a[0]), // 1-bit LUT input
   .I1(a[1]), // 1-bit LUT input
   .I2(a[2]), // 1-bit LUT input
   .I3(a[3]), // 1-bit LUT input
   .I4(b[2]), // 1-bit LUT input
   .I5(b[3])  // 1-bit LUT input (fast MUX select only available to O6 output)
);

// Generate and propagate signals

CARRY4 CARRY4_inst (
   .CO(carries1[3:0]),         // 4-bit carry out
   .O(out[3:0]),           // 4-bit carry chain XOR data out
   .CI(1'b0),         // 1-bit carry cascade input
   .CYINIT(1'b0), // 1-bit carry initialization
   .DI(gen[3:0]),         // 4-bit carry-MUX data in
   .S(prop[3:0])            // 4-bit carry-MUX select input
);

// Add more carry chain instantiations here

// Assign output
//always @* begin
   assign prod[6:3] = out[3:0];
   assign prod[7] = carries1[3];
   assign prod[1] = pp0[1];
//end

endmodule

