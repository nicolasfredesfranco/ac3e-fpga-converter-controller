`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AC3E
// Engineer: Nicolas I. Fredes Franco
// 
// Create Date: 07.02.2017 10:44:22
// Design Name: 
// Module Name: controlador
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


module controlador(clk, trigger, Vdc1, Vdc2, Iref, fs_DAB, tau1, tau2, phi);
	input clk, trigger;
	input signed [13:0] Vdc1, Vdc2, Iref;
	input signed [18:0] fs_DAB;
	output reg signed [8:0] tau1, tau2, phi;

	wire [31:0] Vdc1_float, Vdc2_float, Iref_float, fs_float;
	wire rdy_Vdc1, rdy_Vdc2, rdy_Iref, rdy_fs;

	wire [31:0] Vdc1_float_adap, Vdc2_float_adap, Iref_float_adap;
	wire rdy_Vdc1_adap, rdy_Vdc2_adap, rdy_Iref_adap;


	wire [31:0] Vdc2p, d, f2_Iref, f2_Iref_Vdc1, f3, d_inv, uno_d_inv, f4, aux1;
	wire rdy_Vdc2p, rdy_d, rdy_f2_Iref, rdy_f2_Iref_Vdc1, rdy_f3, rdy_d_inv, rdy_uno_d_inv, rdy_f4, rdy_aux1;




	localparam razon_vueltas= 32'b01000000101100000000000000000000;  // (n1/n2)
	localparam L=32'b00110111110100011011011100010111;
	localparam f1=32'b00111101000001110110011110111000; // ((n2/n1)^2 /4) * Isc^2
	localparam f2=32'b01000110000111000100000000000000; // (1/(4L))
	localparam uno=32'b00111111100000000000000000000000;  // 1 en float
	/////////////////////Paso de las entradas a float


	SInt13ToSingle float_vdc1 (
	.a(Vdc1), // input [13 : 0] a
	.clk(clk), // input clk
	.result(Vdc1_float), // output [31 : 0] result
	.rdy(rdy_Vdc1) // output rdy
	);


	SInt13ToSingle float_vdc2 (
	.a(Vdc2), // input [13 : 0] a
	.clk(clk), // input clk
	.result(Vdc2_float), // output [31 : 0] result
	.rdy(rdy_Vdc2) // output rdy
	);


	SInt13ToSingle float_iref (
	.a(Iref), // input [13 : 0] a
	.clk(clk), // input clk
	.result(Iref_float), // output [31 : 0] result
	.rdy(rdy_Iref) // output rdy
	);


	SInt18ToSingle float_fs (
  .a(fs_DAB), // input [18 : 0] a
  .clk(clk), // input clk
  .result(fs_float), // output [31 : 0] result
  .rdy(rdy_fs) // output rdy
);

	////////////////////////adaptacion que supone unos voltajes de 0 a 1000, y una corriente de -50 a 50

	// (50/8192) = 00111011110010000000000000000000  en float32

	// (1000/8192) = 00111101111110100000000000000000  en float


	multiply_float adaptacion_Vdc1 (
  .a(Vdc1_float), // input [31 : 0] a
  .b(32'b00111101111110100000000000000000), // input [31 : 0] b
  .operation_nd(rdy_Vdc1), // input operation_nd
  .clk(clk), // input clk
  .result(Vdc1_float_adap), // output [31 : 0] result
  .rdy(rdy_Vdc1_adap) // output rdy
);


	multiply_float adaptacion_Vdc2 (
  .a(Vdc2_float), // input [31 : 0] a
  .b(32'b00111101111110100000000000000000), // input [31 : 0] b
  .operation_nd(rdy_Vdc2), // input operation_nd
  .clk(clk), // input clk
  .result(Vdc2_float_adap), // output [31 : 0] res ult
  .rdy(rdy_Vdc2_adap) // output rdy
);

	multiply_float adaptacion_Iref (
  .a(Iref_float), // input [31 : 0] a
  .b(32'b00111011110010000000000000000000), // input [31 : 0] b
  .operation_nd(rdy_Iref), // input operation_nd
  .clk(clk), // input clk
  .result(Iref_float_adap), // output [31 : 0] result
  .rdy(rdy_Iref_adap) // output rdy
);



////////////////////////// calculo primer aux

multiply_float calculo_Vdc2p (
  .a(Vdc2_float_adap), // input [31 : 0] a
  .b(razon_vueltas), // input [31 : 0] b
  .operation_nd(rdy_Vdc2_adap), // input operation_nd
  .clk(clk), // input clk
  .result(Vdc2p), // output [31 : 0] result
  .rdy(rdy_Vdc2p) // output rdy
);

Divide_float your_instance_name (
  .a(Vdc2p), // input [31 : 0] a
  .b(Vdc1_float_adap), // input [31 : 0] b
  .operation_nd(rdy_Vdc2p), // input operation_nd
  .clk(clk), // input clk
  .result(d), // output [31 : 0] result
  .rdy(rdy_d) // output rdy
);

//f2*Idc_ref
multiply_float calculo_Vdc2p (
  .a(f2), // input [31 : 0] a
  .b(Iref_float_adap), // input [31 : 0] b
  .operation_nd(rdy_Iref_adap), // input operation_nd
  .clk(clk), // input clk
  .result(f2_Iref), // f2*Idcref
  .rdy(rdy_f2_Iref) // output rdy
);

//f2*Idc_ref*Vdc1
multiply_float calculo_Vdc2p (
  .a(f2_Iref), // input [31 : 0] a
  .b(Vdc1_float_adap), // input [31 : 0] b
  .operation_nd(rdy_f2_Iref), // input operation_nd
  .clk(clk), // input clk
  .result(f2_Iref_Vdc1), // f2*Idcref
  .rdy(rdy_f2_Iref_Vdc1) // output rdy
);

// f2*(Idc_ref * Vdc1/fs)
Divide_float your_instance_name (
  .a(f2_Iref_Vdc1), // input [31 : 0] a
  .b(fs_float), // input [31 : 0] b
  .operation_nd(rdy_f2_Iref_Vdc1), // input operation_nd
  .clk(clk), // input clk
  .result(f3), // output [31 : 0] result
  .rdy(rdy_f3) // output rdy
);

//(1/d)
Divide_float your_instance_name (
  .a(Vdc1_float_adap), // input [31 : 0] a
  .b(Vdc2p), // input [31 : 0] b
  .operation_nd(rdy_Vdc2p), // input operation_nd
  .clk(clk), // input clk
  .result(d_inv), // output [31 : 0] result
  .rdy(rdy_d_inv) // output rdy
);

//1- (1/d)
resta_float your_instance_name (
  .a(uno), // input [31 : 0] a
  .b(d_inv), // input [31 : 0] b
  .operation_nd(rdy_d_inv), // input operation_nd
  .clk(clk), // input clk
  .result(uno_d_inv), // output [31 : 0] result
  .rdy(rdy_uno_d_inv) // output rdy
);


//f4
multiply_float calculo_Vdc2p (
  .a(f3), // input [31 : 0] a
  .b(uno_d_inv), // input [31 : 0] b
  .operation_nd(rdy_f3), // input operation_nd
  .clk(clk), // input clk
  .result(f4), // f2*Idcref
  .rdy(rdy_f4) // output rdy
);

//aux1
suma_float your_instance_name (
  .a(f1), // input [31 : 0] a
  .b(f4), // input [31 : 0] b
  .operation_nd(rdy_f4), // input operation_nd
  .clk(clk), // input clk
  .result(aux1), // output [31 : 0] result
  .rdy(rdy_aux1) // output rdy
);

/////////////////////// que hacer con aux1? 

endmodule
