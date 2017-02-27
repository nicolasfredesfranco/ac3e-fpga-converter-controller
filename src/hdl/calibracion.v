`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:35:13 02/24/2017 
// Design Name: 
// Module Name:    calibracion 
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
module calibracion(clk, CE, Iref, Vdc1, Vdc2, Gan_I, Gan_V1, Gan_V2, Offset_I, Offset_V1, Offset_V2, Iref_adap, Vdc1_adap, Vdc2_adap);
    
    input clk;
    input CE;
    input [11:0] Iref;
    input [11:0] Vdc1, Vdc2;
    input signed [12:0] Gan_I, Gan_V1, Gan_V2;
    input signed [37:0] Offset_I, Offset_V1, Offset_V2;
    output reg signed [bits_enteros:-bits_decimal] Iref_adap, Vdc1_adap, Vdc2_adap;

    localparam bits_enteros = 20;
    localparam bits_decimal = 17;

    wire signed [37:0] Vdc1_largo, Vdc2_largo, Iref_largo;

    assign  Iref_largo = {21'b0,Iref,5'b0};
    assign  Vdc1_largo = {21'b0,Vdc1,5'b0};
    assign  Vdc2_largo = {21'b0,Vdc2,5'b0};


    reg signed [49:0] Iref_inter, Iref_inter_next, Vdc1_inter, Vdc1_inter_next, Vdc2_inter, Vdc2_inter_next;
    reg signed [37:0] Vdc1_inter_chico, Vdc2_inter_chico, Iref_inter_chico;

    always @(*)
    begin
        Iref_inter_next = Gan_I*Iref_largo ;
        Vdc1_inter_next = Gan_V1*Vdc1_largo;
        Vdc2_inter_next = Gan_V2*Vdc2_largo;
        Iref_adap = Iref_inter_chico +  Offset_I;    
        Vdc1_adap = Vdc1_inter_chico +  Offset_V1;  
        Vdc2_adap = Vdc2_inter_chico +  Offset_V2;
    end
    


    always @(*)
    begin
        Iref_inter_chico = Iref_inter[37:0];
        Vdc1_inter_chico = Vdc1_inter[37:0];
        Vdc2_inter_chico = Vdc2_inter[37:0];
    end

    always @(posedge clk)
    begin
        if(CE)
        begin
            Iref_inter <= Iref_inter_next;                
            Vdc1_inter <= Vdc1_inter_next;        
            Vdc2_inter <= Vdc2_inter_next;
        end
        else
        begin
            Iref_inter <= Iref_inter;                
            Vdc1_inter <= Vdc1_inter;        
            Vdc2_inter <= Vdc2_inter;
        end    
    end     
endmodule
