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


    initial
    begin
        tau1=9'd255;
        tau2=9'd147;
        phi=-9'd9;
    end

    localparam bits_enteros = 32;
    localparam bits_decimal = 32;
    localparam L = 65'd107374; //L in fixed point
    localparam razon_vueltas = 65'd23622320128; // (n1/n2)
    localparam razon_vueltas_inv = 65'd780903144; // (n2/n1)
    localparam f1 = 65'd141982389; // ((n2/n1)^2 /4) * Isc^2
    localparam f2 = 65'd42949672960000; // (1/(4L))
    localparam uno = 65'd4294967296;
    localparam cuatro_piL = 65'd1349303; //4*pi*L
    localparam c1 = 65'd1594631; //c1 =  2 pi * L * (Ipc + Isc*n2/n1)
    localparam pi = 65'd13493037704; //pi 
    localparam c2 = 65'd2698607; //c2=  4pi*L*Ipc
    localparam dos_pi2L = 65'd2119481; //2 pi^2 * L
    localparam pi_medio = 65'd6746518852; //pi/2
    localparam escalado = 65'd348618290543; // 255/pi
    localparam dos = 65'd8589934592;// 2 

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


    reg [3:0] state1, state2, state3, state1_next, state2_next, state3_next;
    

    wire signed [2*bits_enteros:-2*bits_decimal] Vdc2p_grande;  

    assign Vdc2p_grande = Vdc2*razon_vueltas;
    assign Vdc2p = Vdc2p_grande[bits_enteros:-bits_decimal];

divisor your_instance_name (
  .aclk(clk), // input aclk
  .aclken(CE), // input aclken
  .s_axis_divisor_tvalid(s_axis_divisor_tvalid), // input s_axis_divisor_tvalid
  .s_axis_divisor_tdata(s_axis_divisor_tdata), // input [63 : 0] s_axis_divisor_tdata
  .s_axis_dividend_tvalid(s_axis_dividend_tvalid), // input s_axis_dividend_tvalid
  .s_axis_dividend_tdata(s_axis_dividend_tdata), // input [63 : 0] s_axis_dividend_tdata
  .m_axis_dout_tvalid(m_axis_dout_tvalid), // output m_axis_dout_tvalid
  .m_axis_dout_tdata(m_axis_dout_tdata) // output [95 : 0] m_axis_dout_tdata
);

    always@(*)// maquina de estados para el voltaje V2
        case(state1)
        INIT:    begin 
                        state1_next = (sync)? estado1 : INIT;//ojo con la comparacion
                        contador1_next=8'd0;
                        
                    end
        estado1:    begin
                        state1_next = (contador1>= paso1)? estado2 :estado1;
                        contador1_next=8'd0;
                        Sp=4'b0101;
                    end
        estado2:    begin
                        state1_next = (V1==2'd0)? estado_n1_0 :((V1==2'd1)?estado_n1_1 : estado_Vn1);
                        contador1_next=8'd0;
                        Sp=4'b1001;
                    end  
        estado_1_0:    begin
                        state1_next = (contador1==deadtime)?estado_V0:estado_1_0;
                        contador1_next=contador1+8'd1;
                        Sp=4'b0100;
                    end        
        estado_0_1:    begin
                        state1_next = (contador1==deadtime)?estado_V1:estado_0_1;
                        contador1_next=contador1+8'd1;
                        Sp=4'b0100;
                    end    
        estado_0_n1:    begin
                        state1_next = (contador1==deadtime)?estado_Vn1:estado_0_n1;
                        contador1_next=contador1+8'd1;
                        Sp=4'b0001;
                    end    
        estado_n1_0:    begin
                        state1_next = (contador1==deadtime)?estado_V0:estado_n1_0;
                        contador1_next=contador1+8'd1;
                        Sp=4'b0001;
                    end 
        estado_n1_1:    begin
                        state1_next = (contador1==deadtime)?estado_V1:estado_n1_1;
                        contador1_next=contador1+8'd1;
                        Sp=4'b0000;
                    end    
        estado_1_n1:    begin
                        state1_next = (contador1==deadtime)?estado_Vn1:estado_1_n1;
                        contador1_next=contador1+8'd1;
                        Sp=4'b0000;
                    end    
        default:    begin
                        state1_next = estado_V0;
                        contador1_next=8'd0;
                        Sp=4'b0000;
                    end
        endcase
    







/////

///////////////areglar esto


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
    if (aux1_positivo && (tau1_modo2a_final < 9'd255)) //preguntar a miguel porque restringe a que sea menor a pi 
    begin
        tau1 <= tau1_modo2a_final;   
        tau2 <= tau2_modo2a_final;
        phi <= phi_modo2a_final;
        modo <= 2'd0;   
    end
    else if ((phi_modo2b_final[8]) && (flag1)) 
    begin 
        tau1 <= 9'd255;   
        tau2 <= tau2_modo2b_final;
        phi <= phi_modo2b_final;
        modo <= 2'd1;
    end
    else if (aux2_positivo && (~phi_modo1_final[8]) && (flag2)) // es necesario agregar flag 2, ver referencia en verde
    begin
        tau1 <= 9'd255;   
        tau2 <= tau2_modo1_final;
        phi <= phi_modo1_final;
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
