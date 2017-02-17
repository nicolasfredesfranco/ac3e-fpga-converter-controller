`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.02.2017 12:48:57
// Design Name: 
// Module Name: controlador2
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


module controlador2(clk, CE, rst, sync, trigger, Vdc1, Vdc2, Iref, fs_DAB, tau1, tau2, phi, modo);
    input clk;
    input CE;
    input rst;
    input sync;
    input trigger;
    input signed [bits_enteros:-bits_decimal] Vdc1, Vdc2, Iref;
    input signed [18:0] fs_DAB;
    output reg signed [8:0] tau1, tau2, phi;
    output reg [1:0] modo;
    //localparam fs_DAB = 19'd100000; // en HZ


    reg [3:0] state1, state2, state3, state1_next, state2_next, state3_next;
    reg [7:0] contador1, contador1_next;

    reg [3:0] state1_last;

    always @(posedge clk)
      state1_last <= state1;


    initial
    begin
        tau1=9'd255;
        tau2=9'd147;
        phi=-9'd9;
        state1_next= INIT;
        state2_next= INIT;
        state3_next= INIT;
    end


    localparam bits_enteros = 20;
    localparam bits_decimal = 17;
    localparam razon_vueltas = 38'd720896; // (n1/n2)
    localparam razon_vueltas_inv = 38'd23831; // (n2/n1)
    localparam f1 = 38'd4332; // ((n2/n1)^2 /4) * Isc^2
    localparam uno = 38'd131072;
    localparam cuatro_piL = 38'd41; //4*pi*L
    localparam c1 = 38'd48; //c1 =  2 pi * L * (Ipc + Isc*n2/n1)
    localparam pi = 38'd411774; //pi 
    localparam c2 = 38'd82; //c2=  4pi*L*Ipc
    localparam dos_pi2L = 38'd64; //2 pi^2 * L
    localparam pi_medio = 38'd205887; //pi/2
    localparam escalado = 38'd10638985; // 255/pi
    localparam dos = 38'd262144;// 2 
    localparam Ipc = 38'd262144;// 2
    localparam Isc = 38'd262144;// 2

    

/////


    localparam INIT    = 4'd0;
    localparam estado1 = 4'd1;
    localparam estado2 = 4'd2;
    localparam estado3 = 4'd3;
    localparam estado4 = 4'd4;
    localparam estado5 = 4'd5;
    localparam estado6 = 4'd6;
    localparam estado7 = 4'd7;
    localparam estado8 = 4'd8;
    localparam estado9 = 4'd9;
    localparam estado10 = 4'd10;
    localparam estado_espera = 4'd11;



//////////tiempo de espera para los calculos, ANALIZAR QUE VALORES PONER EN FUNCION DE LA COMPLEJIDAD DE LAS OPERACIONES

    localparam paso1 = 8'd10;
    localparam paso2 = 8'd20;
    localparam paso3 = 8'd30;
    localparam paso4 = 8'd40;
    localparam paso5 = 8'd50;
    localparam paso6 = 8'd60;
    localparam paso7 = 8'd80;
    localparam paso8 = 8'd90;
    localparam paso9 = 8'd100;



///////////////////////////////////////////////////////////////// CAJAS PARA CALCULOS (sacar raiz)

wire signed [bits_enteros:-bits_decimal] fs_DAB_fixed;

assign  fs_DAB_fixed = {{2{fs_DAB[18]}},fs_DAB,17'b0};


////////////////////////////////


wire calcular_sqrt2, rdy_aux2_float, rdy_sqrt2_float, rdy_sqrt2_corto, invalid_op_sqrt2;
wire [31:0] aux2_float, sqrt2_float;
wire [37 : 0] sqrt2_corto;
reg signed [bits_enteros:-bits_decimal] sqrt2_next;



    reg signed [2*bits_enteros:-2*bits_decimal] Vdc2p, n4, d_inv, n3, n6, n9, n5, n11, n8;
    reg signed [2*bits_enteros:-2*bits_decimal] Vdc2p_next, n4_next, d_inv_next, n3_next, n6_next, n9_next, n5_next, n11_next, n8_next;

    reg signed [bits_enteros:-bits_decimal] n0, resta, uno_d_inv, d, f4, aux1, n12, n7, n13, h4, n10;
    reg signed [bits_enteros:-bits_decimal] n0_next, resta_next, uno_d_inv_next, d_next, f4_next, aux1_next, n12_next, n7_next, n13_next, h4_next, n10_next;

    reg signed [bits_enteros:-bits_decimal] Vdc2p_chico, n4_chico, d_inv_chico, n3_chico, n6_chico, n9_chico, n5_chico, n11_chico, n8_chico, tau1_modo2a_final, tau2_modo2a_final, phi_modo2a_final;

    reg signed [2*bits_enteros:-2*bits_decimal] tau1_modo2a, tau2_modo2a, tau1_modo2a_next, tau2_modo2a_next;

    reg signed [bits_enteros:-bits_decimal] phi_modo2a, phi_modo2a_next;

      reg signed [bits_enteros:-bits_decimal] tau2_modo2b, tau2_modo2b_next, phi_modo2b, phi_modo2b_next;

       reg signed [bits_enteros:-bits_decimal] tau2_modo1, tau2_modo1_next, phi_modo1, phi_modo1_next;

    reg signed [2*bits_enteros:-2*bits_decimal] k1, k4, k6, k7, k8;
    reg signed [2*bits_enteros:-2*bits_decimal] k1_next, k4_next, k6_next, k7_next, k8_next;

    reg signed [bits_enteros:-bits_decimal] k5, k3, k9, k10, aux2, k11;
    reg signed [bits_enteros:-bits_decimal] k5_next, k3_next, k9_next, k10_next, aux2_next, k11_next;

    reg signed [bits_enteros:-bits_decimal] k1_chico, k4_chico, k6_chico, k7_chico, k8_chico;


///////////////////////////


fixed_to_float caja1 (
  .a(aux2_next), // input [37 : 0] a
  .operation_nd(calcular_sqrt2), // input operation_nd
  .clk(clk), // input clk
  .ce(CE), // input ce
  .result(aux2_float), // output [31 : 0] result
  .rdy(rdy_aux2_float) // output rdy
);


sqrt_in_float caja2 (
  .a(aux2_float), // input [31 : 0] a
  .operation_nd(rdy_aux2_float), // input operation_nd
  .clk(clk), // input clk
  .ce(CE), // input ce
  .result(sqrt2_float), // output [31 : 0] result
  .invalid_op(invalid_op_sqrt2), // output invalid_op
  .rdy(rdy_sqrt2_float) // output rdy
);


float_to_fixed caja3 (
  .a(sqrt2_float), // input [31 : 0] a
  .operation_nd(rdy_sqrt2_float), // input operation_nd
  .clk(clk), // input clk
  .ce(CE), // input ce
  .result(sqrt2_corto), // // output [37 : 0] result
  .rdy(rdy_sqrt2_corto) // output rdy
);


// JAIME ESTUVO AQUI

  reg [bits_enteros:-bits_decimal] a;
  reg [bits_enteros:-bits_decimal] b;

  wire [(75-(2*bits_decimal))-1:-(2*bits_decimal)] p;

mul_fsm1_1 multip_fsm1 (
  .clk(clk), // input clk
  .a(a), // input [37 : 0] a
  .b(b), // input [37 : 0] b
  .p(p) // output [75 : 0] p
);

  reg [bits_enteros:-bits_decimal] a1;
  reg [bits_enteros:-bits_decimal] b1;

  wire [(75-(2*bits_decimal))-1:-(2*bits_decimal)] p1;

mul_fsm1_1 multip_fsm1_2 (
  .clk(clk), // input clk
  .a(a1), // input [37 : 0] a
  .b(b1), // input [37 : 0] b
  .p(p1) // output [75 : 0] p
);


  reg [bits_enteros:-bits_decimal] a_fsm2;
  reg [bits_enteros:-bits_decimal] b_fsm2;

  wire [(75-(2*bits_decimal))-1:-(2*bits_decimal)] p_fsm2;

mul_fsm1_1 multip_fsm2 (
  .clk(clk), // input clk
  .a(a_fsm2), // input [37 : 0] a
  .b(b_fsm2), // input [37 : 0] b
  .p(p_fsm2) // output [75 : 0] p
);


  reg [bits_enteros:-bits_decimal] a_fsm3;
  reg [bits_enteros:-bits_decimal] b_fsm3;

  wire [(75-(2*bits_decimal))-1:-(2*bits_decimal)] p_fsm3;

mul_fsm1_1 multip_fsm3 (
  .clk(clk), // input clk
  .a(a_fsm3), // input [37 : 0] a
  .b(b_fsm3), // input [37 : 0] b
  .p(p_fsm3) // output [75 : 0] p
);


assign  calcular_sqrt2 = (state3_next==estado7)? 1'b1 : 1'b0;


always @(posedge clk)
begin
    if (rdy_sqrt2_corto) 
    begin
        sqrt2_next <= sqrt2_corto; 
    end
    else
    begin
        sqrt2_next <= sqrt2_next ;
    end
end

wire aux2_positivo;
assign aux2_positivo = ~(aux2_next[20]);



//////
    

    wire calcular_sqrt1, rdy_aux1_float, rdy_sqrt1_float, rdy_sqrt1_corto, invalid_op_sqrt1;
    wire [31:0] aux1_float, sqrt1_float;
    wire [37 : 0] sqrt1_corto;
    reg signed [bits_enteros:-bits_decimal] sqrt1_next;


fixed_to_float caja4 (
  .a(aux1_next), // input [37 : 0] a
  .operation_nd(calcular_sqrt1), // input operation_nd
  .clk(clk), // input clk
  .ce(CE), // input ce
  .result(aux1_float), // output [31 : 0] result
  .rdy(rdy_aux1_float) // output rdy
);


sqrt_in_float caja5 (
  .a(aux1_float), // input [31 : 0] a
  .operation_nd(rdy_aux1_float), // input operation_nd
  .clk(clk), // input clk
  .ce(CE), // input ce
  .result(sqrt1_float), // output [31 : 0] result
  .invalid_op(invalid_op_sqrt1), // output invalid_op
  .rdy(rdy_sqrt1_float) // output rdy
);


float_to_fixed caja6 (
  .a(sqrt1_float), // input [31 : 0] a
  .operation_nd(rdy_sqrt1_float), // input operation_nd
  .clk(clk), // input clk
  .ce(CE), // input ce
  .result(sqrt1_corto), // output [37 : 0] result
  .rdy(rdy_sqrt1_corto) // output rdy
);

assign  calcular_sqrt1 = (state1_next==estado7)? 1'b1 : 1'b0;



always @(posedge clk)
begin
    if (rdy_sqrt1_corto) 
    begin
        sqrt1_next <= sqrt1_corto;    
    end
    else
    begin
        sqrt1_next <= sqrt1_next ;
    end
end

wire aux1_positivo;
assign aux1_positivo = ~(aux1_next[20]);


/////////////////////////////////// ///////////////////////////// cajas para dividir


 
    reg signed [bits_enteros:-bits_decimal] divisor, dividendo, divisor_next, dividendo_next;

    wire [31 : 0] divisor_float, dividendo_float, division_float;
    wire  rdy_divisor_float, rdy_dividendo_float, rdy_division_float, rdy_division;

    wire signed [bits_enteros:-bits_decimal] division;

    wire divide;
    assign divide = (rdy_divisor_float && rdy_dividendo_float);



fixed_to_float caja7 (
  .a(divisor_next), // input [37 : 0] a
  .operation_nd(1'b1), // input operation_nd
  .clk(clk), // input clk
  .ce(CE), // input ce
  .result(divisor_float), // output [31 : 0] result
  .rdy(rdy_divisor_float) // output rdy
);

fixed_to_float caja8 (
  .a(dividendo_next), // input [37 : 0] a
  .operation_nd(1'b1), // input operation_nd
  .clk(clk), // input clk
  .ce(CE), // input ce
  .result(dividendo_float), // output [31 : 0] result
  .rdy(rdy_dividendo_float) // output rdy
);



div_in_float caja9 (
  .a(dividendo_float), // input [31 : 0] a
  .b(divisor_float), // input [31 : 0] b
  .operation_nd(divide), // input operation_nd
  .clk(clk), // input clk
  .ce(CE), // input ce
  .result(division_float), // output [31 : 0] result
  .rdy(rdy_division_float) // output rdy
);




float_to_fixed caja10 (
  .a(division_float), // input [31 : 0] a
  .operation_nd(rdy_division_float), // input operation_nd
  .clk(clk), // input clk
  .ce(CE), // input ce
  .result(division), // output [37 : 0] result
  .rdy(rdy_division) // output rdy
);



/////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////machine state 1   asociada al modo 2a


////
    always@(*)// maquina de estados para el voltaje V2
    begin
    a = 0;
    b = 0;
        case(state1_next)
        INIT:    begin 
                        state1 = (sync)? estado1 : INIT;//ojo con la comparacion
                        contador1 = 8'd0;


                        Vdc2p     =   Vdc2p_next; 
                        n0        =   n0_next;
                        resta     =   resta_next; 
                        n4        =   n4_next;
                        d_inv     =   d_inv_next; 
                        n3        =   n3_next;
                        n6        =   n6_next;
                        n9        =   n9_next;
                        uno_d_inv =   uno_d_inv_next;
                        n5        =   n5_next;
                        d         =   d_next;
                        f4        =   f4_next;
                        n11       =   n11_next;
                        aux1      =   aux1_next; 
                        n12       =   n12_next; 
                        n7        =   n7_next;   
                        n8        =   n8_next; 
                        n13       =   n13_next; 
                        h4        =   h4_next; 
                        n10       =   n10_next;

                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor = divisor_next;
                        dividendo = dividendo_next;
                    end
        estado1:    begin
                        state1 = (contador1_next >= paso1)? estado2 :estado1;
                        contador1 = contador1_next + 8'd1;

                        Vdc2p     =   Vdc2*razon_vueltas; 
                        n0        =   division;
                        resta     =   resta_next; 
                        n4        =   n4_next;
                        d_inv     =   d_inv_next; 
                        n3        =   n3_next;
                        n6        =   n6_next;
                        n9        =   n9_next;
                        uno_d_inv =   uno_d_inv_next;
                        n5        =   n5_next;
                        d         =   d_next;
                        f4        =   f4_next;
                        n11       =   n11_next;
                        aux1      =   aux1_next; 
                        n12       =   n12_next; 
                        n7        =   n7_next;   
                        n8        =   n8_next; 
                        n13       =   n13_next; 
                        h4        =   h4_next; 
                        n10       =   n10_next; 

                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor = Vdc2;
                        dividendo = Vdc1;
                    end
        estado2:    begin
                        state1 = (contador1_next >= paso2)? estado3 :estado2;
                        contador1 = contador1_next + 8'd1;

                        Vdc2p     =   Vdc2p_next; 
                        n0        =   n0_next;
                        resta     =   Vdc2p_next - Vdc1; 
                        n4        =   n2_chico*n0_next;
                        d_inv     =   n0_next*razon_vueltas_inv; 
                        n3        =   n3_next;
                        n6        =   n6_next;
                        n9        =   n9_next;
                        uno_d_inv =   uno_d_inv_next;
                        n5        =   n5_next;
                        d         =   d_next;
                        f4        =   f4_next;
                        n11       =   n11_next;
                        aux1      =   aux1_next; 
                        n12       =   n12_next; 
                        n7        =   n7_next;   
                        n8        =   n8_next; 
                        n13       =   n13_next; 
                        h4        =   h4_next; 
                        n10       =   n10_next; 

                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor = Vdc2p_chico;
                        dividendo = k4_chico;              
                    end  
        estado3:    begin
                        state1 = (contador1_next >= paso3)? estado4 :estado3;
                        contador1 = contador1_next + 8'd1;

                        Vdc2p     =   Vdc2p_next; 
                        n0        =   n0_next;
                        resta     =   resta_next; 
                        n4        =   n4_next;
                        d_inv     =   d_inv_next; 
                        //n3        =   resta*n1_chico; // GOTCHA
                        a         =   resta;
                        b         =   n1_chico;
                        n3        =   p[bits_enteros:-bits_decimal];
                        n6        =   cuatro_piL*fs_DAB_fixed;
                        n9        =   c1*fs_DAB_fixed;
                        uno_d_inv =   uno - d_inv_chico;
                        n5        =   n5_next;
                        d         =   d_next;
                        f4        =   f4_next;
                        n11       =   n11_next;
                        aux1      =   aux1_next; 
                        n12       =   n12_next; 
                        n7        =   n7_next;   
                        n8        =   n8_next; 
                        n13       =   n13_next; 
                        h4        =   h4_next; 
                        n10       =   n10_next; 

                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor = Vdc2p_chico;
                        dividendo = k3_next;
                        
                    end        
        estado4:    begin
                        state1 = (contador1_next >= paso4)? estado5 :estado4; 
                        contador1 = contador1_next + 8'd1;

                        Vdc2p     =   Vdc2p_next; 
                        n0        =   n0_next;
                        resta     =   resta_next; 
                        n4        =   n4_next;
                        d_inv     =   d_inv_next; 
                        n3        =   n3_next;
                        n6        =   n6_next;
                        n9        =   n9_next;
                        uno_d_inv =   uno_d_inv_next;
                        //n5        =   n3_chico*n4_chico; // GOTCHA
                        a         =   n3_chico;
                        b         =   n4_chico;
                        n5        =   p[bits_enteros:-bits_decimal];
                        d         =   d_next;
                        f4        =   f4_next;
                        n11       =   n11_next;
                        aux1      =   aux1_next; 
                        n12       =   n12_next; 
                        n7        =   n7_next;   
                        n8        =   n8_next; 
                        n13       =   n13_next; 
                        h4        =   h4_next; 
                        n10       =   n10_next; 

                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor = Vdc1;
                        dividendo = Vdc2p_chico;
                        
                    end    
        estado5:    begin
                        state1 = (contador1_next >= paso5)? estado6 :estado5; 
                        contador1 = contador1_next + 8'd1;

                        Vdc2p     =   Vdc2p_next; 
                        n0        =   n0_next;
                        resta     =   resta_next; 
                        n4        =   n4_next;
                        d_inv     =   d_inv_next; 
                        n3        =   n3_next;
                        n6        =   n6_next;
                        n9        =   n9_next;
                        uno_d_inv =   uno_d_inv_next;
                        n5        =   n5_next;
                        d         =   d_next;
                        f4        =   division;
                        n11       =   Ipc*uno_d_inv_next;
                        aux1      =   aux1_next; 
                        n12       =   n12_next; 
                        n7        =   n7_next;   
                        n8        =   n8_next; 
                        n13       =   n13_next; 
                        h4        =   h4_next; 
                        n10       =   n10_next; 

                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor = k1_chico;
                        dividendo = n5_chico;
                        
                    end    
        estado6:    begin
                        state1 = (contador1_next >= paso6)? ((aux1_positivo)? estado7 : estado_espera) : estado6 ;
                        contador1 = contador1_next + 8'd1;

                        Vdc2p     =   Vdc2p_next; 
                        n0        =   n0_next;
                        resta     =   resta_next; 
                        n4        =   n4_next;
                        d_inv     =   d_inv_next; 
                        n3        =   n3_next;
                        n6        =   n6_next;
                        n9        =   n9_next;
                        uno_d_inv =   uno_d_inv_next;
                        n5        =   n5_next;
                        d         =   d_next;
                        f4        =   f4_next;
                        n11       =   n11_next;
                        aux1      =   f1 + f4_next; 
                        n12       =   n11_chico + razon_vueltas_inv; 
                        n7        =   n7_next;   
                        n8        =   n8_next; 
                        n13       =   n13_next; 
                        h4        =   h4_next; 
                        n10       =   n10_next; 

                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor = g6_chico;
                        dividendo = g8_chico;
                        
                    end 
        estado7:    begin
                        state1 = (contador1_next >= paso7)? estado8 :estado7;
                        contador1 = contador1_next + 8'd1;

                        Vdc2p     =   Vdc2p_next; 
                        n0        =   n0_next;
                        resta     =   resta_next; 
                        n4        =   n4_next;
                        d_inv     =   d_inv_next; 
                        n3        =   n3_next;
                        n6        =   n6_next;
                        n9        =   n9_next;
                        uno_d_inv =   uno_d_inv_next;
                        n5        =   n5_next;
                        d         =   d_next;
                        f4        =   f4_next;
                        n11       =   n11_next;
                        aux1      =   aux1_next; 
                        n12       =   n12_next; 
                        n7        =   division;   
                        n8        =   n8_next; 
                        n13       =   n13_next; 
                        h4        =   h4_next; 
                        n10       =   n10_next; 

                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor = resta;
                        dividendo = n6_chico;
                        
                    end    
        estado8:    begin
                        state1 = (contador1_next >= paso8)? estado9 :estado8;
                        contador1 = contador1_next + 8'd1;

                        Vdc2p     =   Vdc2p_next; 
                        n0        =   n0_next;
                        resta     =   resta_next; 
                        n4        =   n4_next;
                        d_inv     =   d_inv_next; 
                        n3        =   n3_next;
                        n6        =   n6_next;
                        n9        =   n9_next;
                        uno_d_inv =   uno_d_inv_next;
                        n5        =   n5_next;
                        d         =   d_next;
                        f4        =   f4_next;
                        n11       =   n11_next;
                        aux1      =   aux1_next; 
                        n12       =   n12_next; 
                        n7        =   n7_next;   
                        //n8        =   d_next*n7_next; // GOTCHA
                        a         =   d_next;
                        b         =   n7_next;
                        n8        =   p[bits_enteros:-bits_decimal];
                        n13       =   sqrt1_next + n12_next; 
                        h4        =   razon_vueltas_inv + sqrt1_next; 
                        n10       =   division; 

                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor = Vdc1;
                        dividendo = n9_chico;
                    end    
        
        estado9:    begin
                        state1 = (contador1_next >= paso9)? estado10 :estado9;
                        contador1 = contador1_next + 8'd1;

                        Vdc2p     =   Vdc2p_next; 
                        n0        =   n0_next;
                        resta     =   resta_next; 
                        n4        =   n4_next;
                        d_inv     =   d_inv_next; 
                        n3        =   n3_next;
                        n6        =   n6_next;
                        n9        =   n9_next;
                        uno_d_inv =   uno_d_inv_next;
                        n5        =   n5_next;
                        d         =   d_next;
                        f4        =   f4_next;
                        n11       =   n11_next;
                        aux1      =   aux1_next; 
                        n12       =   n12_next; 
                        n7        =   n7_next;   
                        n8        =   n8_next; 
                        n13       =   n13_next; 
                        h4        =   h4_next; 
                        n10       =   n10_next; 
                        // EL JAIME ESTUVO AQUI
                        //tau1_modo2a = n7_next* n13_next; // GOTCHA
                        a         =   n7_next;
                        b         =   n13_next;
                        tau1_modo2a =   p[bits_enteros:-bits_decimal];

                        //tau2_modo2a = n7_next*h4_next; // GOTCHA
                        a1 = n7_next;
                        b1 = h4_next;
                        tau2_modo2a = p1[bits_enteros:-bits_decimal];
                        phi_modo2a = 38'd0 - n10_next;

                        divisor = divisor_next;
                        dividendo = dividendo_next;
                        
                    end    
        
        estado10:   begin
                        state1 = estado1;
                        contador1 = 8'd0;

                        Vdc2p     =   Vdc2p_next; 
                        n0        =   n0_next;
                        resta     =   resta_next; 
                        n4        =   n4_next;
                        d_inv     =   d_inv_next; 
                        n3        =   n3_next;
                        n6        =   n6_next;
                        n9        =   n9_next;
                        uno_d_inv =   uno_d_inv_next;
                        n5        =   n5_next;
                        d         =   d_next;
                        f4        =   f4_next;
                        n11       =   n11_next;
                        aux1      =   aux1_next; 
                        n12       =   n12_next; 
                        n7        =   n7_next;   
                        n8        =   n8_next; 
                        n13       =   n13_next; 
                        h4        =   h4_next; 
                        n10       =   n10_next; 

                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor = divisor_next;
                        dividendo = dividendo_next;
                    end    
        estado_espera:    begin
                        state1 = (contador1_next >= paso9)? estado10 :estado_espera;
                        contador1 = contador1_next + 8'd1;

                        Vdc2p     =   Vdc2p_next; 
                        n0        =   n0_next;
                        resta     =   resta_next; 
                        n4        =   n4_next;
                        d_inv     =   d_inv_next; 
                        n3        =   n3_next;
                        n6        =   n6_next;
                        n9        =   n9_next;
                        uno_d_inv =   uno_d_inv_next;
                        n5        =   n5_next;
                        d         =   d_next;
                        f4        =   f4_next;
                        n11       =   n11_next;
                        aux1      =   aux1_next; 
                        n12       =   n12_next; 
                        n7        =   n7_next;   
                        n8        =   n8_next; 
                        n13       =   n13_next; 
                        h4        =   h4_next; 
                        n10       =   n10_next; 

                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor = divisor_next;
                        dividendo = dividendo_next;
                        
                    end    

        default:    begin
                        state1 = estado1;
                        contador1 = 8'd0;

                        Vdc2p     =   Vdc2p_next; 
                        n0        =   n0_next;
                        resta     =   resta_next; 
                        n4        =   n4_next;
                        d_inv     =   d_inv_next; 
                        n3        =   n3_next;
                        n6        =   n6_next;
                        n9        =   n9_next;
                        uno_d_inv =   uno_d_inv_next;
                        n5        =   n5_next;
                        d         =   d_next;
                        f4        =   f4_next;
                        n11       =   n11_next;
                        aux1      =   aux1_next; 
                        n12       =   n12_next; 
                        n7        =   n7_next;   
                        n8        =   n8_next; 
                        n13       =   n13_next; 
                        h4        =   h4_next; 
                        n10       =   n10_next; 

                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor = divisor_next;
                        dividendo = dividendo_next;
                        
                    end
        endcase
  end
    

    always @(posedge clk or posedge rst)
    begin
        if (rst)                                              ///arreglar lo que se hace aqui 
        begin
            state1_next <= estado1; 
            contador1_next <= 8'd0; 


            Vdc2p_next  <=  Vdc2p_next;  
            n0_next     <=  n0_next; 
            resta_next  <=  resta_next;  
            n4_next     <=  n4_next; 
            d_inv_next  <=  d_inv_next;  
            n3_next     <=  n3_next; 
            n6_next     <=  n6_next; 
            n9_next     <=  n9_next; 
            uno_d_inv_next  <=  uno_d_inv_next; 
            n5_next     <=  n5_next; 
            d_next      <=  d_next; 
            f4_next     <=  f4_next; 
            n11_next    <=  n11_next; 
            aux1_next   <=  aux1_next;  
            n12_next    <=  n12_next;  
            n7_next     <=  n7_next;    
            n8_next     <=  n8_next;  
            n13_next    <=  n13_next;  
            h4_next     <=  h4_next;  
            n10_next    <=  n10_next;  

            tau1_modo2a_next <= tau1_modo2a_next;
            tau2_modo2a_next <= tau2_modo2a_next;
            phi_modo2a_next <= phi_modo2a_next;

            divisor_next <= divisor_next;
            dividendo_next <= dividendo_next;
        end
        else if (CE)
        begin
            state1_next <= state1; 
            contador1_next <= contador1; 

            Vdc2p_next  <=  Vdc2p;  
            n0_next     <=  n0; 
            resta_next  <=  resta;  
            n4_next     <=  n4; 
            d_inv_next  <=  d_inv;  
            n3_next     <=  n3; 
            n6_next     <=  n6; 
            n9_next     <=  n9; 
            uno_d_inv_next  <=  uno_d_inv; 
            n5_next     <=  n5; 
            d_next      <=  d; 
            f4_next     <=  f4; 
            n11_next    <=  n11; 
            aux1_next   <=  aux1;  
            n12_next    <=  n12;  
            n7_next     <=  n7;    
            n8_next     <=  n8;  
            n13_next    <=  n13;  
            h4_next     <=  h4;  
            n10_next    <=  n10; 

            tau1_modo2a_next <= tau1_modo2a;
            tau2_modo2a_next <= tau2_modo2a;
            phi_modo2a_next <= phi_modo2a;

            divisor_next <= divisor;
            dividendo_next <= dividendo;
        end
        else
        begin
            state1_next <= state1_next; 
            contador1_next <= contador1_next; 

            Vdc2p_next  <=  Vdc2p_next;  
            n0_next     <=  n0_next; 
            resta_next  <=  resta_next;  
            n4_next     <=  n4_next; 
            d_inv_next  <=  d_inv_next;  
            n3_next     <=  n3_next; 
            n6_next     <=  n6_next; 
            n9_next     <=  n9_next; 
            uno_d_inv_next  <=  uno_d_inv_next; 
            n5_next     <=  n5_next; 
            d_next      <=  d_next; 
            f4_next     <=  f4_next; 
            n11_next    <=  n11_next; 
            aux1_next   <=  aux1_next;  
            n12_next    <=  n12_next;  
            n7_next     <=  n7_next;    
            n8_next     <=  n8_next;  
            n13_next    <=  n13_next;  
            h4_next     <=  h4_next;  
            n10_next    <=  n10_next;  

            tau1_modo2a_next <= tau1_modo2a_next;
            tau2_modo2a_next <= tau2_modo2a_next;
            phi_modo2a_next <= phi_modo2a_next;

            divisor_next <= divisor_next;
            dividendo_next <= dividendo_next;
        end
    end


    always @(*)
    begin
        Vdc2p_chico = Vdc2p_next[bits_enteros:-bits_decimal];
        n4_chico = n4_next[bits_enteros:-bits_decimal];
        d_inv_chico = d_inv_next[bits_enteros:-bits_decimal];
        n3_chico = n3_next[bits_enteros:-bits_decimal];
        n6_chico = n6_next[bits_enteros:-bits_decimal];
        n9_chico = n9_next[bits_enteros:-bits_decimal];
        n5_chico = n5_next[bits_enteros:-bits_decimal];
        n11_chico = n11_next[bits_enteros:-bits_decimal];
        n8_chico = n8_next[bits_enteros:-bits_decimal];
        tau1_modo2a_final = tau1_modo2a_next[bits_enteros:-bits_decimal];
        tau2_modo2a_final = tau2_modo2a_next[bits_enteros:-bits_decimal];
        phi_modo2a_final  = phi_modo2a_next[bits_enteros:-bits_decimal];
    end



///////////////////////////////////////////////////////////////////////machine state 2      asociada al modo 2b 



    reg signed [2*bits_enteros:-2*bits_decimal] k2, n2, n1, g8, g6;
    reg signed [2*bits_enteros:-2*bits_decimal] k2_next, n2_next, n1_next, g8_next, g6_next;

    reg signed [bits_enteros:-bits_decimal] g5, g10, g9;
    reg signed [bits_enteros:-bits_decimal] g5_next, g10_next, g9_next;

    reg signed [bits_enteros:-bits_decimal] k2_chico, n2_chico, n1_chico, g8_chico, g6_chico;




    always@(*)// maquina de estados para el voltaje V2
    begin
    a_fsm2 = 0;
    b_fsm2 = 0;
        case(state2_next)
        INIT:    begin 
                        state2 = (sync)? estado1 : INIT;//ojo con la comparacion

                        k2  = k2_next; 
                        n2  = n2_next; 
                        n1  = n1_next; 
                        g8  = g8_next; 
                        g6  = g6_next; 
                        g5  = g5_next; 
                        g10 = g10_next;
                        g9  = g9_next; 
                        
                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;
                    end
        estado1:    begin
                        state2 = (contador1_next >= paso1)? estado2 :estado1;

                        k2  = pi*Vdc1; 
                        n2  = pi*Ipc; 
                        n1  = Iref*razon_vueltas_inv; 
                        g8  = g8_next; 
                        g6  = g6_next; 
                        g5  = g5_next; 
                        g10 = g10_next;
                        g9  = g9_next; 


                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;
                    end
        estado2:    begin
                        state2 = (contador1_next >= paso2)? estado3 :estado2;

                        k2  = k2_next; 
                        n2  = n2_next; 
                        n1  = n1_next; 
                        //g8  = Iref*k4_chico; // GOTCHA
                        a_fsm2 = Iref;
                        b_fsm2 = k4_chico;
                        g8 = p_fsm2[bits_enteros:-bits_decimal];
                        g6  = g6_next; 
                        g5  = g5_next; 
                        g10 = g10_next;
                        g9  = g9_next; 

                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;             
                    end  
        estado3:    begin
                        state2 = (contador1_next >= paso3)? estado4 :estado3;

                        k2  = k2_next; 
                        n2  = n2_next; 
                        n1  = n1_next; 
                        g8  = g8_next; 
                        g6  = g6_next; 
                        g5  = g5_next; 
                        g10 = g10_next;
                        g9  = g9_next; 
                        
                        tau2_modo2b = division;
                        phi_modo2b = phi_modo2b_next;
                        
                    end        
        estado4:    begin
                        state2 = (contador1_next >= paso4)? estado5 :estado4; 

                        k2  = k2_next; 
                        n2  = n2_next; 
                        n1  = n1_next; 
                        g8  = g8_next; 
                        //g6  = tau2_modo2b_next*Vdc2p_chico; // GOTCHA
                        a_fsm2 = tau2_modo2b_next;
                        b_fsm2 = Vdc2p_chico;
                        g6 = p_fsm2[bits_enteros:-bits_decimal];
                        g5  = (tau2_modo2b_next>>1); 
                        g10 = g10_next;
                        g9  = g9_next; 
                        
                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;
                        
                    end    
        estado5:    begin
                        state2 = (contador1_next >= paso5)? estado6 :estado5; 

                        k2  = k2_next; 
                        n2  = n2_next; 
                        n1  = n1_next; 
                        g8  = g8_next; 
                        g6  = g6_next; 
                        g5  = g5_next; 
                        g10 = g5_next - pi_medio;
                        g9  = g9_next; 
                        
                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;
                        
                    end    
        estado6:    begin
                        state2 = (contador1_next >= paso6)? estado7 : estado6 ;

                        k2  = k2_next; 
                        n2  = n2_next; 
                        n1  = n1_next; 
                        g8  = g8_next; 
                        g6  = g6_next; 
                        g5  = g5_next; 
                        g10 = g10_next;
                        g9  = division; 
                        
                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;
                        
                    end 
        estado7:    begin
                        state2 = (contador1_next >= paso7)? estado_espera :estado7;

                        k2  = k2_next; 
                        n2  = n2_next; 
                        n1  = n1_next; 
                        g8  = g8_next; 
                        g6  = g6_next; 
                        g5  = g5_next; 
                        g10 = g10_next;
                        g9  = g9_next; 
                        
                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = g9_next + g10_next;
                        
                    end      
        estado10:   begin
                        state2 = estado1;

                        k2  = k2_next; 
                        n2  = n2_next; 
                        n1  = n1_next; 
                        g8  = g8_next; 
                        g6  = g6_next; 
                        g5  = g5_next; 
                        g10 = g10_next;
                        g9  = g9_next; 
                        
                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;
                    end    
        estado_espera:    begin
                        state2 = (contador1_next >= paso9)? estado10 :estado_espera;

                        k2  = k2_next; 
                        n2  = n2_next; 
                        n1  = n1_next; 
                        g8  = g8_next; 
                        g6  = g6_next; 
                        g5  = g5_next; 
                        g10 = g10_next;
                        g9  = g9_next; 
                        
                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;
                        
                    end    
        default:    begin
                        state2 = estado1;

                        k2  = k2_next; 
                        n2  = n2_next; 
                        n1  = n1_next; 
                        g8  = g8_next; 
                        g6  = g6_next; 
                        g5  = g5_next; 
                        g10 = g10_next;
                        g9  = g9_next; 
                        
                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;
                        
                    end
        endcase
    end



    always @(posedge clk or posedge rst)
    begin
        if (rst)                                              ///arreglar lo que se hace aqui 
        begin
            state2_next <= estado1;


            k2_next  <= k2_next  ;
            n2_next  <= n2_next  ;
            n1_next  <= n1_next  ;
            g8_next  <= g8_next  ;
            g6_next  <= g6_next  ;
            g5_next  <= g5_next  ;
            g10_next <= g10_next ;
            g9_next  <= g9_next  ;


            tau2_modo2b_next <= tau2_modo2b_next;
            phi_modo2b_next <= phi_modo2b_next;
        end
        else if (CE)
        begin
            state2_next <= state2;

            k2_next  <= k2  ;
            n2_next  <= n2  ;
            n1_next  <= n1  ;
            g8_next  <= g8  ;
            g6_next  <= g6  ;
            g5_next  <= g5  ;
            g10_next <= g10 ;
            g9_next  <= g9  ;

            tau2_modo2b_next <= tau2_modo2b;
            phi_modo2b_next <= phi_modo2b;
  
        end
        else
        begin
            state2_next <= state2_next;


            k2_next  <= k2_next  ;
            n2_next  <= n2_next  ;
            n1_next  <= n1_next  ;
            g8_next  <= g8_next  ;
            g6_next  <= g6_next  ;
            g5_next  <= g5_next  ;
            g10_next <= g10_next ;
            g9_next  <= g9_next  ;

            tau2_modo2b_next <= tau2_modo2b_next;
            phi_modo2b_next <= phi_modo2b_next; 
        end
    end


    always @(*)
    begin
        k2_chico = k2_next[bits_enteros:-bits_decimal];
        n2_chico = n2_next[bits_enteros:-bits_decimal]; 
        n1_chico = n1_next[bits_enteros:-bits_decimal]; 
        g8_chico = g8_next[bits_enteros:-bits_decimal]; 
        g6_chico = g6_next[bits_enteros:-bits_decimal];
    end







///////////////////////////////////////////////////////////////////////machine state 3      asociada al modo 1



    always@(*)// maquina de estados para el voltaje V2
    begin
    a_fsm3 = 0;
    b_fsm3 = 0;
    case(state3_next)
        INIT:    begin 
                        state3 = (sync)? estado1 : INIT;//ojo con la comparacion

                        k1   = k1_next;  
                        k4   = k4_next;  
                        k5   = k5_next;  
                        k3   = k3_next;  
                        k6   = k6_next;  
                        k7   = k7_next;  
                        k8   = k8_next;  
                        k9   = k9_next;  
                        k10  = k10_next;  
                        aux2 = aux2_next;  
                        k11  = k11_next;  

                        tau2_modo1 = tau2_modo1_next;
                        phi_modo1 = phi_modo1_next;

                    end
        estado1:    begin
                        state3 = (contador1_next >= paso1)? estado2 :estado1;

                        k1   = c2*fs_DAB_fixed;  
                        k4   = dos_pi2L*fs_DAB_fixed;  
                        k5   = k5_next;  
                        k3   = k3_next;  
                        k6   = k6_next;  
                        k7   = k7_next;  
                        k8   = k8_next;  
                        k9   = k9_next;  
                        k10  = k10_next;  
                        aux2 = aux2_next;  
                        k11  = k11_next;  


                        tau2_modo1 = tau2_modo1_next;
                        phi_modo1 = phi_modo1_next;

                    end
        estado2:    begin
                        state3 = (contador1_next >= paso2)? estado3 :estado2;

                        k1   = k1_next;  
                        k4   = k4_next;  
                        k5   = division;  
                        k3   = k2_chico - k1_chico;  
                        k6   = k6_next;  
                        k7   = k7_next;  
                        k8   = k8_next;  
                        k9   = k9_next;  
                        k10  = k10_next;  
                        aux2 = aux2_next;  
                        k11  = k11_next;  

                        tau2_modo1 = tau2_modo1_next;
                        phi_modo1 = phi_modo1_next;
             
                    end  
        estado3:    begin
                        state3 = (contador1_next >= paso3)? estado4 :estado3;

                        k1   = k1_next;  
                        k4   = k4_next;  
                        k5   = k5_next;  
                        k3   = k3_next;  
                        //k6   = k5_next*Iref;  // GOTCHA
                        a_fsm3 = k5_next;
                        b_fsm3 = Iref;
                        k6   = p_fsm3[bits_enteros:-bits_decimal];
                        k7   = k7_next;  
                        k8   = k8_next;  
                        k9   = k9_next;  
                        k10  = k10_next;  
                        aux2 = aux2_next;  
                        k11  = k11_next;  


                        tau2_modo1 = division;
                        phi_modo1 = phi_modo1_next; 
                    end        
        estado4:    begin
                        state3 = (contador1_next >= paso4)? estado5 :estado4; 

                        k1   = k1_next;  
                        k4   = k4_next;  
                        k5   = k5_next;  
                        k3   = k3_next;  
                        k6   = k6_next;  
                        k7   = pi_medio*tau2_modo1_next;  
                        //k8   = tau2_modo1_next*tau2_modo1_next;  // GOTCHA
                        a_fsm3 = tau2_modo1_next;
                        b_fsm3 = tau2_modo1_next;
                        k8 = p_fsm3[bits_enteros:-bits_decimal];
                        k9   = k9_next;  
                        k10  = k10_next;  
                        aux2 = aux2_next;  
                        k11  = k11_next;  


                        tau2_modo1 = tau2_modo1_next;
                        phi_modo1 = phi_modo1_next;
                    end    
        estado5:    begin
                        state3 = (contador1_next >= paso5)? estado6 :estado5; 

                        k1   = k1_next;  
                        k4   = k4_next;  
                        k5   = k5_next;  
                        k3   = k3_next;  
                        k6   = k6_next;  
                        k7   = k7_next;  
                        k8   = k8_next;  
                        k9   = k7_chico - k6_chico;  
                        k10  = (k8_chico>>2);  
                        aux2 = aux2_next;  
                        k11  = k11_next;  


                        tau2_modo1 = tau2_modo1_next;
                        phi_modo1 = phi_modo1_next;
                        
                    end    
        estado6:    begin
                        state3 = (contador1_next >= paso6)? ((aux1_positivo)? estado7 : estado_espera) : estado6 ;

                        k1   = k1_next;  
                        k4   = k4_next;  
                        k5   = k5_next;  
                        k3   = k3_next;  
                        k6   = k6_next;  
                        k7   = k7_next;  
                        k8   = k8_next;  
                        k9   = k9_next;  
                        k10  = k10_next;  
                        aux2 = k9_next - k10_next;  
                        k11  = k11_next;  


                        tau2_modo1 = tau2_modo1_next;
                        phi_modo1 = phi_modo1_next;

                    end 
        estado7:    begin
                        state3 = (contador1_next >= paso7)? estado8 :estado7;

                        k1   = k1_next;  
                        k4   = k4_next;  
                        k5   = k5_next;  
                        k3   = k3_next;  
                        k6   = k6_next;  
                        k7   = k7_next;  
                        k8   = k8_next;  
                        k9   = k9_next;  
                        k10  = k10_next;  
                        aux2 = aux2_next;  
                        k11  = (tau2_modo1_next>>1);  


                        tau2_modo1 = tau2_modo1_next;
                        phi_modo1 = phi_modo1_next;

                    end    
        estado8:    begin
                        state3 = (contador1_next >= paso8)? estado9 :estado8;

                        k1   = k1_next;  
                        k4   = k4_next;  
                        k5   = k5_next;  
                        k3   = k3_next;  
                        k6   = k6_next;  
                        k7   = k7_next;  
                        k8   = k8_next;  
                        k9   = k9_next;  
                        k10  = k10_next;  
                        aux2 = aux2_next;  
                        k11  = k11_next;  


                        tau2_modo1 = tau2_modo1_next;
                        phi_modo1 = k11_next - sqrt2_next;

                    end    
        
        estado9:    begin
                        state3 = (contador1_next >= paso9)? estado10 :estado9;

                        k1   = k1_next;  
                        k4   = k4_next;  
                        k5   = k5_next;  
                        k3   = k3_next;  
                        k6   = k6_next;  
                        k7   = k7_next;  
                        k8   = k8_next;  
                        k9   = k9_next;  
                        k10  = k10_next;  
                        aux2 = aux2_next;  
                        k11  = k11_next;  

                        tau2_modo1 = tau2_modo1_next;
                        phi_modo1 = phi_modo1_next;
                        
                    end    
        
        estado10:   begin
                        state3 = estado1;

                        k1   = k1_next;  
                        k4   = k4_next;  
                        k5   = k5_next;  
                        k3   = k3_next;  
                        k6   = k6_next;  
                        k7   = k7_next;  
                        k8   = k8_next;  
                        k9   = k9_next;  
                        k10  = k10_next;  
                        aux2 = aux2_next;  
                        k11  = k11_next;  

                        tau2_modo1 = tau2_modo1_next;
                        phi_modo1 = phi_modo1_next;

                    end    
        estado_espera:    begin
                        state3 = (contador1_next >= paso9)? estado10 :estado_espera;

                        k1   = k1_next;  
                        k4   = k4_next;  
                        k5   = k5_next;  
                        k3   = k3_next;  
                        k6   = k6_next;  
                        k7   = k7_next;  
                        k8   = k8_next;  
                        k9   = k9_next;  
                        k10  = k10_next;  
                        aux2 = aux2_next;  
                        k11  = k11_next;  

                        tau2_modo1 = tau2_modo1_next;
                        phi_modo1 = phi_modo1_next;
                        
                    end    

        default:    begin
                        state3 = estado1;

                        k1   = k1_next;  
                        k4   = k4_next;  
                        k5   = k5_next;  
                        k3   = k3_next;  
                        k6   = k6_next;  
                        k7   = k7_next;  
                        k8   = k8_next;  
                        k9   = k9_next;  
                        k10  = k10_next;  
                        aux2 = aux2_next;  
                        k11  = k11_next;  

                        tau2_modo1 = tau2_modo1_next;
                        phi_modo1 = phi_modo1_next;
                        
                    end
        endcase
  end
  

    always @(posedge clk or posedge rst)
    begin
        if (rst)                                              ///arreglar lo que se hace aqui 
        begin
            state3_next <= estado1;

            k1_next   <= k1_next  ;
            k4_next   <= k4_next  ;
            k5_next   <= k5_next  ;
            k3_next   <= k3_next  ;
            k6_next   <= k6_next  ;
            k7_next   <= k7_next  ;
            k8_next   <= k8_next  ;
            k9_next   <= k9_next  ;
            k10_next  <= k10_next ; 
            aux2_next <= aux2_next;  
            k11_next  <= k11_next ;

            tau2_modo1_next <= tau2_modo1_next;
            phi_modo1_next <= phi_modo1_next;

        end
        else if (CE)
        begin
            state3_next <= state3;

            k1_next   <= k1  ;
            k4_next   <= k4  ;
            k5_next   <= k5  ;
            k3_next   <= k3  ;
            k6_next   <= k6  ;
            k7_next   <= k7  ;
            k8_next   <= k8  ;
            k9_next   <= k9  ;
            k10_next  <= k10 ; 
            aux2_next <= aux2;  
            k11_next  <= k11 ;

            tau2_modo1_next <= tau2_modo1;
            phi_modo1_next <= phi_modo1;
 
        end
        else
        begin
            state3_next <= state3_next;

            k1_next   <= k1_next  ;
            k4_next   <= k4_next  ;
            k5_next   <= k5_next  ;
            k3_next   <= k3_next  ;
            k6_next   <= k6_next  ;
            k7_next   <= k7_next  ;
            k8_next   <= k8_next  ;
            k9_next   <= k9_next  ;
            k10_next  <= k10_next ; 
            aux2_next <= aux2_next;  
            k11_next  <= k11_next ;

            tau2_modo1_next <= tau2_modo1_next;
            phi_modo1_next <= phi_modo1_next;

        end
    end


    always @(*)
    begin
        k1_chico = k1_next[bits_enteros:-bits_decimal]; 
        k4_chico = k4_next[bits_enteros:-bits_decimal]; 
        k6_chico = k6_next[bits_enteros:-bits_decimal]; 
        k7_chico = k7_next[bits_enteros:-bits_decimal]; 
        k8_chico = k8_next[bits_enteros:-bits_decimal];
    end

 


//////////////////////////////////////////////////////////////////////////////






always @(*)
begin
    flag1 = phi_modo2b_next - tau2_modo2b_next + pi;
    flag2 = tau2_modo1_next - phi_modo1_next;
end

reg signed [bits_enteros:-bits_decimal] flag1, flag2;

reg signed [8:0] tau1_modo2a_adaptado, tau2_modo2a_adaptado, phi_modo2a_adaptado, tau2_modo2b_adaptado, phi_modo2b_adaptado, tau2_modo1_adaptado, phi_modo1_adaptado;
reg signed [2*bits_enteros:-2*bits_decimal] tau1_modo2a_inter, tau2_modo2a_inter, phi_modo2a_inter, tau2_modo2b_inter, phi_modo2b_inter, tau2_modo1_inter, phi_modo1_inter;

always @(*)
begin
    tau1_modo2a_inter = escalado*tau1_modo2a_final;
    tau2_modo2a_inter = escalado*tau2_modo2a_final;
    phi_modo2a_inter = escalado*phi_modo2a_final;
    tau2_modo2b_inter = escalado*tau2_modo2b_next;
    phi_modo2b_inter = escalado*phi_modo2b_next;
    tau2_modo1_inter = escalado*tau2_modo1_next;
    phi_modo1_inter = escalado*phi_modo1_next; 
end



always @(*)
begin
    tau1_modo2a_adaptado = {tau1_modo2a_inter[20],tau1_modo2a_inter[7:0]};
    tau2_modo2a_adaptado = {tau2_modo2a_inter[20],tau2_modo2a_inter[7:0]};
    phi_modo2a_adaptado = {phi_modo2a_inter[20],phi_modo2a_inter[7:0]};
    tau2_modo2b_adaptado = {tau2_modo2b_inter[20],tau2_modo2b_inter[7:0]};
    phi_modo2b_adaptado = {phi_modo2b_inter[20],phi_modo2b_inter[7:0]};
    tau2_modo1_adaptado = {tau2_modo1_inter[20],tau2_modo1_inter[7:0]};
    phi_modo1_adaptado = {phi_modo1_inter[20],phi_modo1_inter[7:0]};
end


always @(posedge trigger or posedge rst)
begin
  if  (rst)
  begin
    tau1 <= 9'd255;
    tau2 <= 9'd147;
    phi  <= -9'd9;
    modo <= 2'd0;   
  end
  else if (CE)
  begin
    if (aux1_positivo && (tau1_modo2a_final < pi)) //preguntar a miguel porque restringe a que sea menor a pi 
    begin
        tau1 <= tau1_modo2a_adaptado;   
        tau2 <= tau2_modo2a_adaptado;
        phi <= phi_modo2a_adaptado;
        modo <= 2'd0;   
    end
    else if ((phi_modo2b_next[20]) && (~flag1[20])) 
    begin 
        tau1 <= 9'd255;   
        tau2 <= tau2_modo2b_adaptado;
        phi <= phi_modo2b_adaptado;
        modo <= 2'd1;
    end
    else if (aux2_positivo && (~phi_modo1_next[20]) && (~flag2[20])) // es necesario agregar flag 2, ver referencia en verde
    begin
        tau1 <= 9'd255;   
        tau2 <= tau2_modo1_adaptado;
        phi <= phi_modo1_adaptado;
        modo <= 2'd2;   
    end
    else
    begin
        tau1 <= tau1;   
        tau2 <= tau2;
        phi <= phi;
        modo <= 2'd3;   
    end
  end 
  else
  begin
    tau1 <= tau1;   
    tau2 <= tau2;
    phi <= phi;
    modo <= 2'd3;      
  end 
end






endmodule
