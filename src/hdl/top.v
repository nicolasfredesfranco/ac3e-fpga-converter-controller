`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AC3E
// Engineer: Nicolas I. Fredes Franco
// 
// Create Date:    09:02:00 01/23/2017 
// Design Name:    converter_controller
// Module Name:    top
// Project Name:   converter_controller
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
module top(clk, rst, t1, t2, phi, fs_DAB, sync, Sp, Ss); //<3
    input clk, rst; 
    input signed [8:0] t1, t2; //se entregan valores entre 0 y 255 (el signo es para operar con phi)
    input signed [8:0] phi; //desfase entre senales, cuantos bit debe tener ? 8 po men
    input [17:0] fs_DAB;// esta en Hz
    input sync; //signal de disparo 
    output [3:0] Sp; //Conmutaciones del primario
    output [3:0] Ss; //Conmutaciones del secundario
    
    //parameter deadtime=8'd0; //ver que escala usar  

    localparam INIT = 3'd0;
    localparam estado1 = 3'd1;
    localparam estado2 = 3'd2;
    localparam estado3 = 3'd3;
    localparam estado4 = 3'd4;

    //wire [4:0] hours; 


    reg [2:0] state=INIT;
    reg [9:0] contador1, contador2, contador1_next, contador2_next; 

    reg []; 



    always@(*) //concatenacion de jaime para poder dividir (complemento a2)
    begin // 196_078 consutar referencia en verde
        link1_1=({{9{t1[8]}},t1}*196078)/fs_DAB;// OJO quizas la division genera problema de timing
    end

    


    always@(*)// maquina de estados para el voltaje V1
        case(state1)
        INIT:       state1_next = (sync)?estado1:INIT;
        estado1:    state1_next = (contador1==link1_1)?estado2:estado1;// los valores de los link 
        estado2:    state1_next = (contador1==link1_2)?estado3:estado2;// estan dados por las transiciones
        estado3:    state1_next = (contador1==link1_3)?estado4:estado3;// entre los estados
        estado4:    state1_next = (contador1==link1_4)?estado1:estado4;
        default:    state1_next=INIT;
        endcase


    always@(*)// maquina de estados para el voltaje V2
        case(state2)
        INIT:       state2_next = (sync)?estado1:INIT;
        estado1:    state2_next = (contador2==link2_1)?estado2:estado1;// los valores de los link 
        estado2:    state2_next = (contador2==link2_2)?estado3:estado2;// estan dados por las transiciones
        estado3:    state2_next = (contador2==link2_3)?estado4:estado3;// entre los estados
        estado4:    state2_next = (contador2==link2_4)?estado1:estado4;
        default:    state2_next=INIT;
        endcase



    always@(*)
    begin
        if(state1==INIT)
            contador1=10'd0;
        else 
        begin
            contador1=(contador1_next>512)? 10'd0 : contador1_next+10'd1;//IMPORTANTE: arrreglar valor en el que se resetea
        end
    end


    always@(*)
    begin
        if(state2==INIT)
            contador2=10'd0;
        else 
        begin
            contador2=(contador1_next>512)? 10'd0 : contador2_next+10'd1;//IMPORTANTE: arrreglar valor en el que se resetea
        end
    end


    always@(posedge clk)//conmutacion de las maquinas de estados
    begin
        state1 <= state1_next;
        state2 <= state2_next;
    end



    always@(posedge clk) //Cuenta para patrones
    begin
        contador1_next <= contador1;
        contador2_next <= contador2;
    end


endmodule
