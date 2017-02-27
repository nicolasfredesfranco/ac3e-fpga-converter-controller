`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.02.2017 10:23:51
// Design Name: 
// Module Name: great_top
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

    //OCUPAR RATIO DSP EN 80 !
// 
//////////////////////////////////////////////////////////////////////////////////


module great_top(clk, /*CE,*/ rst, sync, Vdc1, Vdc2, Iref, Sp1, Sp2, Sp3, Sp4, Ss1, Ss2, Ss3, Ss4, trigger, modo);
    input clk;
    //input CE;
    input rst;
    input sync;
    input [11:0] Iref;
    input [11:0] Vdc1, Vdc2; 
    //input signed [bits_enteros:-bits_decimal] Vdc1, Vdc2, Iref;
    output trigger;
    output Sp1, Sp2, Sp3, Sp4, Ss1, Ss2, Ss3, Ss4;
    output [1:0] modo; //se puede dejar como wire al aire 


    wire CE;
    assign CE = 1'b1;

    ///////////////////////////// SE PERILLA LA ADAPTACION    

    localparam Gan_I     =  13'd40 ;      //LAS GANANCIAS DEBEN TENER 13 BITS
    localparam Gan_V1    =  13'd400;
    localparam Gan_V2    =  13'd120;
    localparam Offset_I  = -38'd2621440 ; // es -20 en punto fijo      //LOS OFFSET DEBEN TENER 38 BITS 
    localparam Offset_V1 =  38'd0  ;   //Debe estar en punto fijo
    localparam Offset_V2 =  38'd0  ;    //Debe estar en punto fijo

    wire signed [bits_enteros:-bits_decimal] Iref_adap, Vdc1_adap, Vdc2_adap;

    calibracion adaptacion(clk, CE, Iref, Vdc1, Vdc2, Gan_I, Gan_V1, Gan_V2, Offset_I, Offset_V1, Offset_V2, Iref_adap, Vdc1_adap, Vdc2_adap);

    //////////////////////////////////////////



    localparam bits_enteros = 20;
    localparam bits_decimal = 17;

    wire [3:0] Sp; //Conmutaciones del primario (Sp1,Sp2,Sp3,Sp4)
    wire [3:0] Ss; //Conmutaciones del secundario  (Ss1,Ss2,Ss3,Ss4)

	assign Sp1 = Sp[3];
	assign Sp2 = Sp[2];
	assign Sp3 = Sp[1];
	assign Sp4 = Sp[0];   

	assign Ss1 = Ss[3];
	assign Ss2 = Ss[2];
	assign Ss3 = Ss[1];
	assign Ss4 = Ss[0];

    

    wire signed [8:0] tau1, tau2, phi;

    localparam fs_DAB = 19'd100000; // en HZ
    localparam deadtime = 8'd20;    // en cuentas de clk
    localparam fs_clk = 28'd100_000_000; // en Hz
    localparam razon_clk = 12'd1000;// (fs_clk/fs_DAB)	
    localparam escalado = 38'd10638985; // 255/pi
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
    localparam dos = 38'd262144;// 2 
    localparam Ipc = 38'd262144;// 2
    localparam Isc = 38'd262144;// 2

    main actuador(clk, CE, rst, fs_clk, razon_clk, tau1, tau2, phi, fs_DAB, deadtime, sync, Sp, Ss, trigger);

    controlador2 calculador(uno, razon_vueltas,razon_vueltas_inv, f1, cuatro_piL, c1, pi, c2, dos_pi2L, pi_medio, Ipc, Isc, dos, clk, CE, rst, sync, trigger, Vdc1_adap, Vdc2_adap, Iref_adap, fs_DAB, escalado, tau1, tau2, phi, modo);

endmodule
