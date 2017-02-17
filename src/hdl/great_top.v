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
// 
//////////////////////////////////////////////////////////////////////////////////


module great_top(clk, CE, rst, sync, Vdc1, Vdc2, Iref, Sp1, Sp2, Sp3, Sp4, Ss1, Ss2, Ss3, Ss4, trigger, modo);
    input clk;
    input CE;
    input rst;
    input sync;
    input signed [bits_enteros:-bits_decimal] Vdc1, Vdc2, Iref;
    output trigger;
    output Sp1, Sp2, Sp3, Sp4, Ss1, Ss2, Ss3, Ss4;
    output [1:0] modo; //se puede dejar como wire al aire 



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

    //wire [1:0] modo;

    wire signed [8:0] tau1, tau2, phi;

    localparam fs_DAB = 19'd100000; // en HZ
    localparam deadtime = 8'd20;    // en cuentas de clk
    localparam fs_clk = 28'd100_000_000; // en Hz	

    main actuador(clk, CE, rst, fs_clk, tau1, tau2, phi, fs_DAB, deadtime, sync, Sp, Ss, trigger);

    controlador2 calculador(clk, CE, rst, sync, trigger, Vdc1, Vdc2, Iref, /*fs_DAB,*/ tau1, tau2, phi, modo);

endmodule
