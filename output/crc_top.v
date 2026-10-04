/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : W-2024.09-SP2
// Date      : Mon Sep 28 04:05:46 2026
/////////////////////////////////////////////////////////////


module crc_top ( clk, rst, data, divisor, received_data, transmitted_data, 
        valid, error );
  input [7:0] data;
  input [3:0] divisor;
  input [10:0] received_data;
  output [10:0] transmitted_data;
  input clk, rst;
  output valid, error;
  wire   \gen/n9 , \gen/n2 , \gen/N64 , \check/n4 , n82, n96, n98, n100, n102,
         n104, n106, n108, n110, n112, n114, n116, n118, n120, n122, n123,
         n124, n125, n126, n127, n128, n129, n130, n131, n132, n133, n134,
         n135, n136, n137, n138, n139, n140, n141, n142, n143, n144, n145,
         n146, n147, n148, n149, n150, n151, n152, n153, n154, n155, n156,
         n157, n158, n159, n160, n161, n162, n163, n164, n165, n166, n167,
         n168, n169, n170, n171, n172, n173, n174, n175, n176, n177, n178,
         n179, n180, n181, n182, n183, n184, n185, n186, n187, n188, n189,
         n190, n191, n192, n193, n194, n195, n196, n197, n198, n199, n200;

  DFFSSRX1_RVT \gen/transmitted_data_reg[1]  ( .D(1'b0), .SETB(rst), .RSTB(
        \gen/n9 ), .CLK(clk), .QN(n96) );
  DFFSSRX1_RVT \gen/transmitted_data_reg[2]  ( .D(1'b0), .SETB(rst), .RSTB(
        \gen/n2 ), .CLK(clk), .QN(n98) );
  DFFSSRX1_RVT \gen/transmitted_data_reg[3]  ( .D(1'b0), .SETB(rst), .RSTB(
        data[0]), .CLK(clk), .QN(n100) );
  DFFSSRX1_RVT \gen/transmitted_data_reg[4]  ( .D(1'b0), .SETB(rst), .RSTB(
        data[1]), .CLK(clk), .QN(n102) );
  DFFSSRX1_RVT \gen/transmitted_data_reg[5]  ( .D(1'b0), .SETB(rst), .RSTB(
        data[2]), .CLK(clk), .QN(n104) );
  DFFSSRX1_RVT \gen/transmitted_data_reg[6]  ( .D(1'b0), .SETB(rst), .RSTB(
        data[3]), .CLK(clk), .QN(n106) );
  DFFSSRX1_RVT \gen/transmitted_data_reg[7]  ( .D(1'b0), .SETB(rst), .RSTB(
        data[4]), .CLK(clk), .QN(n108) );
  DFFSSRX1_RVT \gen/transmitted_data_reg[8]  ( .D(1'b0), .SETB(rst), .RSTB(
        data[5]), .CLK(clk), .QN(n110) );
  DFFSSRX1_RVT \gen/transmitted_data_reg[9]  ( .D(1'b0), .SETB(rst), .RSTB(
        data[6]), .CLK(clk), .QN(n112) );
  DFFSSRX1_RVT \gen/transmitted_data_reg[10]  ( .D(1'b0), .SETB(rst), .RSTB(
        data[7]), .CLK(clk), .QN(n114) );
  DFFX1_RVT \gen/transmitted_data_reg[0]  ( .D(\gen/N64 ), .CLK(clk), .QN(n120) );
  DFFSSRX1_RVT \check/error_reg  ( .D(1'b0), .SETB(rst), .RSTB(n82), .CLK(clk), 
        .QN(n116) );
  DFFSSRX1_RVT \check/valid_reg  ( .D(1'b0), .SETB(rst), .RSTB(\check/n4 ), 
        .CLK(clk), .QN(n118) );
  INVX0_RVT U99 ( .A(divisor[2]), .Y(n181) );
  INVX0_RVT U100 ( .A(divisor[0]), .Y(n180) );
  OR3X1_RVT U101 ( .A1(n186), .A2(received_data[0]), .A3(n185), .Y(n188) );
  INVX0_RVT U102 ( .A(n82), .Y(\check/n4 ) );
  INVX0_RVT U103 ( .A(rst), .Y(n149) );
  INVX4_RVT U104 ( .A(n96), .Y(transmitted_data[1]) );
  INVX4_RVT U105 ( .A(n98), .Y(transmitted_data[2]) );
  INVX4_RVT U106 ( .A(n100), .Y(transmitted_data[3]) );
  INVX4_RVT U107 ( .A(n102), .Y(transmitted_data[4]) );
  INVX4_RVT U108 ( .A(n104), .Y(transmitted_data[5]) );
  INVX4_RVT U109 ( .A(n106), .Y(transmitted_data[6]) );
  INVX4_RVT U110 ( .A(n108), .Y(transmitted_data[7]) );
  INVX4_RVT U111 ( .A(n110), .Y(transmitted_data[8]) );
  INVX4_RVT U112 ( .A(n112), .Y(transmitted_data[9]) );
  INVX4_RVT U113 ( .A(n114), .Y(transmitted_data[10]) );
  INVX4_RVT U114 ( .A(n116), .Y(error) );
  INVX4_RVT U115 ( .A(n118), .Y(valid) );
  INVX4_RVT U116 ( .A(n120), .Y(transmitted_data[0]) );
  AND2X1_RVT U117 ( .A1(data[7]), .A2(divisor[2]), .Y(n122) );
  HADDX1_RVT U118 ( .A0(n122), .B0(data[6]), .SO(n129) );
  NAND2X0_RVT U119 ( .A1(divisor[2]), .A2(n129), .Y(n124) );
  NAND2X0_RVT U120 ( .A1(divisor[1]), .A2(data[7]), .Y(n123) );
  FADDX1_RVT U121 ( .A(data[5]), .B(n124), .CI(n123), .S(n134) );
  NAND2X0_RVT U122 ( .A1(divisor[2]), .A2(n134), .Y(n128) );
  AO22X1_RVT U123 ( .A1(divisor[0]), .A2(data[7]), .A3(n129), .A4(divisor[1]), 
        .Y(n126) );
  NAND4X0_RVT U124 ( .A1(divisor[0]), .A2(data[7]), .A3(n129), .A4(divisor[1]), 
        .Y(n125) );
  NAND2X0_RVT U125 ( .A1(n126), .A2(n125), .Y(n127) );
  FADDX1_RVT U126 ( .A(data[4]), .B(n128), .CI(n127), .S(n139) );
  NAND2X0_RVT U127 ( .A1(divisor[1]), .A2(n139), .Y(n138) );
  NAND2X0_RVT U128 ( .A1(divisor[2]), .A2(n139), .Y(n133) );
  AO22X1_RVT U129 ( .A1(divisor[0]), .A2(n129), .A3(n134), .A4(divisor[1]), 
        .Y(n131) );
  NAND4X0_RVT U130 ( .A1(divisor[0]), .A2(n129), .A3(n134), .A4(divisor[1]), 
        .Y(n130) );
  NAND2X0_RVT U131 ( .A1(n131), .A2(n130), .Y(n132) );
  FADDX1_RVT U132 ( .A(data[3]), .B(n133), .CI(n132), .S(n144) );
  AO22X1_RVT U133 ( .A1(divisor[0]), .A2(n134), .A3(n144), .A4(divisor[2]), 
        .Y(n136) );
  NAND4X0_RVT U134 ( .A1(divisor[0]), .A2(n134), .A3(n144), .A4(divisor[2]), 
        .Y(n135) );
  NAND2X0_RVT U135 ( .A1(n136), .A2(n135), .Y(n137) );
  FADDX1_RVT U136 ( .A(data[2]), .B(n138), .CI(n137), .S(n196) );
  NAND2X0_RVT U137 ( .A1(divisor[1]), .A2(n196), .Y(n148) );
  NAND2X0_RVT U138 ( .A1(divisor[1]), .A2(n144), .Y(n143) );
  AO22X1_RVT U139 ( .A1(divisor[0]), .A2(n139), .A3(n196), .A4(divisor[2]), 
        .Y(n141) );
  NAND4X0_RVT U140 ( .A1(divisor[0]), .A2(n139), .A3(n196), .A4(divisor[2]), 
        .Y(n140) );
  NAND2X0_RVT U141 ( .A1(n141), .A2(n140), .Y(n142) );
  FADDX1_RVT U142 ( .A(data[1]), .B(n143), .CI(n142), .S(n197) );
  AO22X1_RVT U143 ( .A1(divisor[0]), .A2(n144), .A3(n197), .A4(divisor[2]), 
        .Y(n146) );
  NAND4X0_RVT U144 ( .A1(divisor[0]), .A2(n144), .A3(n197), .A4(divisor[2]), 
        .Y(n145) );
  NAND2X0_RVT U145 ( .A1(n146), .A2(n145), .Y(n147) );
  FADDX1_RVT U146 ( .A(data[0]), .B(n148), .CI(n147), .S(n195) );
  AND3X1_RVT U147 ( .A1(n195), .A2(divisor[0]), .A3(n149), .Y(\gen/N64 ) );
  AND2X1_RVT U148 ( .A1(received_data[10]), .A2(divisor[2]), .Y(n150) );
  HADDX1_RVT U149 ( .A0(n150), .B0(received_data[9]), .SO(n157) );
  NAND2X0_RVT U150 ( .A1(divisor[2]), .A2(n157), .Y(n152) );
  NAND2X0_RVT U151 ( .A1(received_data[10]), .A2(divisor[1]), .Y(n151) );
  FADDX1_RVT U152 ( .A(n152), .B(received_data[8]), .CI(n151), .S(n162) );
  NAND2X0_RVT U153 ( .A1(divisor[2]), .A2(n162), .Y(n156) );
  AO22X1_RVT U154 ( .A1(divisor[0]), .A2(received_data[10]), .A3(n157), .A4(
        divisor[1]), .Y(n154) );
  NAND4X0_RVT U155 ( .A1(divisor[0]), .A2(received_data[10]), .A3(n157), .A4(
        divisor[1]), .Y(n153) );
  NAND2X0_RVT U156 ( .A1(n154), .A2(n153), .Y(n155) );
  FADDX1_RVT U157 ( .A(received_data[7]), .B(n156), .CI(n155), .S(n167) );
  NAND2X0_RVT U158 ( .A1(divisor[2]), .A2(n167), .Y(n161) );
  AO22X1_RVT U159 ( .A1(divisor[0]), .A2(n157), .A3(n162), .A4(divisor[1]), 
        .Y(n159) );
  NAND4X0_RVT U160 ( .A1(divisor[0]), .A2(n157), .A3(n162), .A4(divisor[1]), 
        .Y(n158) );
  NAND2X0_RVT U161 ( .A1(n159), .A2(n158), .Y(n160) );
  FADDX1_RVT U162 ( .A(received_data[6]), .B(n161), .CI(n160), .S(n175) );
  NAND2X0_RVT U163 ( .A1(divisor[1]), .A2(n175), .Y(n171) );
  NAND2X0_RVT U164 ( .A1(divisor[1]), .A2(n167), .Y(n166) );
  AO22X1_RVT U165 ( .A1(n162), .A2(divisor[0]), .A3(n175), .A4(divisor[2]), 
        .Y(n164) );
  NAND4X0_RVT U166 ( .A1(n162), .A2(divisor[0]), .A3(n175), .A4(divisor[2]), 
        .Y(n163) );
  NAND2X0_RVT U167 ( .A1(n164), .A2(n163), .Y(n165) );
  FADDX1_RVT U168 ( .A(received_data[5]), .B(n166), .CI(n165), .S(n174) );
  AO22X1_RVT U169 ( .A1(divisor[0]), .A2(n167), .A3(n174), .A4(divisor[2]), 
        .Y(n169) );
  NAND4X0_RVT U170 ( .A1(divisor[0]), .A2(n167), .A3(n174), .A4(divisor[2]), 
        .Y(n168) );
  NAND2X0_RVT U171 ( .A1(n169), .A2(n168), .Y(n170) );
  FADDX1_RVT U172 ( .A(received_data[4]), .B(n171), .CI(n170), .S(n183) );
  NAND2X0_RVT U173 ( .A1(divisor[1]), .A2(n183), .Y(n173) );
  NAND2X0_RVT U174 ( .A1(n174), .A2(divisor[0]), .Y(n172) );
  FADDX1_RVT U175 ( .A(n173), .B(received_data[2]), .CI(n172), .S(n186) );
  AO22X1_RVT U176 ( .A1(received_data[0]), .A2(n180), .A3(n186), .A4(n181), 
        .Y(n192) );
  NAND2X0_RVT U177 ( .A1(divisor[1]), .A2(n174), .Y(n179) );
  AO22X1_RVT U178 ( .A1(divisor[0]), .A2(n175), .A3(n183), .A4(divisor[2]), 
        .Y(n177) );
  NAND4X0_RVT U179 ( .A1(divisor[0]), .A2(n175), .A3(n183), .A4(divisor[2]), 
        .Y(n176) );
  NAND2X0_RVT U180 ( .A1(n177), .A2(n176), .Y(n178) );
  FADDX1_RVT U181 ( .A(received_data[3]), .B(n179), .CI(n178), .S(n185) );
  OA22X1_RVT U182 ( .A1(n186), .A2(n181), .A3(received_data[0]), .A4(n180), 
        .Y(n182) );
  NAND2X0_RVT U183 ( .A1(n185), .A2(n182), .Y(n190) );
  AND2X1_RVT U184 ( .A1(n183), .A2(divisor[0]), .Y(n184) );
  HADDX1_RVT U185 ( .A0(n184), .B0(received_data[1]), .SO(n187) );
  HADDX1_RVT U186 ( .A0(n187), .B0(divisor[1]), .SO(n189) );
  OA22X1_RVT U187 ( .A1(n190), .A2(n189), .A3(n188), .A4(n187), .Y(n191) );
  OR2X1_RVT U188 ( .A1(n192), .A2(n191), .Y(n82) );
  NAND2X0_RVT U189 ( .A1(n197), .A2(divisor[0]), .Y(n194) );
  NAND2X0_RVT U190 ( .A1(n195), .A2(divisor[1]), .Y(n193) );
  HADDX1_RVT U191 ( .A0(n194), .B0(n193), .SO(\gen/n9 ) );
  NAND2X0_RVT U192 ( .A1(divisor[2]), .A2(n195), .Y(n200) );
  AND2X1_RVT U193 ( .A1(divisor[0]), .A2(n196), .Y(n199) );
  NAND2X0_RVT U194 ( .A1(n197), .A2(divisor[1]), .Y(n198) );
  FADDX1_RVT U195 ( .A(n200), .B(n199), .CI(n198), .S(\gen/n2 ) );
endmodule
