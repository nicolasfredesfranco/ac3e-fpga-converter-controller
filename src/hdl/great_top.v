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
    input signed [11:0] Iref; //se supondra que va de -64 a 64 ampere
    input [11:0] Vdc1, Vdc2; // se supondra que va de 0 a 1024 volts
    //input signed [bits_enteros:-bits_decimal] Vdc1, Vdc2, Iref;
    output trigger;
    output Sp1, Sp2, Sp3, Sp4, Ss1, Ss2, Ss3, Ss4;
    output [1:0] modo; //se puede dejar como wire al aire 

    ///////////////////////////// depende de como miguel me entregue los datos

    wire signed [bits_enteros:-bits_decimal] Vdc1_largo, Vdc2_largo, Iref_largo;

    assign  Iref_largo = {{14{Iref[11]}},Iref,12'b0};
    assign  Vdc1_largo = {11'b0,Vdc1,15'b0};
    assign  Vdc2_largo = {11'b0,Vdc2,15'b0};

    //////////////////////////////////////////

    //wire [1:0] modo;
    wire CE;
    assign CE = 1'b1;

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

    main actuador(clk, CE, rst, fs_clk, razon_clk, tau1, tau2, phi, fs_DAB, deadtime, sync, Sp, Ss, trigger);

    controlador2 calculador(clk, CE, rst, sync, trigger, Vdc1_largo, Vdc2_largo, Iref_largo, fs_DAB, tau1, tau2, phi, modo);

endmodule
