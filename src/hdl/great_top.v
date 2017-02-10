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


module great_top(clk, sync, Vdc1, Vdc2, Iref, Sp, Ss, trigger);
    input clk;
    input sync;
    input signed [13:0] Vdc1, Vdc2, Iref;
    output [3:0] Sp; //Conmutaciones del primario (Sp1,Sp2,Sp3,Sp4)
    output [3:0] Ss; //Conmutaciones del secundario  (Ss1,Ss2,Ss3,Ss4)
    output trigger;
    output [1:0] modo; //se puede dejar como wire al aire 

    //wire [1:0] modo;

    wire signed [8:0] tau1, tau2, phi;

    localparam fs_DAB = 19'd100000;
    localparam deadtime = 8'd20;

    main actuador(clk, tau1, tau2, phi, fs_DAB, deadtime, sync, Sp, Ss, trigger);


    controlador calculador(clk , trigger, Vdc1, Vdc2, Iref, fs_DAB, tau1, tau2, phi, modo);






endmodule
