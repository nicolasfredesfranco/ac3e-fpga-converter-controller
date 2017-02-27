////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.20131013
//  \   \         Application: netgen
//  /   /         Filename: float_to_fixed.v
// /___/   /\     Timestamp: Tue Feb 21 10:34:42 2017
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -w -sim -ofmt verilog C:/Users/Usuario/Desktop/prueba_atly/project4_atly/ipcore_dir/tmp/_cg/float_to_fixed.ngc C:/Users/Usuario/Desktop/prueba_atly/project4_atly/ipcore_dir/tmp/_cg/float_to_fixed.v 
// Device	: 6slx45csg324-3
// Input file	: C:/Users/Usuario/Desktop/prueba_atly/project4_atly/ipcore_dir/tmp/_cg/float_to_fixed.ngc
// Output file	: C:/Users/Usuario/Desktop/prueba_atly/project4_atly/ipcore_dir/tmp/_cg/float_to_fixed.v
// # of Modules	: 1
// Design Name	: float_to_fixed
// Xilinx        : C:\Xilinx\14.7\ISE_DS\ISE\
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module float_to_fixed (
  operation_nd, clk, ce, rdy, a, result
)/* synthesis syn_black_box syn_noprune=1 */;
  input operation_nd;
  input clk;
  input ce;
  output rdy;
  input [31 : 0] a;
  output [37 : 0] result;
  
  // synthesis translate_off
  
  wire \U0/op_inst/FLT_PT_OP/HND_SHK/RDY ;
  wire sig00000001;
  wire sig00000002;
  wire sig00000003;
  wire sig00000004;
  wire sig00000005;
  wire sig00000006;
  wire sig00000007;
  wire sig00000008;
  wire sig00000009;
  wire sig0000000a;
  wire sig0000000b;
  wire sig0000000c;
  wire sig0000000d;
  wire sig0000000e;
  wire sig0000000f;
  wire sig00000010;
  wire sig00000011;
  wire sig00000012;
  wire sig00000013;
  wire sig00000014;
  wire sig00000015;
  wire sig00000016;
  wire sig00000017;
  wire sig00000018;
  wire sig00000019;
  wire sig0000001a;
  wire sig0000001b;
  wire sig0000001c;
  wire sig0000001d;
  wire sig0000001e;
  wire sig0000001f;
  wire sig00000020;
  wire sig00000021;
  wire sig00000022;
  wire sig00000023;
  wire sig00000024;
  wire sig00000025;
  wire sig00000026;
  wire sig00000027;
  wire sig00000028;
  wire sig00000029;
  wire sig0000002a;
  wire sig0000002b;
  wire sig0000002c;
  wire sig0000002d;
  wire sig0000002e;
  wire sig0000002f;
  wire sig00000030;
  wire sig00000031;
  wire sig00000032;
  wire sig00000033;
  wire sig00000034;
  wire sig00000035;
  wire sig00000036;
  wire sig00000037;
  wire sig00000038;
  wire sig00000039;
  wire sig0000003a;
  wire sig0000003b;
  wire sig0000003c;
  wire sig0000003d;
  wire sig0000003e;
  wire sig0000003f;
  wire sig00000040;
  wire sig00000041;
  wire sig00000042;
  wire sig00000043;
  wire sig00000044;
  wire sig00000045;
  wire sig00000046;
  wire sig00000047;
  wire sig00000048;
  wire sig00000049;
  wire sig0000004a;
  wire sig0000004b;
  wire sig0000004c;
  wire sig0000004d;
  wire sig0000004e;
  wire sig0000004f;
  wire sig00000050;
  wire sig00000051;
  wire sig00000052;
  wire sig00000053;
  wire sig00000054;
  wire sig00000055;
  wire sig00000056;
  wire sig00000057;
  wire sig00000058;
  wire sig00000059;
  wire sig0000005a;
  wire sig0000005b;
  wire sig0000005c;
  wire sig0000005d;
  wire sig0000005e;
  wire sig0000005f;
  wire sig00000060;
  wire sig00000061;
  wire sig00000062;
  wire sig00000063;
  wire sig00000064;
  wire sig00000065;
  wire sig00000066;
  wire sig00000067;
  wire sig00000068;
  wire sig00000069;
  wire sig0000006a;
  wire sig0000006b;
  wire sig0000006c;
  wire sig0000006d;
  wire sig0000006e;
  wire sig0000006f;
  wire sig00000070;
  wire sig00000071;
  wire sig00000072;
  wire sig00000073;
  wire sig00000074;
  wire sig00000075;
  wire sig00000076;
  wire sig00000077;
  wire sig00000078;
  wire sig00000079;
  wire sig0000007a;
  wire sig0000007b;
  wire sig0000007c;
  wire sig0000007d;
  wire sig0000007e;
  wire sig0000007f;
  wire sig00000080;
  wire sig00000081;
  wire sig00000082;
  wire sig00000083;
  wire sig00000084;
  wire sig00000085;
  wire sig00000086;
  wire sig00000087;
  wire sig00000088;
  wire sig00000089;
  wire sig0000008a;
  wire sig0000008b;
  wire sig0000008c;
  wire sig0000008d;
  wire sig0000008e;
  wire sig0000008f;
  wire sig00000090;
  wire sig00000091;
  wire sig00000092;
  wire sig00000093;
  wire sig00000094;
  wire sig00000095;
  wire sig00000096;
  wire sig00000097;
  wire sig00000098;
  wire sig00000099;
  wire sig0000009a;
  wire sig0000009b;
  wire sig0000009c;
  wire sig0000009d;
  wire sig0000009e;
  wire sig0000009f;
  wire sig000000a0;
  wire sig000000a1;
  wire sig000000a2;
  wire sig000000a3;
  wire sig000000a4;
  wire sig000000a5;
  wire sig000000a6;
  wire sig000000a7;
  wire sig000000a8;
  wire sig000000a9;
  wire sig000000aa;
  wire sig000000ab;
  wire sig000000ac;
  wire sig000000ad;
  wire sig000000ae;
  wire sig000000af;
  wire sig000000b0;
  wire sig000000b1;
  wire sig000000b2;
  wire sig000000b3;
  wire sig000000b4;
  wire sig000000b5;
  wire sig000000b6;
  wire sig000000b7;
  wire sig000000b8;
  wire sig000000b9;
  wire sig000000ba;
  wire sig000000bb;
  wire sig000000bc;
  wire sig000000bd;
  wire sig000000be;
  wire sig000000bf;
  wire sig000000c0;
  wire sig000000c1;
  wire sig000000c2;
  wire sig000000c3;
  wire sig000000c4;
  wire sig000000c5;
  wire sig000000c6;
  wire sig000000c7;
  wire sig000000c8;
  wire sig000000c9;
  wire sig000000ca;
  wire sig000000cb;
  wire sig000000cc;
  wire sig000000cd;
  wire sig000000ce;
  wire sig000000cf;
  wire sig000000d0;
  wire sig000000d1;
  wire sig000000d2;
  wire sig000000d3;
  wire sig000000d4;
  wire sig000000d5;
  wire sig000000d6;
  wire sig000000d7;
  wire sig000000d8;
  wire sig000000d9;
  wire sig000000da;
  wire sig000000db;
  wire sig000000dc;
  wire sig000000dd;
  wire sig000000de;
  wire sig000000df;
  wire sig000000e0;
  wire sig000000e1;
  wire sig000000e2;
  wire sig000000e3;
  wire sig000000e4;
  wire sig000000e5;
  wire sig000000e6;
  wire sig000000e7;
  wire sig000000e8;
  wire sig000000e9;
  wire sig000000ea;
  wire sig000000eb;
  wire sig000000ec;
  wire sig000000ed;
  wire sig000000ee;
  wire sig000000ef;
  wire sig000000f0;
  wire sig000000f1;
  wire sig000000f2;
  wire sig000000f3;
  wire sig000000f4;
  wire sig000000f5;
  wire sig000000f6;
  wire sig000000f7;
  wire sig000000f8;
  wire sig000000f9;
  wire sig000000fa;
  wire sig000000fb;
  wire sig000000fc;
  wire sig000000fd;
  wire sig000000fe;
  wire sig000000ff;
  wire sig00000100;
  wire sig00000101;
  wire sig00000102;
  wire sig00000103;
  wire sig00000104;
  wire sig00000105;
  wire sig00000106;
  wire sig00000107;
  wire sig00000108;
  wire sig00000109;
  wire sig0000010a;
  wire sig0000010b;
  wire sig0000010c;
  wire sig0000010d;
  wire sig0000010e;
  wire sig0000010f;
  wire sig00000110;
  wire sig00000111;
  wire sig00000112;
  wire sig00000113;
  wire sig00000114;
  wire sig00000115;
  wire sig00000116;
  wire sig00000117;
  wire sig00000118;
  wire sig00000119;
  wire sig0000011a;
  wire sig0000011b;
  wire sig0000011c;
  wire sig0000011d;
  wire sig0000011e;
  wire sig0000011f;
  wire sig00000120;
  wire sig00000121;
  wire sig00000122;
  wire sig00000123;
  wire sig00000124;
  wire sig00000125;
  wire sig00000126;
  wire sig00000127;
  wire sig00000128;
  wire sig00000129;
  wire sig0000012a;
  wire sig0000012b;
  wire sig0000012c;
  wire sig0000012d;
  wire sig0000012e;
  wire sig0000012f;
  wire sig00000130;
  wire sig00000131;
  wire sig00000132;
  wire sig00000133;
  wire sig00000134;
  wire sig00000135;
  wire sig00000136;
  wire sig00000137;
  wire sig00000138;
  wire sig00000139;
  wire sig0000013a;
  wire sig0000013b;
  wire sig0000013c;
  wire sig0000013d;
  wire sig0000013e;
  wire sig0000013f;
  wire sig00000140;
  wire sig00000141;
  wire sig00000142;
  wire sig00000143;
  wire sig00000144;
  wire sig00000145;
  wire sig00000146;
  wire sig00000147;
  wire sig00000148;
  wire sig00000149;
  wire sig0000014a;
  wire sig0000014b;
  wire sig0000014c;
  wire sig0000014d;
  wire sig0000014e;
  wire sig0000014f;
  wire sig00000150;
  wire sig00000151;
  wire sig00000152;
  wire sig00000153;
  wire sig00000154;
  wire sig00000155;
  wire sig00000156;
  wire sig00000157;
  wire sig00000158;
  wire sig00000159;
  wire sig0000015a;
  wire sig0000015b;
  wire sig0000015c;
  wire sig0000015d;
  wire sig0000015e;
  wire sig0000015f;
  wire sig00000160;
  wire sig00000161;
  wire sig00000162;
  wire sig00000163;
  wire sig00000164;
  wire sig00000165;
  wire sig00000166;
  wire sig00000167;
  wire sig00000168;
  wire sig00000169;
  wire sig0000016a;
  wire sig0000016b;
  wire sig0000016c;
  wire sig0000016d;
  wire sig0000016e;
  wire sig0000016f;
  wire sig00000170;
  wire sig00000171;
  wire sig00000172;
  wire sig00000173;
  wire sig00000174;
  wire sig00000175;
  wire sig00000176;
  wire sig00000177;
  wire sig00000178;
  wire sig00000179;
  wire sig0000017a;
  wire sig0000017b;
  wire sig0000017c;
  wire sig0000017d;
  wire sig0000017e;
  wire sig0000017f;
  wire sig00000180;
  wire sig00000181;
  wire sig00000182;
  wire sig00000183;
  wire sig00000184;
  wire sig00000185;
  wire sig00000186;
  wire sig00000187;
  wire sig00000188;
  wire sig00000189;
  wire sig0000018a;
  wire sig0000018b;
  wire sig0000018c;
  wire sig0000018d;
  wire sig0000018e;
  wire sig0000018f;
  wire sig00000190;
  wire sig00000191;
  wire sig00000192;
  wire sig00000193;
  wire sig00000194;
  wire sig00000195;
  wire sig00000196;
  wire sig00000197;
  wire sig00000198;
  wire sig00000199;
  wire sig0000019a;
  wire sig0000019b;
  wire sig0000019c;
  wire sig0000019d;
  wire sig0000019e;
  wire sig0000019f;
  wire sig000001a0;
  wire sig000001a1;
  wire sig000001a2;
  wire sig000001a3;
  wire sig000001a4;
  wire sig000001a5;
  wire sig000001a6;
  wire sig000001a7;
  wire sig000001a8;
  wire sig000001a9;
  wire sig000001aa;
  wire sig000001ab;
  wire sig000001ac;
  wire sig000001ad;
  wire sig000001ae;
  wire sig000001af;
  wire sig000001b0;
  wire sig000001b1;
  wire sig000001b2;
  wire sig000001b3;
  wire sig000001b4;
  wire sig000001b5;
  wire sig000001b6;
  wire sig000001b7;
  wire sig000001b8;
  wire sig000001b9;
  wire sig000001ba;
  wire sig000001bb;
  wire sig000001bc;
  wire sig000001bd;
  wire sig000001be;
  wire sig000001bf;
  wire sig000001c0;
  wire sig000001c1;
  wire sig000001c2;
  wire NLW_blk00000039_O_UNCONNECTED;
  wire NLW_blk000000a4_O_UNCONNECTED;
  wire NLW_blk000000f1_O_UNCONNECTED;
  wire NLW_blk000001ec_Q15_UNCONNECTED;
  wire [37 : 0] \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT ;
  assign
    result[37] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [37],
    result[36] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [36],
    result[35] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [35],
    result[34] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [34],
    result[33] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [33],
    result[32] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [32],
    result[31] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [31],
    result[30] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [30],
    result[29] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [29],
    result[28] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [28],
    result[27] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [27],
    result[26] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [26],
    result[25] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [25],
    result[24] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [24],
    result[23] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [23],
    result[22] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [22],
    result[21] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [21],
    result[20] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [20],
    result[19] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [19],
    result[18] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [18],
    result[17] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [17],
    result[16] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [16],
    result[15] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [15],
    result[14] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [14],
    result[13] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [13],
    result[12] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [12],
    result[11] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [11],
    result[10] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [10],
    result[9] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [9],
    result[8] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [8],
    result[7] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [7],
    result[6] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [6],
    result[5] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [5],
    result[4] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [4],
    result[3] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [3],
    result[2] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [2],
    result[1] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [1],
    result[0] = \U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [0],
    rdy = \U0/op_inst/FLT_PT_OP/HND_SHK/RDY ;
  VCC   blk00000001 (
    .P(sig00000001)
  );
  GND   blk00000002 (
    .G(sig00000002)
  );
  FDRE #(
    .INIT ( 1'b0 ))
  blk00000003 (
    .C(clk),
    .CE(ce),
    .D(sig00000003),
    .R(sig00000002),
    .Q(\U0/op_inst/FLT_PT_OP/HND_SHK/RDY )
  );
  MUXCY   blk00000004 (
    .CI(sig0000000c),
    .DI(sig00000002),
    .S(sig0000000b),
    .O(sig000000b7)
  );
  MUXCY   blk00000005 (
    .CI(sig00000001),
    .DI(sig00000002),
    .S(sig0000000a),
    .O(sig0000000c)
  );
  MUXCY   blk00000006 (
    .CI(sig00000001),
    .DI(sig00000002),
    .S(sig0000000e),
    .O(sig0000000d)
  );
  MUXCY   blk00000007 (
    .CI(sig0000000d),
    .DI(sig00000002),
    .S(sig0000000f),
    .O(sig000000b6)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000008 (
    .C(clk),
    .CE(ce),
    .D(a[31]),
    .Q(sig00000007)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000009 (
    .C(clk),
    .CE(ce),
    .D(sig00000007),
    .Q(sig00000066)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000000a (
    .C(clk),
    .CE(ce),
    .D(sig00000037),
    .Q(sig00000009)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000000b (
    .C(clk),
    .CE(ce),
    .D(sig00000038),
    .Q(sig00000008)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000000c (
    .C(clk),
    .CE(ce),
    .D(sig00000009),
    .Q(sig000000b5)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000000d (
    .C(clk),
    .CE(ce),
    .D(sig00000008),
    .Q(sig000000b4)
  );
  FDE   blk0000000e (
    .C(clk),
    .CE(ce),
    .D(sig00000010),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [37])
  );
  FDE   blk0000000f (
    .C(clk),
    .CE(ce),
    .D(sig00000036),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [36])
  );
  FDE   blk00000010 (
    .C(clk),
    .CE(ce),
    .D(sig00000035),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [35])
  );
  FDE   blk00000011 (
    .C(clk),
    .CE(ce),
    .D(sig00000034),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [34])
  );
  FDE   blk00000012 (
    .C(clk),
    .CE(ce),
    .D(sig00000033),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [33])
  );
  FDE   blk00000013 (
    .C(clk),
    .CE(ce),
    .D(sig00000032),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [32])
  );
  FDE   blk00000014 (
    .C(clk),
    .CE(ce),
    .D(sig00000031),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [31])
  );
  FDE   blk00000015 (
    .C(clk),
    .CE(ce),
    .D(sig00000030),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [30])
  );
  FDE   blk00000016 (
    .C(clk),
    .CE(ce),
    .D(sig0000002f),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [29])
  );
  FDE   blk00000017 (
    .C(clk),
    .CE(ce),
    .D(sig0000002e),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [28])
  );
  FDE   blk00000018 (
    .C(clk),
    .CE(ce),
    .D(sig0000002d),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [27])
  );
  FDE   blk00000019 (
    .C(clk),
    .CE(ce),
    .D(sig0000002c),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [26])
  );
  FDE   blk0000001a (
    .C(clk),
    .CE(ce),
    .D(sig0000002b),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [25])
  );
  FDE   blk0000001b (
    .C(clk),
    .CE(ce),
    .D(sig0000002a),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [24])
  );
  FDE   blk0000001c (
    .C(clk),
    .CE(ce),
    .D(sig00000029),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [23])
  );
  FDE   blk0000001d (
    .C(clk),
    .CE(ce),
    .D(sig00000028),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [22])
  );
  FDE   blk0000001e (
    .C(clk),
    .CE(ce),
    .D(sig00000027),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [21])
  );
  FDE   blk0000001f (
    .C(clk),
    .CE(ce),
    .D(sig00000026),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [20])
  );
  FDE   blk00000020 (
    .C(clk),
    .CE(ce),
    .D(sig00000025),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [19])
  );
  FDE   blk00000021 (
    .C(clk),
    .CE(ce),
    .D(sig00000024),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [18])
  );
  FDE   blk00000022 (
    .C(clk),
    .CE(ce),
    .D(sig00000023),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [17])
  );
  FDE   blk00000023 (
    .C(clk),
    .CE(ce),
    .D(sig00000022),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [16])
  );
  FDE   blk00000024 (
    .C(clk),
    .CE(ce),
    .D(sig00000021),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [15])
  );
  FDE   blk00000025 (
    .C(clk),
    .CE(ce),
    .D(sig00000020),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [14])
  );
  FDE   blk00000026 (
    .C(clk),
    .CE(ce),
    .D(sig0000001f),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [13])
  );
  FDE   blk00000027 (
    .C(clk),
    .CE(ce),
    .D(sig0000001e),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [12])
  );
  FDE   blk00000028 (
    .C(clk),
    .CE(ce),
    .D(sig0000001d),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [11])
  );
  FDE   blk00000029 (
    .C(clk),
    .CE(ce),
    .D(sig0000001c),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [10])
  );
  FDE   blk0000002a (
    .C(clk),
    .CE(ce),
    .D(sig0000001b),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [9])
  );
  FDE   blk0000002b (
    .C(clk),
    .CE(ce),
    .D(sig0000001a),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [8])
  );
  FDE   blk0000002c (
    .C(clk),
    .CE(ce),
    .D(sig00000019),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [7])
  );
  FDE   blk0000002d (
    .C(clk),
    .CE(ce),
    .D(sig00000018),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [6])
  );
  FDE   blk0000002e (
    .C(clk),
    .CE(ce),
    .D(sig00000017),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [5])
  );
  FDE   blk0000002f (
    .C(clk),
    .CE(ce),
    .D(sig00000016),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [4])
  );
  FDE   blk00000030 (
    .C(clk),
    .CE(ce),
    .D(sig00000015),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [3])
  );
  FDE   blk00000031 (
    .C(clk),
    .CE(ce),
    .D(sig00000014),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [2])
  );
  FDE   blk00000032 (
    .C(clk),
    .CE(ce),
    .D(sig00000013),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [1])
  );
  FDE   blk00000033 (
    .C(clk),
    .CE(ce),
    .D(sig00000012),
    .Q(\U0/op_inst/FLT_PT_OP/FLT_TO_FIX_OP.SPD.OP/RESULT [0])
  );
  MUXCY   blk00000034 (
    .CI(sig00000001),
    .DI(sig00000002),
    .S(sig000000c1),
    .O(sig000000b8)
  );
  MUXCY   blk00000035 (
    .CI(sig000000b8),
    .DI(sig00000002),
    .S(sig000000c0),
    .O(sig000000b9)
  );
  MUXCY   blk00000036 (
    .CI(sig000000b9),
    .DI(sig00000002),
    .S(sig000000bf),
    .O(sig000000ba)
  );
  MUXCY   blk00000037 (
    .CI(sig000000ba),
    .DI(sig00000002),
    .S(sig000000be),
    .O(sig000000bb)
  );
  MUXCY   blk00000038 (
    .CI(sig000000bb),
    .DI(sig00000002),
    .S(sig000000bd),
    .O(sig000000bc)
  );
  MUXCY   blk00000039 (
    .CI(sig000000bc),
    .DI(sig00000002),
    .S(sig000000c2),
    .O(NLW_blk00000039_O_UNCONNECTED)
  );
  MUXF8   blk0000003a (
    .I0(sig000000ca),
    .I1(sig000000c9),
    .S(sig00000002),
    .O(sig000000c8)
  );
  MUXF7   blk0000003b (
    .I0(sig00000001),
    .I1(sig00000001),
    .S(sig000000d1),
    .O(sig000000c9)
  );
  MUXF7   blk0000003c (
    .I0(sig000000d3),
    .I1(sig000000d2),
    .S(sig000000d1),
    .O(sig000000ca)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000003d (
    .C(clk),
    .CE(ce),
    .D(sig00000039),
    .Q(sig000000d4)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000003e (
    .C(clk),
    .CE(ce),
    .D(sig0000003a),
    .Q(sig000000d5)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000003f (
    .C(clk),
    .CE(ce),
    .D(sig0000003b),
    .Q(sig000000d1)
  );
  MUXCY   blk00000040 (
    .CI(sig000000e4),
    .DI(sig00000002),
    .S(sig00000002),
    .O(sig000000e3)
  );
  MUXCY   blk00000041 (
    .CI(sig000000e5),
    .DI(sig00000002),
    .S(sig000000c7),
    .O(sig000000e4)
  );
  MUXCY   blk00000042 (
    .CI(sig000000e6),
    .DI(sig00000002),
    .S(sig000000c6),
    .O(sig000000e5)
  );
  MUXCY   blk00000043 (
    .CI(sig000000e7),
    .DI(sig00000002),
    .S(sig000000c5),
    .O(sig000000e6)
  );
  MUXCY   blk00000044 (
    .CI(sig000000e8),
    .DI(sig00000002),
    .S(sig000000c4),
    .O(sig000000e7)
  );
  MUXCY   blk00000045 (
    .CI(sig00000001),
    .DI(sig00000002),
    .S(sig000000c3),
    .O(sig000000e8)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000046 (
    .C(clk),
    .CE(ce),
    .D(sig000000e3),
    .Q(sig000000de)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000047 (
    .C(clk),
    .CE(ce),
    .D(sig000000e4),
    .Q(sig000000df)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000048 (
    .C(clk),
    .CE(ce),
    .D(sig000000e5),
    .Q(sig000000dd)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000049 (
    .C(clk),
    .CE(ce),
    .D(sig000000e6),
    .Q(sig000000e0)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000004a (
    .C(clk),
    .CE(ce),
    .D(sig000000e7),
    .Q(sig000000e1)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000004b (
    .C(clk),
    .CE(ce),
    .D(sig000000e8),
    .Q(sig000000e2)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000004c (
    .C(clk),
    .CE(ce),
    .D(sig000000c8),
    .Q(sig000000b3)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000004d (
    .C(clk),
    .CE(ce),
    .D(sig00000001),
    .Q(sig000000d7)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000004e (
    .C(clk),
    .CE(ce),
    .D(sig000000cb),
    .Q(sig000000d8)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000004f (
    .C(clk),
    .CE(ce),
    .D(sig000000cc),
    .Q(sig000000d6)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000050 (
    .C(clk),
    .CE(ce),
    .D(sig000000cd),
    .Q(sig000000da)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000051 (
    .C(clk),
    .CE(ce),
    .D(sig000000ce),
    .Q(sig000000db)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000052 (
    .C(clk),
    .CE(ce),
    .D(sig000000cf),
    .Q(sig000000dc)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000053 (
    .C(clk),
    .CE(ce),
    .D(sig000000d0),
    .Q(sig000000d9)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000054 (
    .C(clk),
    .CE(ce),
    .D(sig0000003d),
    .Q(sig0000015a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000055 (
    .C(clk),
    .CE(ce),
    .D(sig0000003e),
    .Q(sig0000015b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000056 (
    .C(clk),
    .CE(ce),
    .D(a[23]),
    .Q(sig00000158)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000057 (
    .C(clk),
    .CE(ce),
    .D(sig0000003c),
    .Q(sig00000159)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000058 (
    .C(clk),
    .CE(ce),
    .D(sig00000131),
    .Q(sig000000b2)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000059 (
    .C(clk),
    .CE(ce),
    .D(sig00000130),
    .Q(sig000000b1)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005a (
    .C(clk),
    .CE(ce),
    .D(sig0000012f),
    .Q(sig000000b0)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005b (
    .C(clk),
    .CE(ce),
    .D(sig0000012e),
    .Q(sig000000af)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005c (
    .C(clk),
    .CE(ce),
    .D(sig0000012d),
    .Q(sig000000ae)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005d (
    .C(clk),
    .CE(ce),
    .D(sig0000012c),
    .Q(sig000000ad)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005e (
    .C(clk),
    .CE(ce),
    .D(sig0000012b),
    .Q(sig000000ac)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000005f (
    .C(clk),
    .CE(ce),
    .D(sig0000012a),
    .Q(sig000000ab)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000060 (
    .C(clk),
    .CE(ce),
    .D(sig00000129),
    .Q(sig000000aa)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000061 (
    .C(clk),
    .CE(ce),
    .D(sig00000128),
    .Q(sig000000a9)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000062 (
    .C(clk),
    .CE(ce),
    .D(sig00000127),
    .Q(sig000000a8)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000063 (
    .C(clk),
    .CE(ce),
    .D(sig00000126),
    .Q(sig000000a7)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000064 (
    .C(clk),
    .CE(ce),
    .D(sig00000125),
    .Q(sig000000a6)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000065 (
    .C(clk),
    .CE(ce),
    .D(sig00000124),
    .Q(sig000000a5)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000066 (
    .C(clk),
    .CE(ce),
    .D(sig00000123),
    .Q(sig000000a4)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000067 (
    .C(clk),
    .CE(ce),
    .D(sig00000122),
    .Q(sig000000a3)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000068 (
    .C(clk),
    .CE(ce),
    .D(sig00000121),
    .Q(sig000000a2)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000069 (
    .C(clk),
    .CE(ce),
    .D(sig00000120),
    .Q(sig000000a1)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006a (
    .C(clk),
    .CE(ce),
    .D(sig0000011f),
    .Q(sig000000a0)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006b (
    .C(clk),
    .CE(ce),
    .D(sig0000011e),
    .Q(sig0000009f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006c (
    .C(clk),
    .CE(ce),
    .D(sig0000011d),
    .Q(sig0000009e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006d (
    .C(clk),
    .CE(ce),
    .D(sig0000011c),
    .Q(sig0000009d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006e (
    .C(clk),
    .CE(ce),
    .D(sig0000011b),
    .Q(sig0000009c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000006f (
    .C(clk),
    .CE(ce),
    .D(sig0000011a),
    .Q(sig0000009b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000070 (
    .C(clk),
    .CE(ce),
    .D(sig00000119),
    .Q(sig0000009a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000071 (
    .C(clk),
    .CE(ce),
    .D(sig00000118),
    .Q(sig00000099)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000072 (
    .C(clk),
    .CE(ce),
    .D(sig00000117),
    .Q(sig00000098)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000073 (
    .C(clk),
    .CE(ce),
    .D(sig00000116),
    .Q(sig00000097)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000074 (
    .C(clk),
    .CE(ce),
    .D(sig00000115),
    .Q(sig00000096)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000075 (
    .C(clk),
    .CE(ce),
    .D(sig00000114),
    .Q(sig00000095)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000076 (
    .C(clk),
    .CE(ce),
    .D(sig00000113),
    .Q(sig00000094)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000077 (
    .C(clk),
    .CE(ce),
    .D(sig00000112),
    .Q(sig00000093)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000078 (
    .C(clk),
    .CE(ce),
    .D(sig00000111),
    .Q(sig00000092)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000079 (
    .C(clk),
    .CE(ce),
    .D(sig00000110),
    .Q(sig00000091)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000007a (
    .C(clk),
    .CE(ce),
    .D(sig0000010f),
    .Q(sig00000090)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000007b (
    .C(clk),
    .CE(ce),
    .D(sig0000010e),
    .Q(sig0000008f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000007c (
    .C(clk),
    .CE(ce),
    .D(sig0000010d),
    .Q(sig0000008e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000007d (
    .C(clk),
    .CE(ce),
    .D(sig0000010c),
    .Q(sig0000008d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000007e (
    .C(clk),
    .CE(ce),
    .D(sig00000157),
    .Q(sig00000181)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000007f (
    .C(clk),
    .CE(ce),
    .D(sig00000156),
    .Q(sig00000180)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000080 (
    .C(clk),
    .CE(ce),
    .D(sig00000155),
    .Q(sig0000017f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000081 (
    .C(clk),
    .CE(ce),
    .D(sig00000154),
    .Q(sig0000017e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000082 (
    .C(clk),
    .CE(ce),
    .D(sig00000153),
    .Q(sig0000017d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000083 (
    .C(clk),
    .CE(ce),
    .D(sig00000152),
    .Q(sig0000017c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000084 (
    .C(clk),
    .CE(ce),
    .D(sig00000151),
    .Q(sig0000017b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000085 (
    .C(clk),
    .CE(ce),
    .D(sig00000150),
    .Q(sig0000017a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000086 (
    .C(clk),
    .CE(ce),
    .D(sig0000014f),
    .Q(sig00000179)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000087 (
    .C(clk),
    .CE(ce),
    .D(sig0000014e),
    .Q(sig00000178)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000088 (
    .C(clk),
    .CE(ce),
    .D(sig0000014d),
    .Q(sig00000177)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000089 (
    .C(clk),
    .CE(ce),
    .D(sig0000014c),
    .Q(sig00000176)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000008a (
    .C(clk),
    .CE(ce),
    .D(sig0000014b),
    .Q(sig00000175)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000008b (
    .C(clk),
    .CE(ce),
    .D(sig0000014a),
    .Q(sig00000174)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000008c (
    .C(clk),
    .CE(ce),
    .D(sig00000149),
    .Q(sig00000173)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000008d (
    .C(clk),
    .CE(ce),
    .D(sig00000148),
    .Q(sig00000172)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000008e (
    .C(clk),
    .CE(ce),
    .D(sig00000147),
    .Q(sig00000171)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000008f (
    .C(clk),
    .CE(ce),
    .D(sig00000146),
    .Q(sig00000170)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000090 (
    .C(clk),
    .CE(ce),
    .D(sig00000145),
    .Q(sig0000016f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000091 (
    .C(clk),
    .CE(ce),
    .D(sig00000144),
    .Q(sig0000016e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000092 (
    .C(clk),
    .CE(ce),
    .D(sig00000143),
    .Q(sig0000016d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000093 (
    .C(clk),
    .CE(ce),
    .D(sig00000142),
    .Q(sig0000016c)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000094 (
    .C(clk),
    .CE(ce),
    .D(sig00000141),
    .Q(sig0000016b)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000095 (
    .C(clk),
    .CE(ce),
    .D(sig00000140),
    .Q(sig0000016a)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000096 (
    .C(clk),
    .CE(ce),
    .D(sig0000013f),
    .Q(sig00000169)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000097 (
    .C(clk),
    .CE(ce),
    .D(sig0000013e),
    .Q(sig00000168)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000098 (
    .C(clk),
    .CE(ce),
    .D(sig0000013d),
    .Q(sig00000167)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk00000099 (
    .C(clk),
    .CE(ce),
    .D(sig0000013c),
    .Q(sig00000166)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000009a (
    .C(clk),
    .CE(ce),
    .D(sig0000013b),
    .Q(sig00000165)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000009b (
    .C(clk),
    .CE(ce),
    .D(sig0000013a),
    .Q(sig00000164)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000009c (
    .C(clk),
    .CE(ce),
    .D(sig00000139),
    .Q(sig00000163)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000009d (
    .C(clk),
    .CE(ce),
    .D(sig00000138),
    .Q(sig00000162)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000009e (
    .C(clk),
    .CE(ce),
    .D(sig00000137),
    .Q(sig00000161)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk0000009f (
    .C(clk),
    .CE(ce),
    .D(sig00000136),
    .Q(sig00000160)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000a0 (
    .C(clk),
    .CE(ce),
    .D(sig00000135),
    .Q(sig0000015f)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000a1 (
    .C(clk),
    .CE(ce),
    .D(sig00000134),
    .Q(sig0000015e)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000a2 (
    .C(clk),
    .CE(ce),
    .D(sig00000133),
    .Q(sig0000015d)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000000a3 (
    .C(clk),
    .CE(ce),
    .D(sig00000132),
    .Q(sig0000015c)
  );
  XORCY   blk000000a4 (
    .CI(sig00000182),
    .LI(sig00000002),
    .O(NLW_blk000000a4_O_UNCONNECTED)
  );
  XORCY   blk000000a5 (
    .CI(sig00000183),
    .LI(sig000001b6),
    .O(sig0000008c)
  );
  MUXCY   blk000000a6 (
    .CI(sig00000183),
    .DI(sig00000002),
    .S(sig000001b6),
    .O(sig00000182)
  );
  XORCY   blk000000a7 (
    .CI(sig00000184),
    .LI(sig00000065),
    .O(sig0000008b)
  );
  MUXCY   blk000000a8 (
    .CI(sig00000184),
    .DI(sig00000002),
    .S(sig00000065),
    .O(sig00000183)
  );
  XORCY   blk000000a9 (
    .CI(sig00000185),
    .LI(sig00000064),
    .O(sig0000008a)
  );
  MUXCY   blk000000aa (
    .CI(sig00000185),
    .DI(sig00000002),
    .S(sig00000064),
    .O(sig00000184)
  );
  XORCY   blk000000ab (
    .CI(sig00000186),
    .LI(sig00000063),
    .O(sig00000089)
  );
  MUXCY   blk000000ac (
    .CI(sig00000186),
    .DI(sig00000002),
    .S(sig00000063),
    .O(sig00000185)
  );
  XORCY   blk000000ad (
    .CI(sig00000187),
    .LI(sig00000062),
    .O(sig00000088)
  );
  MUXCY   blk000000ae (
    .CI(sig00000187),
    .DI(sig00000002),
    .S(sig00000062),
    .O(sig00000186)
  );
  XORCY   blk000000af (
    .CI(sig00000188),
    .LI(sig00000061),
    .O(sig00000087)
  );
  MUXCY   blk000000b0 (
    .CI(sig00000188),
    .DI(sig00000002),
    .S(sig00000061),
    .O(sig00000187)
  );
  XORCY   blk000000b1 (
    .CI(sig00000189),
    .LI(sig00000060),
    .O(sig00000086)
  );
  MUXCY   blk000000b2 (
    .CI(sig00000189),
    .DI(sig00000002),
    .S(sig00000060),
    .O(sig00000188)
  );
  XORCY   blk000000b3 (
    .CI(sig0000018a),
    .LI(sig0000005f),
    .O(sig00000085)
  );
  MUXCY   blk000000b4 (
    .CI(sig0000018a),
    .DI(sig00000002),
    .S(sig0000005f),
    .O(sig00000189)
  );
  XORCY   blk000000b5 (
    .CI(sig0000018b),
    .LI(sig0000005e),
    .O(sig00000084)
  );
  MUXCY   blk000000b6 (
    .CI(sig0000018b),
    .DI(sig00000002),
    .S(sig0000005e),
    .O(sig0000018a)
  );
  XORCY   blk000000b7 (
    .CI(sig0000018c),
    .LI(sig0000005d),
    .O(sig00000083)
  );
  MUXCY   blk000000b8 (
    .CI(sig0000018c),
    .DI(sig00000002),
    .S(sig0000005d),
    .O(sig0000018b)
  );
  XORCY   blk000000b9 (
    .CI(sig0000018d),
    .LI(sig0000005c),
    .O(sig00000082)
  );
  MUXCY   blk000000ba (
    .CI(sig0000018d),
    .DI(sig00000002),
    .S(sig0000005c),
    .O(sig0000018c)
  );
  XORCY   blk000000bb (
    .CI(sig0000018e),
    .LI(sig0000005b),
    .O(sig00000081)
  );
  MUXCY   blk000000bc (
    .CI(sig0000018e),
    .DI(sig00000002),
    .S(sig0000005b),
    .O(sig0000018d)
  );
  XORCY   blk000000bd (
    .CI(sig0000018f),
    .LI(sig0000005a),
    .O(sig00000080)
  );
  MUXCY   blk000000be (
    .CI(sig0000018f),
    .DI(sig00000002),
    .S(sig0000005a),
    .O(sig0000018e)
  );
  XORCY   blk000000bf (
    .CI(sig00000190),
    .LI(sig00000059),
    .O(sig0000007f)
  );
  MUXCY   blk000000c0 (
    .CI(sig00000190),
    .DI(sig00000002),
    .S(sig00000059),
    .O(sig0000018f)
  );
  XORCY   blk000000c1 (
    .CI(sig00000191),
    .LI(sig00000058),
    .O(sig0000007e)
  );
  MUXCY   blk000000c2 (
    .CI(sig00000191),
    .DI(sig00000002),
    .S(sig00000058),
    .O(sig00000190)
  );
  XORCY   blk000000c3 (
    .CI(sig00000192),
    .LI(sig00000057),
    .O(sig0000007d)
  );
  MUXCY   blk000000c4 (
    .CI(sig00000192),
    .DI(sig00000002),
    .S(sig00000057),
    .O(sig00000191)
  );
  XORCY   blk000000c5 (
    .CI(sig00000193),
    .LI(sig00000056),
    .O(sig0000007c)
  );
  MUXCY   blk000000c6 (
    .CI(sig00000193),
    .DI(sig00000002),
    .S(sig00000056),
    .O(sig00000192)
  );
  XORCY   blk000000c7 (
    .CI(sig00000194),
    .LI(sig00000055),
    .O(sig0000007b)
  );
  MUXCY   blk000000c8 (
    .CI(sig00000194),
    .DI(sig00000002),
    .S(sig00000055),
    .O(sig00000193)
  );
  XORCY   blk000000c9 (
    .CI(sig00000195),
    .LI(sig00000054),
    .O(sig0000007a)
  );
  MUXCY   blk000000ca (
    .CI(sig00000195),
    .DI(sig00000002),
    .S(sig00000054),
    .O(sig00000194)
  );
  XORCY   blk000000cb (
    .CI(sig00000196),
    .LI(sig00000053),
    .O(sig00000079)
  );
  MUXCY   blk000000cc (
    .CI(sig00000196),
    .DI(sig00000002),
    .S(sig00000053),
    .O(sig00000195)
  );
  XORCY   blk000000cd (
    .CI(sig00000197),
    .LI(sig00000052),
    .O(sig00000078)
  );
  MUXCY   blk000000ce (
    .CI(sig00000197),
    .DI(sig00000002),
    .S(sig00000052),
    .O(sig00000196)
  );
  XORCY   blk000000cf (
    .CI(sig00000198),
    .LI(sig00000051),
    .O(sig00000077)
  );
  MUXCY   blk000000d0 (
    .CI(sig00000198),
    .DI(sig00000002),
    .S(sig00000051),
    .O(sig00000197)
  );
  XORCY   blk000000d1 (
    .CI(sig00000199),
    .LI(sig00000050),
    .O(sig00000076)
  );
  MUXCY   blk000000d2 (
    .CI(sig00000199),
    .DI(sig00000002),
    .S(sig00000050),
    .O(sig00000198)
  );
  XORCY   blk000000d3 (
    .CI(sig0000019a),
    .LI(sig0000004f),
    .O(sig00000075)
  );
  MUXCY   blk000000d4 (
    .CI(sig0000019a),
    .DI(sig00000002),
    .S(sig0000004f),
    .O(sig00000199)
  );
  XORCY   blk000000d5 (
    .CI(sig0000019b),
    .LI(sig0000004e),
    .O(sig00000074)
  );
  MUXCY   blk000000d6 (
    .CI(sig0000019b),
    .DI(sig00000002),
    .S(sig0000004e),
    .O(sig0000019a)
  );
  XORCY   blk000000d7 (
    .CI(sig0000019c),
    .LI(sig0000004d),
    .O(sig00000073)
  );
  MUXCY   blk000000d8 (
    .CI(sig0000019c),
    .DI(sig00000002),
    .S(sig0000004d),
    .O(sig0000019b)
  );
  XORCY   blk000000d9 (
    .CI(sig0000019d),
    .LI(sig0000004c),
    .O(sig00000072)
  );
  MUXCY   blk000000da (
    .CI(sig0000019d),
    .DI(sig00000002),
    .S(sig0000004c),
    .O(sig0000019c)
  );
  XORCY   blk000000db (
    .CI(sig0000019e),
    .LI(sig0000004b),
    .O(sig00000071)
  );
  MUXCY   blk000000dc (
    .CI(sig0000019e),
    .DI(sig00000002),
    .S(sig0000004b),
    .O(sig0000019d)
  );
  XORCY   blk000000dd (
    .CI(sig0000019f),
    .LI(sig0000004a),
    .O(sig00000070)
  );
  MUXCY   blk000000de (
    .CI(sig0000019f),
    .DI(sig00000002),
    .S(sig0000004a),
    .O(sig0000019e)
  );
  XORCY   blk000000df (
    .CI(sig000001a0),
    .LI(sig00000049),
    .O(sig0000006f)
  );
  MUXCY   blk000000e0 (
    .CI(sig000001a0),
    .DI(sig00000002),
    .S(sig00000049),
    .O(sig0000019f)
  );
  XORCY   blk000000e1 (
    .CI(sig000001a1),
    .LI(sig00000048),
    .O(sig0000006e)
  );
  MUXCY   blk000000e2 (
    .CI(sig000001a1),
    .DI(sig00000002),
    .S(sig00000048),
    .O(sig000001a0)
  );
  XORCY   blk000000e3 (
    .CI(sig000001a2),
    .LI(sig00000047),
    .O(sig0000006d)
  );
  MUXCY   blk000000e4 (
    .CI(sig000001a2),
    .DI(sig00000002),
    .S(sig00000047),
    .O(sig000001a1)
  );
  XORCY   blk000000e5 (
    .CI(sig000001a3),
    .LI(sig00000046),
    .O(sig0000006c)
  );
  MUXCY   blk000000e6 (
    .CI(sig000001a3),
    .DI(sig00000002),
    .S(sig00000046),
    .O(sig000001a2)
  );
  XORCY   blk000000e7 (
    .CI(sig000001a4),
    .LI(sig00000045),
    .O(sig0000006b)
  );
  MUXCY   blk000000e8 (
    .CI(sig000001a4),
    .DI(sig00000002),
    .S(sig00000045),
    .O(sig000001a3)
  );
  XORCY   blk000000e9 (
    .CI(sig000001a5),
    .LI(sig00000044),
    .O(sig0000006a)
  );
  MUXCY   blk000000ea (
    .CI(sig000001a5),
    .DI(sig00000002),
    .S(sig00000044),
    .O(sig000001a4)
  );
  XORCY   blk000000eb (
    .CI(sig000001a6),
    .LI(sig00000043),
    .O(sig00000069)
  );
  MUXCY   blk000000ec (
    .CI(sig000001a6),
    .DI(sig00000002),
    .S(sig00000043),
    .O(sig000001a5)
  );
  XORCY   blk000000ed (
    .CI(sig000001a7),
    .LI(sig00000042),
    .O(sig00000068)
  );
  MUXCY   blk000000ee (
    .CI(sig000001a7),
    .DI(sig00000002),
    .S(sig00000042),
    .O(sig000001a6)
  );
  XORCY   blk000000ef (
    .CI(sig000001a8),
    .LI(sig00000041),
    .O(sig00000067)
  );
  MUXCY   blk000000f0 (
    .CI(sig000001a8),
    .DI(sig00000002),
    .S(sig00000041),
    .O(sig000001a7)
  );
  XORCY   blk000000f1 (
    .CI(sig00000001),
    .LI(sig00000011),
    .O(NLW_blk000000f1_O_UNCONNECTED)
  );
  MUXCY   blk000000f2 (
    .CI(sig00000001),
    .DI(sig00000002),
    .S(sig00000011),
    .O(sig000001a8)
  );
  LUT6 #(
    .INIT ( 64'h66666666666C6C6C ))
  blk000000f3 (
    .I0(a[27]),
    .I1(a[28]),
    .I2(a[25]),
    .I3(a[23]),
    .I4(a[24]),
    .I5(a[26]),
    .O(sig00000040)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk000000f4 (
    .I0(a[26]),
    .I1(a[25]),
    .I2(a[23]),
    .I3(a[24]),
    .O(sig0000000e)
  );
  LUT4 #(
    .INIT ( 16'h0111 ))
  blk000000f5 (
    .I0(a[25]),
    .I1(a[26]),
    .I2(a[23]),
    .I3(a[24]),
    .O(sig00000006)
  );
  LUT4 #(
    .INIT ( 16'h3666 ))
  blk000000f6 (
    .I0(a[25]),
    .I1(a[26]),
    .I2(a[23]),
    .I3(a[24]),
    .O(sig0000003e)
  );
  LUT3 #(
    .INIT ( 8'h6A ))
  blk000000f7 (
    .I0(a[25]),
    .I1(a[23]),
    .I2(a[24]),
    .O(sig0000003d)
  );
  LUT4 #(
    .INIT ( 16'h666C ))
  blk000000f8 (
    .I0(a[25]),
    .I1(a[26]),
    .I2(a[23]),
    .I3(a[24]),
    .O(sig0000003a)
  );
  LUT3 #(
    .INIT ( 8'hA9 ))
  blk000000f9 (
    .I0(a[25]),
    .I1(a[23]),
    .I2(a[24]),
    .O(sig00000039)
  );
  LUT5 #(
    .INIT ( 32'h5555666A ))
  blk000000fa (
    .I0(a[27]),
    .I1(a[25]),
    .I2(a[23]),
    .I3(a[24]),
    .I4(a[26]),
    .O(sig0000003b)
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  blk000000fb (
    .I0(a[23]),
    .I1(a[24]),
    .O(sig0000003c)
  );
  LUT4 #(
    .INIT ( 16'h3BC4 ))
  blk000000fc (
    .I0(sig000000b3),
    .I1(sig0000008d),
    .I2(sig0000008e),
    .I3(sig000001b9),
    .O(sig00000011)
  );
  LUT4 #(
    .INIT ( 16'h9888 ))
  blk000000fd (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig0000008c),
    .O(sig00000010)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk000000fe (
    .I0(sig0000008e),
    .I1(sig000001b9),
    .O(sig00000041)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk000000ff (
    .I0(sig00000098),
    .I1(sig000001ba),
    .O(sig0000004b)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000100 (
    .I0(sig00000099),
    .I1(sig000001ba),
    .O(sig0000004c)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000101 (
    .I0(sig0000009a),
    .I1(sig000001ba),
    .O(sig0000004d)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000102 (
    .I0(sig0000009b),
    .I1(sig000001ba),
    .O(sig0000004e)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000103 (
    .I0(sig0000009c),
    .I1(sig000001ba),
    .O(sig0000004f)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000104 (
    .I0(sig0000009d),
    .I1(sig000001bb),
    .O(sig00000050)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000105 (
    .I0(sig0000009e),
    .I1(sig000001bb),
    .O(sig00000051)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000106 (
    .I0(sig0000009f),
    .I1(sig000001bb),
    .O(sig00000052)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000107 (
    .I0(sig000000a0),
    .I1(sig000001bb),
    .O(sig00000053)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000108 (
    .I0(sig000000a1),
    .I1(sig000001bb),
    .O(sig00000054)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000109 (
    .I0(sig0000008f),
    .I1(sig000001ba),
    .O(sig00000042)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000010a (
    .I0(sig000000a2),
    .I1(sig000001bb),
    .O(sig00000055)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000010b (
    .I0(sig000000a3),
    .I1(sig000001bb),
    .O(sig00000056)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000010c (
    .I0(sig000000a4),
    .I1(sig000001bb),
    .O(sig00000057)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000010d (
    .I0(sig000000a5),
    .I1(sig000001bb),
    .O(sig00000058)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000010e (
    .I0(sig000000a6),
    .I1(sig000001bb),
    .O(sig00000059)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000010f (
    .I0(sig000000a7),
    .I1(sig000001bb),
    .O(sig0000005a)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000110 (
    .I0(sig000000a8),
    .I1(sig000001bb),
    .O(sig0000005b)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000111 (
    .I0(sig000000a9),
    .I1(sig000001bb),
    .O(sig0000005c)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000112 (
    .I0(sig000000aa),
    .I1(sig000001bc),
    .O(sig0000005d)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000113 (
    .I0(sig000000ab),
    .I1(sig000001bc),
    .O(sig0000005e)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000114 (
    .I0(sig00000090),
    .I1(sig000001ba),
    .O(sig00000043)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000115 (
    .I0(sig000000ac),
    .I1(sig000001bc),
    .O(sig0000005f)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000116 (
    .I0(sig000000ad),
    .I1(sig000001bc),
    .O(sig00000060)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000117 (
    .I0(sig000000ae),
    .I1(sig000001bc),
    .O(sig00000061)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000118 (
    .I0(sig000000af),
    .I1(sig000001bc),
    .O(sig00000062)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000119 (
    .I0(sig000000b0),
    .I1(sig000001bc),
    .O(sig00000063)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000011a (
    .I0(sig000000b1),
    .I1(sig000001bc),
    .O(sig00000064)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000011b (
    .I0(sig000000b2),
    .I1(sig000001bc),
    .O(sig00000065)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000011c (
    .I0(sig00000091),
    .I1(sig000001ba),
    .O(sig00000044)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000011d (
    .I0(sig00000092),
    .I1(sig000001ba),
    .O(sig00000045)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000011e (
    .I0(sig00000093),
    .I1(sig000001ba),
    .O(sig00000046)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk0000011f (
    .I0(sig00000094),
    .I1(sig000001ba),
    .O(sig00000047)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000120 (
    .I0(sig00000095),
    .I1(sig000001ba),
    .O(sig00000048)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000121 (
    .I0(sig00000096),
    .I1(sig000001ba),
    .O(sig00000049)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  blk00000122 (
    .I0(sig00000097),
    .I1(sig000001ba),
    .O(sig0000004a)
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  blk00000123 (
    .I0(a[23]),
    .I1(a[24]),
    .I2(a[25]),
    .I3(a[26]),
    .O(sig0000000a)
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  blk00000124 (
    .I0(a[27]),
    .I1(a[28]),
    .I2(a[29]),
    .I3(a[30]),
    .O(sig0000000b)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk00000125 (
    .I0(a[27]),
    .I1(a[28]),
    .I2(a[29]),
    .I3(a[30]),
    .O(sig0000000f)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk00000126 (
    .I0(a[16]),
    .I1(a[17]),
    .I2(a[18]),
    .I3(a[19]),
    .O(sig000000bd)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk00000127 (
    .I0(a[12]),
    .I1(a[13]),
    .I2(a[14]),
    .I3(a[15]),
    .O(sig000000be)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk00000128 (
    .I0(a[8]),
    .I1(a[9]),
    .I2(a[10]),
    .I3(a[11]),
    .O(sig000000bf)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk00000129 (
    .I0(a[4]),
    .I1(a[5]),
    .I2(a[6]),
    .I3(a[7]),
    .O(sig000000c0)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000012a (
    .I0(a[0]),
    .I1(a[1]),
    .I2(a[2]),
    .I3(a[3]),
    .O(sig000000c1)
  );
  LUT3 #(
    .INIT ( 8'h01 ))
  blk0000012b (
    .I0(a[20]),
    .I1(a[21]),
    .I2(a[22]),
    .O(sig000000c2)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000012c (
    .I0(a[0]),
    .I1(a[1]),
    .I2(a[2]),
    .I3(a[3]),
    .O(sig000000c3)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000012d (
    .I0(a[4]),
    .I1(a[5]),
    .I2(a[6]),
    .I3(a[7]),
    .O(sig000000c4)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000012e (
    .I0(a[8]),
    .I1(a[9]),
    .I2(a[10]),
    .I3(a[11]),
    .O(sig000000c5)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk0000012f (
    .I0(a[12]),
    .I1(a[13]),
    .I2(a[14]),
    .I3(a[15]),
    .O(sig000000c6)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  blk00000130 (
    .I0(a[16]),
    .I1(a[17]),
    .I2(a[18]),
    .I3(a[19]),
    .O(sig000000c7)
  );
  LUT6 #(
    .INIT ( 64'h0101010000010000 ))
  blk00000131 (
    .I0(sig0000015a),
    .I1(sig0000015b),
    .I2(sig00000159),
    .I3(sig00000158),
    .I4(sig00000180),
    .I5(sig00000181),
    .O(sig00000130)
  );
  LUT5 #(
    .INIT ( 32'h00000010 ))
  blk00000132 (
    .I0(sig00000159),
    .I1(sig00000158),
    .I2(sig00000181),
    .I3(sig0000015b),
    .I4(sig0000015a),
    .O(sig00000131)
  );
  LUT5 #(
    .INIT ( 32'hFF330F55 ))
  blk00000133 (
    .I0(sig00000178),
    .I1(sig0000017c),
    .I2(sig00000180),
    .I3(sig0000015b),
    .I4(sig0000015a),
    .O(sig000000f8)
  );
  LUT6 #(
    .INIT ( 64'hFF00CCCCF0F0AAAA ))
  blk00000134 (
    .I0(sig00000174),
    .I1(sig00000178),
    .I2(sig0000017c),
    .I3(sig00000180),
    .I4(sig0000015b),
    .I5(sig0000015a),
    .O(sig000000f1)
  );
  LUT6 #(
    .INIT ( 64'hFF03FF05FFF3FFF5 ))
  blk00000135 (
    .I0(sig0000017c),
    .I1(sig00000180),
    .I2(sig00000158),
    .I3(sig0000015b),
    .I4(sig0000015a),
    .I5(sig000000f3),
    .O(sig000000fc)
  );
  LUT6 #(
    .INIT ( 64'hFF00CCCCF0F0AAAA ))
  blk00000136 (
    .I0(sig00000173),
    .I1(sig00000177),
    .I2(sig0000017b),
    .I3(sig0000017f),
    .I4(sig0000015b),
    .I5(sig0000015a),
    .O(sig000000f0)
  );
  LUT6 #(
    .INIT ( 64'h0200022257555777 ))
  blk00000137 (
    .I0(sig00000159),
    .I1(sig0000015b),
    .I2(sig000000f7),
    .I3(sig00000158),
    .I4(sig000000f5),
    .I5(sig000000fc),
    .O(sig0000012c)
  );
  LUT6 #(
    .INIT ( 64'h0020222055757775 ))
  blk00000138 (
    .I0(sig00000159),
    .I1(sig0000015b),
    .I2(sig000000f3),
    .I3(sig00000158),
    .I4(sig000000f5),
    .I5(sig000000fb),
    .O(sig0000012b)
  );
  LUT6 #(
    .INIT ( 64'h01015101ABABFBAB ))
  blk00000139 (
    .I0(sig00000159),
    .I1(sig000000f9),
    .I2(sig00000158),
    .I3(sig000000ef),
    .I4(sig0000015b),
    .I5(sig000000fb),
    .O(sig00000129)
  );
  LUT6 #(
    .INIT ( 64'h08194C5D2A3B6E7F ))
  blk0000013a (
    .I0(sig00000159),
    .I1(sig00000158),
    .I2(sig000000f9),
    .I3(sig000000f4),
    .I4(sig000000f6),
    .I5(sig000000f8),
    .O(sig00000126)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk0000013b (
    .I0(sig00000158),
    .I1(sig00000159),
    .I2(sig000000fd),
    .I3(sig000000ff),
    .I4(sig000000fe),
    .I5(sig000000fa),
    .O(sig0000010e)
  );
  LUT6 #(
    .INIT ( 64'h7F5D6E4C3B192A08 ))
  blk0000013c (
    .I0(sig00000158),
    .I1(sig00000159),
    .I2(sig000000f4),
    .I3(sig000000f1),
    .I4(sig000000f0),
    .I5(sig000000f2),
    .O(sig00000123)
  );
  LUT6 #(
    .INIT ( 64'h139B028A57DF46CE ))
  blk0000013d (
    .I0(sig00000159),
    .I1(sig00000158),
    .I2(sig000000f6),
    .I3(sig000000f8),
    .I4(sig000000f2),
    .I5(sig000000f4),
    .O(sig00000125)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk0000013e (
    .I0(sig00000158),
    .I1(sig00000159),
    .I2(sig000000f0),
    .I3(sig000000f2),
    .I4(sig000000f1),
    .I5(sig000000ee),
    .O(sig00000122)
  );
  LUT6 #(
    .INIT ( 64'h3B192A087F5D6E4C ))
  blk0000013f (
    .I0(sig00000158),
    .I1(sig00000159),
    .I2(sig000000f6),
    .I3(sig000000f2),
    .I4(sig000000f1),
    .I5(sig000000f4),
    .O(sig00000124)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000140 (
    .I0(sig00000158),
    .I1(sig00000159),
    .I2(sig000000ee),
    .I3(sig000000f1),
    .I4(sig000000f0),
    .I5(sig000000ed),
    .O(sig00000121)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000141 (
    .I0(sig00000158),
    .I1(sig00000159),
    .I2(sig000000ed),
    .I3(sig000000f0),
    .I4(sig000000ee),
    .I5(sig000000ec),
    .O(sig00000120)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000142 (
    .I0(sig00000158),
    .I1(sig00000159),
    .I2(sig000000ec),
    .I3(sig000000ee),
    .I4(sig000000ed),
    .I5(sig000000eb),
    .O(sig0000011f)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000143 (
    .I0(sig00000158),
    .I1(sig00000159),
    .I2(sig000000eb),
    .I3(sig000000ed),
    .I4(sig000000ec),
    .I5(sig000000ea),
    .O(sig0000011e)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000144 (
    .I0(sig00000158),
    .I1(sig00000159),
    .I2(sig00000108),
    .I3(sig0000010b),
    .I4(sig0000010a),
    .I5(sig00000107),
    .O(sig00000119)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000145 (
    .I0(sig00000158),
    .I1(sig00000159),
    .I2(sig0000010b),
    .I3(sig000000ea),
    .I4(sig000000e9),
    .I5(sig0000010a),
    .O(sig0000011b)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000146 (
    .I0(sig00000158),
    .I1(sig00000159),
    .I2(sig00000107),
    .I3(sig0000010a),
    .I4(sig00000108),
    .I5(sig00000106),
    .O(sig00000118)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000147 (
    .I0(sig00000158),
    .I1(sig00000159),
    .I2(sig0000010a),
    .I3(sig000000e9),
    .I4(sig0000010b),
    .I5(sig00000108),
    .O(sig0000011a)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000148 (
    .I0(sig00000158),
    .I1(sig00000159),
    .I2(sig00000106),
    .I3(sig00000108),
    .I4(sig00000107),
    .I5(sig00000105),
    .O(sig00000117)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000149 (
    .I0(sig00000158),
    .I1(sig00000159),
    .I2(sig00000105),
    .I3(sig00000107),
    .I4(sig00000106),
    .I5(sig00000104),
    .O(sig00000116)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk0000014a (
    .I0(sig00000158),
    .I1(sig00000159),
    .I2(sig00000104),
    .I3(sig00000106),
    .I4(sig00000105),
    .I5(sig00000103),
    .O(sig00000115)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk0000014b (
    .I0(sig00000158),
    .I1(sig00000159),
    .I2(sig00000103),
    .I3(sig00000105),
    .I4(sig00000104),
    .I5(sig00000102),
    .O(sig00000114)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk0000014c (
    .I0(sig00000158),
    .I1(sig00000159),
    .I2(sig000000ea),
    .I3(sig000000ec),
    .I4(sig000000eb),
    .I5(sig000000e9),
    .O(sig0000011d)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk0000014d (
    .I0(sig00000158),
    .I1(sig00000159),
    .I2(sig00000102),
    .I3(sig00000104),
    .I4(sig00000103),
    .I5(sig00000101),
    .O(sig00000113)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk0000014e (
    .I0(sig00000158),
    .I1(sig00000159),
    .I2(sig00000101),
    .I3(sig00000103),
    .I4(sig00000102),
    .I5(sig00000100),
    .O(sig00000112)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk0000014f (
    .I0(sig00000158),
    .I1(sig00000159),
    .I2(sig00000100),
    .I3(sig00000102),
    .I4(sig00000101),
    .I5(sig000000ff),
    .O(sig00000111)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000150 (
    .I0(sig00000158),
    .I1(sig00000159),
    .I2(sig000000ff),
    .I3(sig00000101),
    .I4(sig00000100),
    .I5(sig000000fe),
    .O(sig00000110)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000151 (
    .I0(sig00000158),
    .I1(sig00000159),
    .I2(sig000000fe),
    .I3(sig00000100),
    .I4(sig000000ff),
    .I5(sig000000fd),
    .O(sig0000010f)
  );
  LUT6 #(
    .INIT ( 64'hFEBADC9876325410 ))
  blk00000152 (
    .I0(sig00000159),
    .I1(sig00000158),
    .I2(sig00000109),
    .I3(sig000000fa),
    .I4(sig000000fd),
    .I5(sig000000fe),
    .O(sig0000010d)
  );
  LUT6 #(
    .INIT ( 64'hFD75B931EC64A820 ))
  blk00000153 (
    .I0(sig00000158),
    .I1(sig00000159),
    .I2(sig000000e9),
    .I3(sig000000eb),
    .I4(sig000000ea),
    .I5(sig0000010b),
    .O(sig0000011c)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk00000154 (
    .I0(sig00000169),
    .I1(sig00000171),
    .I2(sig00000175),
    .I3(sig0000016d),
    .I4(sig0000015b),
    .I5(sig0000015a),
    .O(sig00000107)
  );
  LUT6 #(
    .INIT ( 64'hFF00CCCCF0F0AAAA ))
  blk00000155 (
    .I0(sig00000161),
    .I1(sig00000165),
    .I2(sig00000169),
    .I3(sig0000016d),
    .I4(sig0000015b),
    .I5(sig0000015a),
    .O(sig000000ff)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk00000156 (
    .I0(sig00000168),
    .I1(sig00000170),
    .I2(sig00000174),
    .I3(sig0000016c),
    .I4(sig0000015b),
    .I5(sig0000015a),
    .O(sig00000106)
  );
  LUT6 #(
    .INIT ( 64'hFF00CCCCF0F0AAAA ))
  blk00000157 (
    .I0(sig00000160),
    .I1(sig00000164),
    .I2(sig00000168),
    .I3(sig0000016c),
    .I4(sig0000015b),
    .I5(sig0000015a),
    .O(sig000000fe)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk00000158 (
    .I0(sig00000167),
    .I1(sig0000016f),
    .I2(sig00000173),
    .I3(sig0000016b),
    .I4(sig0000015b),
    .I5(sig0000015a),
    .O(sig00000105)
  );
  LUT6 #(
    .INIT ( 64'hFF00CCCCF0F0AAAA ))
  blk00000159 (
    .I0(sig0000015f),
    .I1(sig00000163),
    .I2(sig00000167),
    .I3(sig0000016b),
    .I4(sig0000015b),
    .I5(sig0000015a),
    .O(sig000000fd)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk0000015a (
    .I0(sig00000166),
    .I1(sig0000016e),
    .I2(sig00000172),
    .I3(sig0000016a),
    .I4(sig0000015b),
    .I5(sig0000015a),
    .O(sig00000104)
  );
  LUT6 #(
    .INIT ( 64'hFF00CCCCF0F0AAAA ))
  blk0000015b (
    .I0(sig0000015e),
    .I1(sig00000162),
    .I2(sig00000166),
    .I3(sig0000016a),
    .I4(sig0000015b),
    .I5(sig0000015a),
    .O(sig000000fa)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk0000015c (
    .I0(sig00000165),
    .I1(sig0000016d),
    .I2(sig00000171),
    .I3(sig00000169),
    .I4(sig0000015b),
    .I5(sig0000015a),
    .O(sig00000103)
  );
  LUT6 #(
    .INIT ( 64'hFF00CCCCF0F0AAAA ))
  blk0000015d (
    .I0(sig0000015d),
    .I1(sig00000161),
    .I2(sig00000165),
    .I3(sig00000169),
    .I4(sig0000015b),
    .I5(sig0000015a),
    .O(sig00000109)
  );
  LUT6 #(
    .INIT ( 64'hFF00F0F0CCCCAAAA ))
  blk0000015e (
    .I0(sig00000171),
    .I1(sig00000179),
    .I2(sig00000175),
    .I3(sig0000017d),
    .I4(sig0000015b),
    .I5(sig0000015a),
    .O(sig000000ed)
  );
  LUT5 #(
    .INIT ( 32'hFF330F55 ))
  blk0000015f (
    .I0(sig00000179),
    .I1(sig0000017d),
    .I2(sig00000181),
    .I3(sig0000015b),
    .I4(sig0000015a),
    .O(sig000000f9)
  );
  LUT6 #(
    .INIT ( 64'hFF00F0F0CCCCAAAA ))
  blk00000160 (
    .I0(sig00000170),
    .I1(sig00000178),
    .I2(sig00000174),
    .I3(sig0000017c),
    .I4(sig0000015b),
    .I5(sig0000015a),
    .O(sig000000ec)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk00000161 (
    .I0(sig0000016c),
    .I1(sig00000174),
    .I2(sig00000178),
    .I3(sig00000170),
    .I4(sig0000015b),
    .I5(sig0000015a),
    .O(sig0000010b)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk00000162 (
    .I0(sig0000016b),
    .I1(sig00000173),
    .I2(sig00000177),
    .I3(sig0000016f),
    .I4(sig0000015b),
    .I5(sig0000015a),
    .O(sig0000010a)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk00000163 (
    .I0(sig0000016a),
    .I1(sig00000172),
    .I2(sig00000176),
    .I3(sig0000016e),
    .I4(sig0000015b),
    .I5(sig0000015a),
    .O(sig00000108)
  );
  LUT6 #(
    .INIT ( 64'hFF00F0F0CCCCAAAA ))
  blk00000164 (
    .I0(sig0000016f),
    .I1(sig00000177),
    .I2(sig00000173),
    .I3(sig0000017b),
    .I4(sig0000015b),
    .I5(sig0000015a),
    .O(sig000000eb)
  );
  LUT6 #(
    .INIT ( 64'hFF00F0F0CCCCAAAA ))
  blk00000165 (
    .I0(sig0000016e),
    .I1(sig00000176),
    .I2(sig00000172),
    .I3(sig0000017a),
    .I4(sig0000015b),
    .I5(sig0000015a),
    .O(sig000000ea)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk00000166 (
    .I0(sig0000016d),
    .I1(sig00000175),
    .I2(sig00000179),
    .I3(sig00000171),
    .I4(sig0000015b),
    .I5(sig0000015a),
    .O(sig000000e9)
  );
  LUT6 #(
    .INIT ( 64'hF0F0FF00CCCCAAAA ))
  blk00000167 (
    .I0(sig00000164),
    .I1(sig0000016c),
    .I2(sig00000170),
    .I3(sig00000168),
    .I4(sig0000015b),
    .I5(sig0000015a),
    .O(sig00000102)
  );
  LUT6 #(
    .INIT ( 64'hFF00CCCCF0F0AAAA ))
  blk00000168 (
    .I0(sig00000163),
    .I1(sig00000167),
    .I2(sig0000016b),
    .I3(sig0000016f),
    .I4(sig0000015b),
    .I5(sig0000015a),
    .O(sig00000101)
  );
  LUT6 #(
    .INIT ( 64'hFF00CCCCF0F0AAAA ))
  blk00000169 (
    .I0(sig00000162),
    .I1(sig00000166),
    .I2(sig0000016a),
    .I3(sig0000016e),
    .I4(sig0000015b),
    .I5(sig0000015a),
    .O(sig00000100)
  );
  LUT3 #(
    .INIT ( 8'h54 ))
  blk0000016a (
    .I0(sig00000040),
    .I1(a[7]),
    .I2(sig0000003f),
    .O(sig00000147)
  );
  LUT4 #(
    .INIT ( 16'h5140 ))
  blk0000016b (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[16]),
    .I3(a[0]),
    .O(sig00000140)
  );
  LUT4 #(
    .INIT ( 16'h5140 ))
  blk0000016c (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[17]),
    .I3(a[1]),
    .O(sig00000141)
  );
  LUT4 #(
    .INIT ( 16'h5140 ))
  blk0000016d (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[18]),
    .I3(a[2]),
    .O(sig00000142)
  );
  LUT4 #(
    .INIT ( 16'h5140 ))
  blk0000016e (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[19]),
    .I3(a[3]),
    .O(sig00000143)
  );
  LUT4 #(
    .INIT ( 16'h5140 ))
  blk0000016f (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[20]),
    .I3(a[4]),
    .O(sig00000144)
  );
  LUT4 #(
    .INIT ( 16'h5140 ))
  blk00000170 (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[21]),
    .I3(a[5]),
    .O(sig00000145)
  );
  LUT4 #(
    .INIT ( 16'h5140 ))
  blk00000171 (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[22]),
    .I3(a[6]),
    .O(sig00000146)
  );
  LUT4 #(
    .INIT ( 16'h6240 ))
  blk00000172 (
    .I0(sig0000003f),
    .I1(sig00000040),
    .I2(a[18]),
    .I3(a[2]),
    .O(sig00000132)
  );
  LUT4 #(
    .INIT ( 16'h6240 ))
  blk00000173 (
    .I0(sig0000003f),
    .I1(sig00000040),
    .I2(a[19]),
    .I3(a[3]),
    .O(sig00000133)
  );
  LUT4 #(
    .INIT ( 16'h6240 ))
  blk00000174 (
    .I0(sig0000003f),
    .I1(sig00000040),
    .I2(a[20]),
    .I3(a[4]),
    .O(sig00000134)
  );
  LUT4 #(
    .INIT ( 16'h6240 ))
  blk00000175 (
    .I0(sig0000003f),
    .I1(sig00000040),
    .I2(a[21]),
    .I3(a[5]),
    .O(sig00000135)
  );
  LUT4 #(
    .INIT ( 16'h6240 ))
  blk00000176 (
    .I0(sig0000003f),
    .I1(sig00000040),
    .I2(a[22]),
    .I3(a[6]),
    .O(sig00000136)
  );
  LUT2 #(
    .INIT ( 4'hD ))
  blk00000177 (
    .I0(sig0000017e),
    .I1(sig0000015a),
    .O(sig000000f5)
  );
  LUT2 #(
    .INIT ( 4'hD ))
  blk00000178 (
    .I0(sig0000017f),
    .I1(sig0000015a),
    .O(sig000000f7)
  );
  LUT3 #(
    .INIT ( 8'hCA ))
  blk00000179 (
    .I0(sig0000017a),
    .I1(sig0000017e),
    .I2(sig0000015a),
    .O(sig000000ef)
  );
  LUT3 #(
    .INIT ( 8'hCA ))
  blk0000017a (
    .I0(sig0000017d),
    .I1(sig00000181),
    .I2(sig0000015a),
    .O(sig000000f3)
  );
  LUT3 #(
    .INIT ( 8'h40 ))
  blk0000017b (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[12]),
    .O(sig0000013c)
  );
  LUT3 #(
    .INIT ( 8'h40 ))
  blk0000017c (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[13]),
    .O(sig0000013d)
  );
  LUT3 #(
    .INIT ( 8'h40 ))
  blk0000017d (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[14]),
    .O(sig0000013e)
  );
  LUT3 #(
    .INIT ( 8'h40 ))
  blk0000017e (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[15]),
    .O(sig0000013f)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk0000017f (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[8]),
    .O(sig00000148)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk00000180 (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[9]),
    .O(sig00000149)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk00000181 (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[10]),
    .O(sig0000014a)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk00000182 (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[11]),
    .O(sig0000014b)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk00000183 (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[12]),
    .O(sig0000014c)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk00000184 (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[13]),
    .O(sig0000014d)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk00000185 (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[14]),
    .O(sig0000014e)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk00000186 (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[15]),
    .O(sig0000014f)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk00000187 (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[16]),
    .O(sig00000150)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk00000188 (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[17]),
    .O(sig00000151)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk00000189 (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[18]),
    .O(sig00000152)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk0000018a (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[19]),
    .O(sig00000153)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk0000018b (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[20]),
    .O(sig00000154)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk0000018c (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[21]),
    .O(sig00000155)
  );
  LUT3 #(
    .INIT ( 8'h10 ))
  blk0000018d (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[22]),
    .O(sig00000156)
  );
  LUT3 #(
    .INIT ( 8'h64 ))
  blk0000018e (
    .I0(sig0000003f),
    .I1(sig00000040),
    .I2(a[7]),
    .O(sig00000137)
  );
  LUT3 #(
    .INIT ( 8'h40 ))
  blk0000018f (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[8]),
    .O(sig00000138)
  );
  LUT3 #(
    .INIT ( 8'h40 ))
  blk00000190 (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[9]),
    .O(sig00000139)
  );
  LUT3 #(
    .INIT ( 8'h40 ))
  blk00000191 (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[10]),
    .O(sig0000013a)
  );
  LUT3 #(
    .INIT ( 8'h40 ))
  blk00000192 (
    .I0(sig00000040),
    .I1(sig0000003f),
    .I2(a[11]),
    .O(sig0000013b)
  );
  LUT4 #(
    .INIT ( 16'hFFBA ))
  blk00000193 (
    .I0(a[28]),
    .I1(sig00000006),
    .I2(a[27]),
    .I3(a[29]),
    .O(sig000001a9)
  );
  LUT6 #(
    .INIT ( 64'h7077202220222022 ))
  blk00000194 (
    .I0(sig000000b7),
    .I1(sig00000005),
    .I2(sig00000004),
    .I3(sig000000b6),
    .I4(a[30]),
    .I5(sig000001a9),
    .O(sig00000038)
  );
  LUT5 #(
    .INIT ( 32'hAAAA8A88 ))
  blk00000195 (
    .I0(a[30]),
    .I1(a[28]),
    .I2(sig00000006),
    .I3(a[27]),
    .I4(a[29]),
    .O(sig000001aa)
  );
  LUT6 #(
    .INIT ( 64'hFFBBFFA8FBFBFAF8 ))
  blk00000196 (
    .I0(sig000000b7),
    .I1(sig00000004),
    .I2(sig00000005),
    .I3(a[31]),
    .I4(sig000000b6),
    .I5(sig000001aa),
    .O(sig00000037)
  );
  LUT3 #(
    .INIT ( 8'hA8 ))
  blk00000197 (
    .I0(a[25]),
    .I1(a[24]),
    .I2(a[23]),
    .O(sig000001ab)
  );
  LUT6 #(
    .INIT ( 64'h0111555555555555 ))
  blk00000198 (
    .I0(a[30]),
    .I1(a[27]),
    .I2(a[26]),
    .I3(sig000001ab),
    .I4(a[29]),
    .I5(a[28]),
    .O(sig00000005)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFFFFFE ))
  blk00000199 (
    .I0(a[2]),
    .I1(a[3]),
    .I2(a[21]),
    .I3(a[22]),
    .I4(a[1]),
    .I5(a[20]),
    .O(sig000001ac)
  );
  LUT5 #(
    .INIT ( 32'hFFFFFFFE ))
  blk0000019a (
    .I0(a[16]),
    .I1(a[17]),
    .I2(a[13]),
    .I3(a[14]),
    .I4(a[15]),
    .O(sig000001ad)
  );
  LUT4 #(
    .INIT ( 16'hFFFE ))
  blk0000019b (
    .I0(a[11]),
    .I1(a[12]),
    .I2(a[0]),
    .I3(a[10]),
    .O(sig000001ae)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFFFFFE ))
  blk0000019c (
    .I0(a[8]),
    .I1(a[9]),
    .I2(a[6]),
    .I3(a[7]),
    .I4(a[4]),
    .I5(a[5]),
    .O(sig000001af)
  );
  LUT6 #(
    .INIT ( 64'hFFFFFFFFFFFFFFFE ))
  blk0000019d (
    .I0(sig000001ae),
    .I1(sig000001af),
    .I2(sig000001ac),
    .I3(a[18]),
    .I4(a[19]),
    .I5(sig000001ad),
    .O(sig00000004)
  );
  LUT5 #(
    .INIT ( 32'h2A7F7F7F ))
  blk0000019e (
    .I0(sig000000d4),
    .I1(sig000000d8),
    .I2(sig000000df),
    .I3(sig000000dd),
    .I4(sig000000d6),
    .O(sig000001b0)
  );
  LUT5 #(
    .INIT ( 32'h8880BBB3 ))
  blk0000019f (
    .I0(sig000000d7),
    .I1(sig000000d5),
    .I2(sig000000d4),
    .I3(sig000000de),
    .I4(sig000001b0),
    .O(sig000000d2)
  );
  LUT5 #(
    .INIT ( 32'hEA404040 ))
  blk000001a0 (
    .I0(sig000000d5),
    .I1(sig000000dc),
    .I2(sig000000e2),
    .I3(sig000000da),
    .I4(sig000000e0),
    .O(sig000001b1)
  );
  LUT6 #(
    .INIT ( 64'hFBBBEAAA51114000 ))
  blk000001a1 (
    .I0(sig000000d4),
    .I1(sig000000d5),
    .I2(sig000000db),
    .I3(sig000000e1),
    .I4(sig000000d9),
    .I5(sig000001b1),
    .O(sig000000d3)
  );
  LUT3 #(
    .INIT ( 8'hAC ))
  blk000001a2 (
    .I0(sig0000017c),
    .I1(sig0000017b),
    .I2(sig00000158),
    .O(sig000001b2)
  );
  LUT6 #(
    .INIT ( 64'hFF35FF00FF35FFFF ))
  blk000001a3 (
    .I0(sig0000017f),
    .I1(sig00000180),
    .I2(sig00000158),
    .I3(sig0000015b),
    .I4(sig0000015a),
    .I5(sig000001b2),
    .O(sig000000fb)
  );
  LUT6 #(
    .INIT ( 64'h0A001B114E445F55 ))
  blk000001a4 (
    .I0(sig00000159),
    .I1(sig00000158),
    .I2(sig0000015b),
    .I3(sig000001b3),
    .I4(sig000000f8),
    .I5(sig000000f9),
    .O(sig00000128)
  );
  LUT6 #(
    .INIT ( 64'h028A139B46CE57DF ))
  blk000001a5 (
    .I0(sig00000159),
    .I1(sig00000158),
    .I2(sig000000f9),
    .I3(sig000001b4),
    .I4(sig000000f6),
    .I5(sig000000f8),
    .O(sig00000127)
  );
  LUT6 #(
    .INIT ( 64'h00FF33330F0F5555 ))
  blk000001a6 (
    .I0(sig0000015c),
    .I1(sig00000160),
    .I2(sig00000164),
    .I3(sig00000168),
    .I4(sig0000015b),
    .I5(sig0000015a),
    .O(sig000001b5)
  );
  LUT6 #(
    .INIT ( 64'hEFABCD8967234501 ))
  blk000001a7 (
    .I0(sig00000159),
    .I1(sig00000158),
    .I2(sig000001b5),
    .I3(sig00000109),
    .I4(sig000000fa),
    .I5(sig000000fd),
    .O(sig0000010c)
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  blk000001a8 (
    .I0(sig00000066),
    .O(sig000001b6)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001a9 (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig00000067),
    .I4(sig0000008c),
    .O(sig00000012)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001aa (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig0000008b),
    .I4(sig0000008c),
    .O(sig00000036)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001ab (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig0000008a),
    .I4(sig0000008c),
    .O(sig00000035)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001ac (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig00000087),
    .I4(sig0000008c),
    .O(sig00000032)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001ad (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig00000089),
    .I4(sig0000008c),
    .O(sig00000034)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001ae (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig00000084),
    .I4(sig0000008c),
    .O(sig0000002f)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001af (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig00000088),
    .I4(sig0000008c),
    .O(sig00000033)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001b0 (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig00000086),
    .I4(sig0000008c),
    .O(sig00000031)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001b1 (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig00000085),
    .I4(sig0000008c),
    .O(sig00000030)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001b2 (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig00000081),
    .I4(sig0000008c),
    .O(sig0000002c)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001b3 (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig00000082),
    .I4(sig0000008c),
    .O(sig0000002d)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001b4 (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig00000083),
    .I4(sig0000008c),
    .O(sig0000002e)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001b5 (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig00000080),
    .I4(sig0000008c),
    .O(sig0000002b)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001b6 (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig0000007f),
    .I4(sig0000008c),
    .O(sig0000002a)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001b7 (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig0000007e),
    .I4(sig0000008c),
    .O(sig00000029)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001b8 (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig0000007d),
    .I4(sig0000008c),
    .O(sig00000028)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001b9 (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig0000007a),
    .I4(sig0000008c),
    .O(sig00000025)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001ba (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig0000007c),
    .I4(sig0000008c),
    .O(sig00000027)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001bb (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig0000007b),
    .I4(sig0000008c),
    .O(sig00000026)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001bc (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig00000079),
    .I4(sig0000008c),
    .O(sig00000024)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001bd (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig00000077),
    .I4(sig0000008c),
    .O(sig00000022)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001be (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig00000078),
    .I4(sig0000008c),
    .O(sig00000023)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001bf (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig00000074),
    .I4(sig0000008c),
    .O(sig0000001f)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001c0 (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig00000076),
    .I4(sig0000008c),
    .O(sig00000021)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001c1 (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig00000073),
    .I4(sig0000008c),
    .O(sig0000001e)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001c2 (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig00000075),
    .I4(sig0000008c),
    .O(sig00000020)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001c3 (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig00000072),
    .I4(sig0000008c),
    .O(sig0000001d)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001c4 (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig00000071),
    .I4(sig0000008c),
    .O(sig0000001c)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001c5 (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig00000070),
    .I4(sig0000008c),
    .O(sig0000001b)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001c6 (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig0000006f),
    .I4(sig0000008c),
    .O(sig0000001a)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001c7 (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig0000006d),
    .I4(sig0000008c),
    .O(sig00000018)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001c8 (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig0000006e),
    .I4(sig0000008c),
    .O(sig00000019)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001c9 (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig0000006a),
    .I4(sig0000008c),
    .O(sig00000015)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001ca (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig0000006c),
    .I4(sig0000008c),
    .O(sig00000017)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001cb (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig0000006b),
    .I4(sig0000008c),
    .O(sig00000016)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001cc (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig00000069),
    .I4(sig0000008c),
    .O(sig00000014)
  );
  LUT5 #(
    .INIT ( 32'h33233322 ))
  blk000001cd (
    .I0(sig000000b4),
    .I1(sig000000b5),
    .I2(sig00000066),
    .I3(sig00000068),
    .I4(sig0000008c),
    .O(sig00000013)
  );
  LUT6 #(
    .INIT ( 64'hFF00CCCCF0F0AAAA ))
  blk000001ce (
    .I0(sig00000172),
    .I1(sig00000176),
    .I2(sig0000017a),
    .I3(sig0000017e),
    .I4(sig0000015b),
    .I5(sig0000015a),
    .O(sig000000ee)
  );
  LUT5 #(
    .INIT ( 32'hFF330F55 ))
  blk000001cf (
    .I0(sig00000177),
    .I1(sig0000017b),
    .I2(sig0000017f),
    .I3(sig0000015b),
    .I4(sig0000015a),
    .O(sig000000f6)
  );
  LUT5 #(
    .INIT ( 32'hFF330F55 ))
  blk000001d0 (
    .I0(sig00000176),
    .I1(sig0000017a),
    .I2(sig0000017e),
    .I3(sig0000015b),
    .I4(sig0000015a),
    .O(sig000000f4)
  );
  LUT6 #(
    .INIT ( 64'hFF00CCCCF0F0AAAA ))
  blk000001d1 (
    .I0(sig00000175),
    .I1(sig00000179),
    .I2(sig0000017d),
    .I3(sig00000181),
    .I4(sig0000015b),
    .I5(sig0000015a),
    .O(sig000000f2)
  );
  LUT6 #(
    .INIT ( 64'hFF00F0F0CCCCAAAA ))
  blk000001d2 (
    .I0(sig0000017a),
    .I1(sig0000017b),
    .I2(sig0000017e),
    .I3(sig0000017f),
    .I4(sig00000158),
    .I5(sig0000015a),
    .O(sig000001b3)
  );
  LUT4 #(
    .INIT ( 16'hF3F5 ))
  blk000001d3 (
    .I0(sig0000017a),
    .I1(sig0000017e),
    .I2(sig0000015b),
    .I3(sig0000015a),
    .O(sig000001b4)
  );
  MUXF7   blk000001d4 (
    .I0(sig000001b7),
    .I1(sig000001b8),
    .S(sig000000f7),
    .O(sig0000012f)
  );
  LUT6 #(
    .INIT ( 64'h0010115500101111 ))
  blk000001d5 (
    .I0(sig0000015b),
    .I1(sig00000159),
    .I2(sig00000180),
    .I3(sig0000015a),
    .I4(sig00000158),
    .I5(sig00000181),
    .O(sig000001b7)
  );
  LUT6 #(
    .INIT ( 64'h0110010000100000 ))
  blk000001d6 (
    .I0(sig0000015a),
    .I1(sig0000015b),
    .I2(sig00000158),
    .I3(sig00000159),
    .I4(sig00000180),
    .I5(sig00000181),
    .O(sig000001b8)
  );
  LUT5 #(
    .INIT ( 32'h51510F1F ))
  blk000001d7 (
    .I0(a[20]),
    .I1(a[21]),
    .I2(a[23]),
    .I3(a[22]),
    .I4(a[24]),
    .O(sig000000cb)
  );
  LUT5 #(
    .INIT ( 32'h51510F1F ))
  blk000001d8 (
    .I0(a[16]),
    .I1(a[17]),
    .I2(a[23]),
    .I3(a[18]),
    .I4(a[24]),
    .O(sig000000cc)
  );
  LUT5 #(
    .INIT ( 32'h51510F1F ))
  blk000001d9 (
    .I0(a[8]),
    .I1(a[9]),
    .I2(a[23]),
    .I3(a[10]),
    .I4(a[24]),
    .O(sig000000ce)
  );
  LUT5 #(
    .INIT ( 32'h51510F1F ))
  blk000001da (
    .I0(a[4]),
    .I1(a[5]),
    .I2(a[23]),
    .I3(a[6]),
    .I4(a[24]),
    .O(sig000000cf)
  );
  LUT5 #(
    .INIT ( 32'h51510F1F ))
  blk000001db (
    .I0(a[12]),
    .I1(a[13]),
    .I2(a[23]),
    .I3(a[14]),
    .I4(a[24]),
    .O(sig000000cd)
  );
  LUT5 #(
    .INIT ( 32'h51510F1F ))
  blk000001dc (
    .I0(a[0]),
    .I1(a[1]),
    .I2(a[23]),
    .I3(a[2]),
    .I4(a[24]),
    .O(sig000000d0)
  );
  LUT5 #(
    .INIT ( 32'hAAA9A9A9 ))
  blk000001dd (
    .I0(a[27]),
    .I1(a[25]),
    .I2(a[26]),
    .I3(a[23]),
    .I4(a[24]),
    .O(sig0000003f)
  );
  LUT6 #(
    .INIT ( 64'h1111111411141114 ))
  blk000001de (
    .I0(a[28]),
    .I1(a[27]),
    .I2(a[25]),
    .I3(a[26]),
    .I4(a[23]),
    .I5(a[24]),
    .O(sig00000157)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000001df (
    .C(clk),
    .CE(ce),
    .D(sig00000007),
    .Q(sig000001b9)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000001e0 (
    .C(clk),
    .CE(ce),
    .D(sig00000007),
    .Q(sig000001ba)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000001e1 (
    .C(clk),
    .CE(ce),
    .D(sig00000007),
    .Q(sig000001bb)
  );
  FDE #(
    .INIT ( 1'b0 ))
  blk000001e2 (
    .C(clk),
    .CE(ce),
    .D(sig00000007),
    .Q(sig000001bc)
  );
  MUXF7   blk000001e3 (
    .I0(sig000001bd),
    .I1(sig000001be),
    .S(sig00000159),
    .O(sig0000012e)
  );
  LUT5 #(
    .INIT ( 32'h11011000 ))
  blk000001e4 (
    .I0(sig0000015b),
    .I1(sig0000015a),
    .I2(sig00000158),
    .I3(sig0000017f),
    .I4(sig0000017e),
    .O(sig000001bd)
  );
  LUT5 #(
    .INIT ( 32'h11011000 ))
  blk000001e5 (
    .I0(sig0000015b),
    .I1(sig0000015a),
    .I2(sig00000158),
    .I3(sig00000181),
    .I4(sig00000180),
    .O(sig000001be)
  );
  MUXF7   blk000001e6 (
    .I0(sig000001bf),
    .I1(sig000001c0),
    .S(sig00000158),
    .O(sig0000012d)
  );
  LUT6 #(
    .INIT ( 64'h1505140411011000 ))
  blk000001e7 (
    .I0(sig0000015b),
    .I1(sig00000159),
    .I2(sig0000015a),
    .I3(sig00000181),
    .I4(sig0000017d),
    .I5(sig0000017f),
    .O(sig000001bf)
  );
  LUT5 #(
    .INIT ( 32'h11011000 ))
  blk000001e8 (
    .I0(sig0000015b),
    .I1(sig0000015a),
    .I2(sig00000159),
    .I3(sig00000180),
    .I4(sig0000017e),
    .O(sig000001c0)
  );
  MUXF7   blk000001e9 (
    .I0(sig000001c1),
    .I1(sig000001c2),
    .S(sig00000158),
    .O(sig0000012a)
  );
  LUT6 #(
    .INIT ( 64'h5515511144044000 ))
  blk000001ea (
    .I0(sig0000015b),
    .I1(sig00000159),
    .I2(sig0000015a),
    .I3(sig00000180),
    .I4(sig0000017c),
    .I5(sig000000ef),
    .O(sig000001c1)
  );
  LUT6 #(
    .INIT ( 64'h5545544411011000 ))
  blk000001eb (
    .I0(sig0000015b),
    .I1(sig00000159),
    .I2(sig0000015a),
    .I3(sig0000017f),
    .I4(sig0000017b),
    .I5(sig000000f3),
    .O(sig000001c2)
  );
  SRLC16E #(
    .INIT ( 16'h0000 ))
  blk000001ec (
    .A0(sig00000001),
    .A1(sig00000002),
    .A2(sig00000002),
    .A3(sig00000002),
    .CE(ce),
    .CLK(clk),
    .D(operation_nd),
    .Q(sig00000003),
    .Q15(NLW_blk000001ec_Q15_UNCONNECTED)
  );

// synthesis translate_on

endmodule

// synthesis translate_off

`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

// synthesis translate_on
