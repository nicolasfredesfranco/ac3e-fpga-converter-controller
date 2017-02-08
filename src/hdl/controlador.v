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


  wire aux1_positivo, rdy_comparacion1, invalid_op1, rdy_sqrt1, rdy_v2_v1, rdy_fs_d, rdy_4piL_fs_d, rdy_f5, rdy_f6;
  reg calcular_sqrt1, calcular_sqrt2;  
  wire [31:0] sqrt1, v2_v1, fs_d, 4piL_fs_d, f5, f6;

  wire rdy_f7, rdy_f8, rdy_tau1_modo2a, rdy_fs_v2_v1, rdy_f9, rdy_f10, rdy_tau2_modo2a, rdy_f11, rdy_phi_modo2a;  
  wire [31:0]  f7, f8, tau1_modo2a, fs_v2_v1, f9, f10, tau2_modo2a, f11, phi_modo2a;


  wire [31:0] tau1_modo2b, tau1_modo1,tau1_modo1_d, tau1_modo2b_d, c2_fs, c2_fs_Vdc2p, tau2_modo1, tau2_modo2b;
  wire rdy_tau1_modo1_d, rdy_tau1_modo2b_d, rdy_c2_fs, rdy_c2_fs_Vdc2p, rdy_tau2_modo1, rdy_tau2_modo2b;

  wire rdy_2pi2L_fs, rdy_2pi2L_fs_Iref, rdy_Vdc2p_tau2_modo2b, rdy_f12, rdy_f13, rdy_phi_modo2b;
  wire [31:0] 2pi2L_fs, 2pi2L_fs_Iref, Vdc2p_tau2_modo2b, f12, f13, phi_modo2b;


  wire [31:0] h1, h2, h3, h4, h5, h6, aux2, menos_2pi2L_fs, menos_2pi2L_fs_Iref;
  wire rdy_h1, rdy_h2, rdy_h3, rdy_h4, rdy_h5, rdy_h6, rdy_aux2, rdy_menos_2pi2L_fs, rdy_menos_2pi2L_fs_Iref;


  wire aux2_positivo, rdy_comparacion2, invalid_op2, rdy_sqrt2, rdy_tau2_modo1_dos, rdy_phi_modo1;
  wire [31:0] sqrt2, tau2_modo1_dos, phi_modo1;


  wire rdy_tau1_modo2a_esc, rdy_tau2_modo2a_esc, rdy_tau2_modo2b_esc, rdy_tau2_modo1_esc, rdy_phi_modo2a_esc, rdy_phi_modo2b_esc, rdy_phi_modo1_esc;
  wire [31:0] tau1_modo2a_esc, tau2_modo2a_esc, tau2_modo2b_esc, tau2_modo1_esc, phi_modo2a_esc, phi_modo2b_esc, phi_modo1_esc;


  wire rdy_tau1_modo2a_final, rdy_tau2_modo2a_final, rdy_tau2_modo2b_final, rdy_tau2_modo1_final, rdy_phi_modo2a_final, rdy_phi_modo2b_final, rdy_phi_modo1_final;
  wire signed [8:0] tau1_modo2a_final, tau2_modo2a_final, tau2_modo2b_final, tau2_modo1_final, phi_modo2a_final, phi_modo2b_final, phi_modo1_final;


  localparam razon_vueltas= 32'b01000000101100000000000000000000;  // (n1/n2)
  localparam razon_vueltas_inv= 32'b00111110001110100010111010001100;  // (n2/n1)
  localparam L=32'b00110111110100011011011100010111; //L
  localparam f1=32'b00111101000001110110011110111000; // ((n2/n1)^2 /4) * Isc^2
  localparam f2=32'b01000110000111000100000000000000; // (1/(4L))
  localparam uno=32'b00111111100000000000000000000000;  // 1 en float
  localparam 4piL=32'b00111001101001001011010110111110; //4*pi*L
  localparam Ipc=32'b01000000000000000000000000000000; //2 en float 
  localparam c1=32'b10111001110000101010100000111110; //c1 =  -2 pi * L * (Ipc + Isc*n2/n1)
  localparam pi=32'b01000000010010010000111111011011; //pi en float 
  localparam c2=32'b10111010001001001011010110111110; //c2= -4pi*L*Ipc
  localparam 2pi2L=32'b00111010000000010101110011100110; //2 pi^2 * L
  localparam menos_2pi2L=32'b10111010000000010101110011100110; //-2 pi^2 * L
  localparam pi_medio=32'b00111111110010010000111111011011; //pi/2
  localparam menos_pi_medio=32'b10111111110010010000111111011011; //-pi/2
  localparam menos_1cuarto=32'b10111110100000000000000000000000; // -1/4
  localparam menos_pi2_cuarto= 32'b11000000000111011110100111100110; // - pi^2 /4
  localparam escalado = 32'b01000010101000100101011010001010; // 255/pi



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

mayor_igual_float your_instance_name (
  .a(aux1), // input [31 : 0] a
  .b(32'b0), // input [31 : 0] b
  .operation_nd(rdy_aux1), // input operation_nd
  .clk(clk), // input clk
  .result(aux1_positivo), // output [0 : 0] result
  .rdy(rdy_comparacion1) // output rdy
);
  

always @(*)
begin
  if (aux1_positivo && rdy_comparacion1) // se deduce que modo2a=aux1_positivo
  begin
    calcular_sqrt1 = 1'b1;
  end
  else 
  begin
    calcular_sqrt1 = 1'b0;
  end
end

  // raiz de aux
  sqrt_float your_instance_name (
  .a(aux1), // input [31 : 0] a
  .operation_nd(calcular_sqrt1), // input operation_nd
  .clk(clk), // input clk
  .result(sqrt1), // output [31 : 0] result
  .invalid_op(invalid_op1), // output invalid_op
  .rdy(rdy_sqrt1) // output rdy
);


resta_float your_instance_name (
  .a(Vdc2p), // input [31 : 0] a
  .b(Vdc1_float_adap), // input [31 : 0] b
  .operation_nd(rdy_sqrt1), // input operation_nd
  .clk(clk), // input clk
  .result(v2_v1), // output [31 : 0] result
  .rdy(rdy_v2_v1) // output rdy
);

multiply_float calculo_Vdc2p (
  .a(fs_float), // input [31 : 0] a
  .b(d), // input [31 : 0] b
  .operation_nd(rdy_d), // input operation_nd
  .clk(clk), // input clk
  .result(fs_d), // f2*Idcref
  .rdy(rdy_fs_d) // output rdy
);

multiply_float calculo_Vdc2p (
  .a(fs_d), // input [31 : 0] a
  .b(4piL), // input [31 : 0] b
  .operation_nd(rdy_fs_d), // input operation_nd
  .clk(clk), // input clk
  .result(4piL_fs_d), // 
  .rdy(rdy_4piL_fs_d) // output rdy
);

//f5
Divide_float your_instance_name (
  .a(4piL_fs_d), // input [31 : 0] a
  .b(v2_v1), // input [31 : 0] b
  .operation_nd(rdy_v2_v1), // input operation_nd
  .clk(clk), // input clk
  .result(f5), // output [31 : 0] result
  .rdy(rdy_f5) // output rdy
);


//Ipc *(1- (1/d))
multiply_float calculo_Vdc2p (
  .a(Ipc), // input [31 : 0] a
  .b(uno_d_inv), // input [31 : 0] b
  .operation_nd(rdy_uno_d_inv), // input operation_nd
  .clk(clk), // input clk
  .result(f6), // 
  .rdy(rdy_f6) // output rdy
);

suma_float your_instance_name (
  .a(f6), // input [31 : 0] a
  .b(razon_vueltas_inv), // input [31 : 0] b
  .operation_nd(rdy_f6), // input operation_nd
  .clk(clk), // input clk
  .result(f7), // output [31 : 0] result
  .rdy(rdy_f7) // output rdy
);


suma_float your_instance_name (
  .a(f7), // input [31 : 0] a
  .b(sqrt1), // input [31 : 0] b
  .operation_nd(rdy_sqrt1), // input operation_nd
  .clk(clk), // input clk
  .result(f8), // output [31 : 0] result
  .rdy(rdy_f8) // output rdy
);


multiply_float calculo_Vdc2p (
  .a(f5), // input [31 : 0] a
  .b(f8), // input [31 : 0] b
  .operation_nd(rdy_f5), // input operation_nd
  .clk(clk), // input clk
  .result(tau1_modo2a), // 
  .rdy(rdy_tau1_modo2a) // output rdy
);


Divide_float your_instance_name (
  .a(fs_float), // input [31 : 0] a
  .b(v2_v1), // input [31 : 0] b
  .operation_nd(rdy_v2_v1), // input operation_nd
  .clk(clk), // input clk
  .result(fs_v2_v1), // output [31 : 0] result
  .rdy(rdy_fs_v2_v1) // output rdy
);

multiply_float calculo_Vdc2p (
  .a(fs_v2_v1), // input [31 : 0] a
  .b(4piL), // input [31 : 0] b
  .operation_nd(rdy_fs_v2_v1), // input operation_nd
  .clk(clk), // input clk
  .result(f9), // 
  .rdy(rdy_f9) // output rdy
);

suma_float your_instance_name (
  .a(sqrt1), // input [31 : 0] a
  .b(razon_vueltas_inv), // input [31 : 0] b
  .operation_nd(rdy_sqrt1), // input operation_nd
  .clk(clk), // input clk
  .result(f10), // output [31 : 0] result
  .rdy(rdy_f10) // output rdy
);


multiply_float calculo_Vdc2p (
  .a(f9), // input [31 : 0] a
  .b(f10), // input [31 : 0] b
  .operation_nd(rdy_f9), // input operation_nd
  .clk(clk), // input clk
  .result(tau2_modo2a), // 
  .rdy(rdy_tau2_modo2a) // output rdy
);

multiply_float calculo_Vdc2p (
  .a(c1), // input [31 : 0] a
  .b(fs_float), // input [31 : 0] b
  .operation_nd(rdy_fs), // input operation_nd
  .clk(clk), // input clk
  .result(f11), // 
  .rdy(rdy_f11) // output rdy
);

Divide_float your_instance_name (
  .a(f11), // input [31 : 0] a
  .b(Vdc1_float_adap), // input [31 : 0] b
  .operation_nd(rdy_f11), // input operation_nd
  .clk(clk), // input clk
  .result(phi_modo2a), // output [31 : 0] result
  .rdy(rdy_phi_modo2a) // output rdy
);

////////////////////////


assign tau1_modo2b = pi;
assign tau1_modo1  = pi;

Divide_float your_instance_name (
  .a(tau1_modo2b), // input [31 : 0] a
  .b(d), // input [31 : 0] b
  .operation_nd(rdy_d), // input operation_nd
  .clk(clk), // input clk
  .result(tau1_modo2b_d), // output [31 : 0] result
  .rdy(rdy_tau1_modo2b_d) // output rdy
);


Divide_float your_instance_name (
  .a(tau1_modo1), // input [31 : 0] a
  .b(d), // input [31 : 0] b
  .operation_nd(rdy_d), // input operation_nd
  .clk(clk), // input clk
  .result(tau1_modo1_d), // output [31 : 0] result
  .rdy(rdy_tau1_modo1_d) // output rdy
);

multiply_float calculo_Vdc2p (
  .a(c2), // input [31 : 0] a
  .b(fs_float), // input [31 : 0] b
  .operation_nd(rdy_fs), // input operation_nd
  .clk(clk), // input clk
  .result(c2_fs), // 
  .rdy(rdy_c2_fs) // output rdy
);

Divide_float your_instance_name (
  .a(c2_fs), // input [31 : 0] a
  .b(Vdc2p), // input [31 : 0] b
  .operation_nd(rdy_Vdc2p), // input operation_nd
  .clk(clk), // input clk
  .result(c2_fs_Vdc2p), // output [31 : 0] result
  .rdy(rdy_c2_fs_Vdc2p) // output rdy
);


//tau2_modo2b
suma_float your_instance_name (
  .a(tau1_modo2b_d), // input [31 : 0] a
  .b(c2_fs_Vdc2p), // input [31 : 0] b
  .operation_nd(rdy_tau1_modo2b_d), // input operation_nd
  .clk(clk), // input clk
  .result(tau2_modo2b), // output [31 : 0] result
  .rdy(rdy_tau2_modo2b) // output rdy
);


//tau2_modo1
suma_float your_instance_name (
  .a(tau1_modo1_d), // input [31 : 0] a
  .b(c2_fs_Vdc2p), // input [31 : 0] b
  .operation_nd(rdy_tau1_modo1_d), // input operation_nd
  .clk(clk), // input clk
  .result(tau2_modo1), // output [31 : 0] result
  .rdy(rdy_tau2_modo1) // output rdy
);


//////

multiply_float calculo_Vdc2p (
  .a(2pi2L), // input [31 : 0] a
  .b(fs_float), // input [31 : 0] b
  .operation_nd(rdy_fs), // input operation_nd
  .clk(clk), // input clk
  .result(2pi2L_fs), // 
  .rdy(rdy_2pi2L_fs) // output rdy
);

multiply_float calculo_Vdc2p (
  .a(2pi2L_fs), // input [31 : 0] a
  .b(Iref_float_adap), // input [31 : 0] b
  .operation_nd(rdy_2pi2L_fs), // input operation_nd
  .clk(clk), // input clk
  .result(2pi2L_fs_Iref), // 
  .rdy(rdy_2pi2L_fs_Iref) // output rdy
);


multiply_float calculo_Vdc2p (
  .a(Vdc2p), // input [31 : 0] a
  .b(tau2_modo2b), // input [31 : 0] b
  .operation_nd(rdy_tau2_modo2b), // input operation_nd
  .clk(clk), // input clk
  .result(Vdc2p_tau2_modo2b), // 
  .rdy(rdy_Vdc2p_tau2_modo2b) // output rdy
);


Divide_float your_instance_name (
  .a(2pi2L_fs_Iref), // input [31 : 0] a
  .b(Vdc2p_tau2_modo2b), // input [31 : 0] b
  .operation_nd(rdy_Vdc2p_tau2_modo2b), // input operation_nd
  .clk(clk), // input clk
  .result(f12), // output [31 : 0] result
  .rdy(rdy_f12) // output rdy
);

suma_float your_instance_name (
  .a(f12), // input [31 : 0] a
  .b(menos_pi_medio), // input [31 : 0] b
  .operation_nd(rdy_f12), // input operation_nd
  .clk(clk), // input clk
  .result(f13), // output [31 : 0] result
  .rdy(rdy_f13) // output rdy
);

Divide_float your_instance_name (
  .a(tau2_modo2b), // input [31 : 0] a
  .b(dos), // input [31 : 0] b
  .operation_nd(rdy_tau2_modo2b), // input operation_nd
  .clk(clk), // input clk
  .result(phi_modo2b), // output [31 : 0] result
  .rdy(rdy_phi_modo2b) // output rdy
);

////////////////// aux2   referencia en amarillo

multiply_float calculo_Vdc2p (
  .a(menos_1cuarto), // input [31 : 0] a
  .b(tau2_modo1), // input [31 : 0] b
  .operation_nd(rdy_tau2_modo1), // input operation_nd
  .clk(clk), // input clk
  .result(h1), // 
  .rdy(rdy_h1) // output rdy
);

multiply_float calculo_Vdc2p (
  .a(h1), // input [31 : 0] a
  .b(tau2_modo1), // input [31 : 0] b
  .operation_nd(rdy_h1), // input operation_nd
  .clk(clk), // input clk
  .result(h2), // 
  .rdy(rdy_h2) // output rdy
);

multiply_float calculo_Vdc2p (
  .a(pi_medio), // input [31 : 0] a
  .b(tau2_modo1), // input [31 : 0] b
  .operation_nd(rdy_tau2_modo1), // input operation_nd
  .clk(clk), // input clk
  .result(h3), // 
  .rdy(rdy_h3) // output rdy
);

multiply_float calculo_Vdc2p (
  .a(menos_2pi2L), // input [31 : 0] a
  .b(fs_float), // input [31 : 0] b
  .operation_nd(rdy_fs), // input operation_nd
  .clk(clk), // input clk
  .result(menos_2pi2L_fs), // ssss
  .rdy(rdy_menos_2pi2L_fs) // output rdy
);

multiply_float calculo_Vdc2p (
  .a(menos_2pi2L_fs), // input [31 : 0] a
  .b(Iref_float_adap), // input [31 : 0] b
  .operation_nd(rdy_Iref_adap), // input operation_nd
  .clk(clk), // input clk
  .result(menos_2pi2L_fs_Iref), // 
  .rdy(rdy_menos_2pi2L_fs_Iref) // output rdy
);

Divide_float your_instance_name (
  .a(menos_2pi2L_fs_Iref), // input [31 : 0] a
  .b(Vdc2p), // input [31 : 0] b
  .operation_nd(rdy_menos_2pi2L_fs_Iref), // input operation_nd
  .clk(clk), // input clk
  .result(h4), // output [31 : 0] result
  .rdy(rdy_h4) // output rdy
);

suma_float your_instance_name (
  .a(h2), // input [31 : 0] a
  .b(menos_pi2_cuarto), // input [31 : 0] b
  .operation_nd(rdy_h2), // input operation_nd
  .clk(clk), // input clk
  .result(h5), // output [31 : 0] result
  .rdy(rdy_h5) // output rdy
);


suma_float your_instance_name (
  .a(h3), // input [31 : 0] a
  .b(h5), // input [31 : 0] b
  .operation_nd(rdy_h5), // input operation_nd
  .clk(clk), // input clk
  .result(h6), // output [31 : 0] result
  .rdy(rdy_h6) // output rdy
);

suma_float your_instance_name (
  .a(h6), // input [31 : 0] a
  .b(h4), // input [31 : 0] b
  .operation_nd(rdy_h6), // input operation_nd
  .clk(clk), // input clk
  .result(aux2), // output [31 : 0] result
  .rdy(rdy_aux2) // output rdy
);

///////////////////que hacer con aux2?

mayor_igual_float your_instance_name (
  .a(aux2), // input [31 : 0] a
  .b(32'b0), // input [31 : 0] b
  .operation_nd(rdy_aux2), // input operation_nd
  .clk(clk), // input clk
  .result(aux2_positivo), // output [0 : 0] result
  .rdy(rdy_comparacion2) // output rdy
);
  

always @(*)
begin
  if (aux2_positivo && rdy_comparacion2) // se deduce que modo1=aux2_positivo
  begin
    calcular_sqrt2 = 1'b1;
  end
  else 
  begin
    calcular_sqrt2 = 1'b0;
  end
end

  // raiz de aux
  sqrt_float your_instance_name (
  .a(aux2), // input [31 : 0] a
  .operation_nd(calcular_sqrt2), // input operation_nd
  .clk(clk), // input clk
  .result(sqrt2), // output [31 : 0] result
  .invalid_op(invalid_op2), // output invalid_op
  .rdy(rdy_sqrt2) // output rdy
);

Divide_float your_instance_name (
  .a(tau2_modo1), // input [31 : 0] a
  .b(dos), // input [31 : 0] b
  .operation_nd(rdy_tau2_modo1), // input operation_nd
  .clk(clk), // input clk
  .result(tau2_modo1_dos), // output [31 : 0] result
  .rdy(rdy_tau2_modo1_dos) // output rdy
);

resta_float your_instance_name (
  .a(tau2_modo1_dos), // input [31 : 0] a
  .b(sqrt2), // input [31 : 0] b
  .operation_nd(rdy_sqrt2), // input operation_nd
  .clk(clk), // input clk
  .result(phi_modo1), // output [31 : 0] result
  .rdy(rdy_phi_modo1) // output rdy
);


////////////////////// RE ADAPTAR


multiply_float calculo_Vdc2p (
  .a(tau1_modo2a), // input [31 : 0] a
  .b(escalado), // input [31 : 0] b
  .operation_nd(rdy_tau1_modo2a), // input operation_nd
  .clk(clk), // input clk
  .result(tau1_modo2a_esc), // 
  .rdy(rdy_tau1_modo2a_esc) // output rdy
);






multiply_float calculo_Vdc2p (
  .a(tau2_modo2a), // input [31 : 0] a
  .b(escalado), // input [31 : 0] b
  .operation_nd(rdy_tau2_modo2a), // input operation_nd
  .clk(clk), // input clk
  .result(tau2_modo2a_esc), // 
  .rdy(rdy_tau2_modo2a_esc) // output rdy
);

multiply_float calculo_Vdc2p (
  .a(tau2_modo2b), // input [31 : 0] a
  .b(escalado), // input [31 : 0] b
  .operation_nd(rdy_tau2_modo2b), // input operation_nd
  .clk(clk), // input clk
  .result(tau2_modo2b_esc), // 
  .rdy(rdy_tau2_modo2b_esc) // output rdy
);

multiply_float calculo_Vdc2p (
  .a(tau2_modo1), // input [31 : 0] a
  .b(escalado), // input [31 : 0] b
  .operation_nd(rdy_tau2_modo1), // input operation_nd
  .clk(clk), // input clk
  .result(tau2_modo1_esc), // 
  .rdy(rdy_tau2_modo1_esc) // output rdy
);










multiply_float calculo_Vdc2p (
  .a(phi_modo2a), // input [31 : 0] sd
  .b(escalado), // input [31 : 0] b
  .operation_nd(rdy_phi_modo2a), // input operation_nd
  .clk(clk), // input clk
  .result(phi_modo2a_esc), // 
  .rdy(rdy_phi_modo2a_esc) // output rdy
);

multiply_float calculo_Vdc2p (
  .a(phi_modo2b), // input [31 : 0] sd
  .b(escalado), // input [31 : 0] b
  .operation_nd(rdy_phi_modo2b), // input operation_nd
  .clk(clk), // input clk
  .result(phi_modo2b_esc), // 
  .rdy(rdy_phi_modo2b_esc) // output rdy
);

multiply_float calculo_Vdc2p (
  .a(phi_modo1), // input [31 : 0] sd
  .b(escalado), // input [31 : 0] b
  .operation_nd(rdy_phi_modo1), // input operation_nd
  .clk(clk), // input clk
  .result(phi_modo1_esc), // 
  .rdy(rdy_phi_modo1_esc) // output rdy
);


/////////



endmodule
  