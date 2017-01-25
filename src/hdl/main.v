`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:53:16 01/25/2017 
// Design Name: 
// Module Name:    main 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 

// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module main(clk/*, rst*/, t1, t2, phi, fs_DAB, sync, deadtime, Sp, Ss, trigger); //<3
    input clk; // implementar rst de emergencia  
    input signed [8:0] t1, t2; //se entregan valores entre 0 y 255 (el signo es para operar con phi)
    input signed [8:0] phi; //se entrega entre -255 y 255
    input signed [18:0] fs_DAB;// esta en Hz y va de 0 a 150000
    input sync; //signal de disparo 
    input [7:0] deadtime;
    output [3:0] Sp; //Conmutaciones del primario (Sp1,Sp2,Sp3,Sp4)
    output [3:0] Ss; //Conmutaciones del secundario  (Ss1,Ss2,Ss3,Ss4)
    output trigger;
    

    reg signed [8:0] t1_sinc, t2_sinc; //se entregan valores entre 0 y 255 (el signo es para operar con phi)
    reg signed [8:0] phi_sinc; //se entrega entre -255 y 255
    reg signed [18:0] fs_DAB_sinc;// esta en Hz y va de 0 a 150000
    reg sync_sinc; //signal de disparo 
    reg [7:0] deadtime_sinc;

    wire signed [1:0] V1, V2;

    always @(posedge clk) 
    begin
    	t1_sinc <= t1;
    	t2_sinc <= t2;
    	phi_sinc <= phi;
    	fs_DAB_sinc <= fs_DAB;
    	sync_sinc <= sync;
    	deadtime_sinc <= deadtime;
    end


    voltajes signals(clk/*, rst*/, t1_sinc, t2_sinc, phi_sinc, fs_DAB_sinc, sync_sinc, V1, V2, trigger);

    switch patrones(clk, deadtime_sinc, V1, V2, Sp, Ss);



endmodule
