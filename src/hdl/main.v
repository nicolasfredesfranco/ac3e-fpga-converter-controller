`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AC3E
// Engineer: Nicolas I. Fredes Franco
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
//                      -IMPORTANTE, el valor maximo para phi es tau2-tau1+pi radianes, si se la mete mas que eso se satura en el mismo valor.
//                      -El valor minimo de fs_DAB es 500 y el maximo 250_000
//                      -Valor minimo de deadtime es 1
//                      -Ojo con la saturacion de valores negativos
//////////////////////////////////////////////////////////////////////////////////
module main(clk, CE, rst, fs_clk, razon_clk, t1, t2, phi, fs_DAB, deadtime, sync, Sp, Ss, trigger); //<3
    input clk; // implementar rst de emergencia
    input CE;
    input rst;
    input signed [27:0] fs_clk;  
    input signed [11:0] razon_clk;
    input signed [8:0] t1, t2; //se entregan valores entre 0 y 255 (el signo es para operar con phi)
    input signed [8:0] phi; //se entrega entre -255 y 255
    input signed [18:0] fs_DAB;// esta en Hz y va de 0 a 150000 
    input [7:0] deadtime;
    input sync; //signal de disparo

    //input switch; //borrar despues

    output [3:0] Sp; //Conmutaciones del primario (Sp1,Sp2,Sp3,Sp4)
    output [3:0] Ss; //Conmutaciones del secundario  (Ss1,Ss2,Ss3,Ss4)
    output trigger;
    

/*
    initial
    begin
        t1_sinc=9'd255;
        t2_sinc=9'd147;
        phi_sinc=-9'd9;
    end
*/
  
    /*reg signed [8:0] t1_sinc, t2_sinc; //se entregan valores entre 0 y 255 (el signo es para operar con phi)
    reg signed [8:0] phi_sinc; //se entrega entre -255 y 255
    reg signed [18:0] fs_DAB_sinc;*/ // esta en Hz y va de 0 a 150000
    //reg [27:0] fs_clk_sinc;
    //reg [11:0] razon_clk_sinc;
    //reg sync_sinc; //signal de disparo 
    //reg [7:0] deadtime_sinc;

    wire signed [1:0] V1, V2;
/*
    always @(posedge clk) 
    begin
        fs_clk_sinc <= fs_clk;
        razon_clk_sinc <= razon_clk; 
        fs_DAB_sinc <= fs_DAB;
        sync_sinc <= sync;
        deadtime_sinc <= deadtime;    
    end

*/
    ///// LIMITE DE SATURACION PARA PHI 
    /*reg signed [8:0] limite;

    always @(*)
    begin
        limite = t2 - t1 + 9'd255;
    end
    ///////////////



    always @(posedge trigger) 
    begin
        if (limite >= phi)  
        begin
            t1_sinc <= t1;// se supone que puedo hacer t1, t2 y phi, sincronico a mi trigger 
            t2_sinc <= t2;
            phi_sinc <= phi;
        end
        else 
        begin
            t1_sinc <= t1;// se supone que puedo hacer t1, t2 y phi, sincronico a mi trigger 
            t2_sinc <= t2;
            phi_sinc <= limite;             
        end
    end
 */
 
    voltajes signals(clk, CE, rst, fs_clk, razon_clk, t1, t2, phi, fs_DAB, sync, V1, V2, trigger);

    switch patrones(clk, CE, rst, deadtime-8'd1, V1, V2, Sp, Ss);



endmodule
