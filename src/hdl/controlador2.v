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
    localparam Ipc = 65'd8589934592;// 2

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
    

    reg signed [2*bits_enteros:-2*bits_decimal] Vdc2p_next, h1_next, h2_next, f4_next, h7_next, f11_next, f9_next, f5_next, tau1_modo2a_next, tau2_modo2a_next;  
    reg signed [2*bits_enteros:-2*bits_decimal] Vdc2p, h1, h2, f4, h7, f11, f9, f5, tau1_modo2a, tau2_modo2a;  
    
    reg divisor1_tvalid, dividend1_tvalid;
    wire dout_tvalid;
    wire signed [95 : 0] dout_tdata;
    wire signed [bits_enteros:-bits_decimal] dout_tdata_chico;
    reg  signed [63 : 0] divisor1_tdata, dividend1_tdata, divisor1_tdata_next, dividend1_tdata_next;

    assign dout_tdata_chico = {dout_tdata[95],dout_tdata[63:0]};
    assign  fs_DAB_fixed = {{14{fs_DAB[18]}},fs_DAB,32'b0};

divisor a1 (
  .aclk(clk), // input aclk
  .aclken(CE), // input aclken
  .s_axis_divisor_tvalid(divisor1_tvalid), // input s_axis_divisor_tvalid
  .s_axis_divisor_tdata(divisor1_tdata_next), // input [63 : 0] s_axis_divisor_tdata
  .s_axis_dividend_tvalid(dividend1_tvalid), // input s_axis_dividend_tvalid
  .s_axis_dividend_tdata(dividend1_tdata_next), // input [63 : 0] s_axis_dividend_tdata
  .m_axis_dout_tvalid(dout_tvalid), // output m_axis_dout_tvalid
  .m_axis_dout_tdata(dout_tdata) // output [95 : 0] m_axis_dout_tdata
);

    always@(*)// maquina de estados para el voltaje V2
        case(state1_next)
        INIT:    begin 
                        state1 = (sync)? estado1 : INIT;//ojo con la comparacion
                        contador1 = 8'd0;
                        Vdc2p = Vdc2p_next; 
                        d = d_next;
                        d_inv = d_inv_next;
                        h1 = h1_next;
                        h2 = h2_next;
                        uno_d_inv = uno_d_inv_next;
                        div = div_next;
                        f4 = f4_next;
                        aux1 = aux1_next;
                        resta = resta_next;
                        h3 = h3_next;
                        h7 = h7_next;
                        h4 = h4_next;
                        f11 = f11_next;
                        h8 = h8_next;
                        f9 = f9_next;
                        f5 = f5_next;
                        f8 = f8_next;
                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor1_tvalid = 1'b0;
                        divisor1_tdata = divisor1_tdata_next;
                        dividend1_tvalid = 1'b0;
                        dividend1_tdata = dividend1_tdata_next;
                    end
        estado1:    begin
                        state1 = (contador1_next >= paso1)? estado2 :estado1;
                        contador1 = contador1_next + 8'd1;
                        Vdc2p = Vdc2*razon_vueltas; 
                        d = d_next;
                        d_inv = d_inv_next;
                        h1 = h1_next;
                        h2 = h2_next;
                        uno_d_inv = uno_d_inv_next;
                        div = div_next;
                        f4 = f4_next;
                        aux1 = aux1_next;
                        resta = resta_next;
                        h3 = h3_next;
                        h7 = h7_next;
                        h4 = h4_next;
                        f11 = f11_next;
                        h8 = h8_next;
                        f9 = f9_next;
                        f5 = f5_next;
                        f8 = f8_next;
                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor1_tvalid = 1'b0;
                        divisor1_tdata = divisor1_tdata_next;
                        dividend1_tvalid = 1'b0;
                        dividend1_tdata = dividend1_tdata_next;
                    end
        estado2:    begin
                        state1 = (contador1_next >= paso2)? estado3 :estado2;
                        contador1 = contador1_next + 8'd1;
                        Vdc2p = Vdc2p_next; 
                        d = d_next;
                        d_inv = dout_tdata_chico;
                        h1 = f2*Iref;
                        h2 = h2_next;
                        uno_d_inv = uno_d_inv_next;
                        div = div_next;
                        f4 = f4_next;
                        aux1 = aux1_next;
                        resta = resta_next;
                        h3 = h3_next;
                        h7 = h7_next;
                        h4 = h4_next;
                        f11 = f11_next;
                        h8 = h8_next;
                        f9 = f9_next;
                        f5 = f5_next;
                        f8 = f8_next;
                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor1_tvalid = 1'b1;
                        divisor1_tdata = Vdc2p[32:-31];
                        dividend1_tvalid = 1'b1;
                        dividend1_tdata = Vdc1[32:-31];                 
                    end  
        estado3:    begin
                        state1 = (contador1_next >= paso3)? estado4 :estado3;
                        contador1 = contador1_next + 8'd1;
                        Vdc2p = Vdc2p_next; 
                        d = d_next;
                        d_inv = d_inv_next;
                        h1 = h1_next;
                        h2 = h1_next_chico*Vdc1;
                        uno_d_inv = uno - d_inv_next;
                        div = div_next;
                        f4 = f4_next;
                        aux1 = aux1_next;
                        resta = resta_next;
                        h3 = h3_next;
                        h7 = h7_next;
                        h4 = h4_next;
                        f11 = f11_next;
                        h8 = h8_next;
                        f9 = f9_next;
                        f5 = f5_next;
                        f8 = f8_next;
                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor1_tvalid = 1'b0;
                        divisor1_tdata = divisor1_tdata_next;
                        dividend1_tvalid = 1'b0;
                        dividend1_tdata = dividend1_tdata_next;
                        
                    end        
        estado4:    begin
                        state1 = (contador1_next >= paso4)? estado5 :estado4; 
                        contador1 = contador1_next + 8'd1;
                        Vdc2p = Vdc2p_next; 
                        d = d_next;
                        d_inv = d_inv_next;
                        h1 = h1_next;
                        h2 = h2_next;
                        uno_d_inv = uno_d_inv_next;
                        div = dout_tdata_chico;
                        f4 = f4_next;
                        aux1 = aux1_next;
                        resta = resta_next;
                        h3 = h3_next;
                        h7 = h7_next;
                        h4 = h4_next;
                        f11 = f11_next;
                        h8 = h8_next;
                        f9 = f9_next;
                        f5 = f5_next;
                        f8 = f8_next;
                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor1_tvalid = 1'b1;
                        divisor1_tdata = fs_DAB_fixed[32:-31];  //crear fs_Dab_fixed
                        dividend1_tvalid = 1'b1;
                        dividend1_tdata = uno_d_inv_next[32:-31];
                        
                    end    
        estado5:    begin
                        state1 = (contador1_next >= paso5)? estado6 :estado5; 
                        contador1 = contador1_next + 8'd1;
                        Vdc2p = Vdc2p_next; 
                        d = dout_tdata_chico;
                        d_inv = d_inv_next;
                        h1 = h1_next;
                        h2 = h2_next;
                        uno_d_inv = uno_d_inv_next;
                        div = div_next;
                        f4 = div_next*h2_next_chico;
                        aux1 = aux1_next;
                        resta = resta_next;
                        h3 = h3_next;
                        h7 = h7_next;
                        h4 = h4_next;
                        f11 = f11_next;
                        h8 = h8_next;
                        f9 = f9_next;
                        f5 = f5_next;
                        f8 = f8_next;
                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor1_tvalid = 1'b1;
                        divisor1_tdata = Vdc1[32:-31];
                        dividend1_tvalid = 1'b1;
                        dividend1_tdata = Vdc2p[32:-31];
                        
                    end    
        estado6:    begin
                        state1 = (contador1_next >= paso6)? ((~(aux1_next[64]))? estado7 : estado10) : estado6 ;
                        contador1 = contador1_next + 8'd1;
                        Vdc2p = Vdc2p_next; 
                        d = d_next;
                        d_inv = d_inv_next;
                        h1 = h1_next;
                        h2 = h2_next;
                        uno_d_inv = uno_d_inv_next;
                        div = div_next;
                        f4 = f4_next;
                        aux1 = f1+f4_next_chico;
                        resta = Vdc2p_next_chico - Vdc1;
                        h3 = h3_next;
                        h7 = h7_next;
                        h4 = h4_next;
                        f11 = f11_next;
                        h8 = h8_next;
                        f9 = f9_next;
                        f5 = f5_next;
                        f8 = f8_next;
                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor1_tvalid = 1'b0;
                        divisor1_tdata = divisor1_tdata_next;
                        dividend1_tvalid = 1'b0;
                        dividend1_tdata = dividend1_tdata_next;
                        
                    end 
        estado7:    begin
                        state1 = (contador1_next >= paso7)? estado8 :estado7;
                        contador1 = contador1_next + 8'd1;
                        Vdc2p = Vdc2p_next; 
                        d = d_next;
                        d_inv = d_inv_next;
                        h1 = h1_next;
                        h2 = h2_next;
                        uno_d_inv = uno_d_inv_next;
                        div = div_next;
                        f4 = f4_next;
                        aux1 = aux1_next;
                        resta = resta_next;
                        h3 = dout_tdata_chico;
                        h7 = cuatro_piL*d_next;
                        h4 = razon_vueltas + sqrt1;
                        f11 = -fs_DAB_fixed*c1;
                        h8 = uno_d_inv*Ipc;
                        f9 = f9_next;
                        f5 = f5_next;
                        f8 = f8_next;
                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor1_tvalid = 1'b1;
                        divisor1_tdata = resta_next[32:-31];
                        dividend1_tvalid = 1'b1;
                        dividend1_tdata = fs_DAB_fixed[32:-31];
                        
                    end    
        estado8:    begin
                        state1 = (contador1_next >= paso8)? estado9 :estado8;
                        contador1 = contador1_next + 8'd1;
                        Vdc2p = Vdc2p_next; 
                        d = d_next;
                        d_inv = d_inv_next;
                        h1 = h1_next;
                        h2 = h2_next;
                        uno_d_inv = uno_d_inv_next;
                        div = div_next;
                        f4 = f4_next;
                        aux1 = aux1_next;
                        resta = resta_next;
                        h3 = h3_next;
                        h7 = h7_next;
                        h4 = h4_next;
                        f11 = f11_next;
                        h8 = h8_next;
                        f9 = cuatro_piL*h3_next;
                        f5 = h7_next_chico*h3_next;
                        f8 = h8_next_chico+h4_next;
                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor1_tvalid = 1'b0;
                        divisor1_tdata = divisor1_tdata_next;
                        dividend1_tvalid = 1'b0;
                        dividend1_tdata = dividend1_tdata_next;
                    end    
        
        estado9:    begin
                        state1 = (contador1_next >= paso9)? estado10 :estado9;
                        contador1 = contador1_next + 8'd1;
                        Vdc2p = Vdc2p_next; 
                        d = d_next;
                        d_inv = d_inv_next;
                        h1 = h1_next;
                        h2 = h2_next;
                        uno_d_inv = uno_d_inv_next;
                        div = div_next;
                        f4 = f4_next;
                        aux1 = aux1_next;
                        resta = resta_next;
                        h3 = h3_next;
                        h7 = h7_next;
                        h4 = h4_next;
                        f11 = f11_next;
                        h8 = h8_next;
                        f9 = f9_next;
                        f5 = f5_next;
                        f8 = f8_next;
                        tau1_modo2a = f5_next_chico*f8_next;
                        tau2_modo2a = f9_next_chico*h4_next;
                        phi_modo2a = dout_tdata_chico;

                        divisor1_tvalid = 1'b1;
                        divisor1_tdata = Vdc1[32:-31];
                        dividend1_tvalid = 1'b1;
                        dividend1_tdata = f11_next_chico[32:-31];
                        
                    end    
        
        estado10:   begin
                        state1 = estado1;
                        contador1 = 8'd0;
                        Vdc2p = Vdc2p_next; 
                        d = d_next;
                        d_inv = d_inv_next;
                        h1 = h1_next;
                        h2 = h2_next;
                        uno_d_inv = uno_d_inv_next;
                        div = div_next;
                        f4 = f4_next;
                        aux1 = aux1_next;
                        resta = resta_next;
                        h3 = h3_next;
                        h7 = h7_next;
                        h4 = h4_next;
                        f11 = f11_next;
                        h8 = h8_next;
                        f9 = f9_next;
                        f5 = f5_next;
                        f8 = f8_next;
                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor1_tvalid = 1'b0;
                        divisor1_tdata = divisor1_tdata_next;
                        dividend1_tvalid = 1'b0;
                        dividend1_tdata = dividend1_tdata_next;
                    end    

        default:    begin
                        state1 = estado1;
                        contador1 = 8'd0;
                        Vdc2p = Vdc2p_next; 
                        d = d_next;
                        d_inv = d_inv_next;
                        h1 = h1_next;
                        h2 = h2_next;
                        uno_d_inv = uno_d_inv_next;
                        div = div_next;
                        f4 = f4_next;
                        aux1 = aux1_next;
                        resta = resta_next;
                        h3 = h3_next;
                        h7 = h7_next;
                        h4 = h4_next;
                        f11 = f11_next;
                        h8 = h8_next;
                        f9 = f9_next;
                        f5 = f5_next;
                        f8 = f8_next;
                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor1_tvalid = 1'b0;
                        divisor1_tdata = divisor1_tdata_next;
                        dividend1_tvalid = 1'b0;
                        dividend1_tdata = dividend1_tdata_next;
                        
                    end
        endcase
    

    always @(posedge clk or posedge rst)
    begin
        if (rst)   ///arreglar lo que se hace aqui 
        begin
            state1_next <= state1_next; 
            contador1_next <= contador1_next; 
            Vdc2p_next <= Vdc2p_next;  
            d_next <= d_next;
            d_inv_next <= d_inv_next;
            h1_next <= h1_next;
            h2_next <= h2_next;
            uno_d_inv_next <= uno_d_inv_next;
            div_next <= div_next;
            f4_next <= f4_next;
            aux1_next <= aux1_next;
            resta_next <= resta_next;
            h3_next <= h3_next;
            h7_next <= h7_next;
            h4_next <= h4_next;
            f11_next <= f11_next;
            h8_next <= h8_next;
            f9_next <= f9_next;
            f5_next <= f5_next;
            f8_next <= f8_next;
            tau1_modo2a_next <= tau1_modo2a_next;
            tau2_modo2a_next <= tau2_modo2a_next;
            phi_modo2a_next <= phi_modo2a_next;       
            divisor1_tdata_next <= divisor1_tdata_next;
            dividend1_tdata_next <= dividend1_tdata_next;
        end
        else if (CE)
        begin
            state1_next <= state1; 
            contador1_next <= contador1; 
            Vdc2p_next <= Vdc2p;  
            d_next <= d;
            d_inv_next <= d_inv ;
            h1_next <= h1;
            h2_next <= h2;
            uno_d_inv_next <= uno_d_inv;
            div_next <= div;
            f4_next <= f4;
            aux1_next <= aux1;
            resta_next <= resta;
            h3_next <= h3;
            h7_next <= h7;
            h4_next <= h4;
            f11_next <= f11;
            h8_next <= h8;
            f9_next <= f9;
            f5_next <= f5;
            f8_next <= f8;
            tau1_modo2a_next <= tau1_modo2a;
            tau2_modo2a_next <= tau2_modo2a;
            phi_modo2a_next <= phi_modo2a;       
            divisor1_tdata_next <= divisor1_tdata;
            dividend1_tdata_next <= dividend1_tdata;
        end
        else
        begin
            state1_next <= state1_next; 
            contador1_next <= contador1_next; 
            Vdc2p_next <= Vdc2p_next;  
            d_next <= d_next;
            d_inv_next <= d_inv_next;
            h1_next <= h1_next;
            h2_next <= h2_next;
            uno_d_inv_next <= uno_d_inv_next;
            div_next <= div_next;
            f4_next <= f4_next;
            aux1_next <= aux1_next;
            resta_next <= resta_next;
            h3_next <= h3_next;
            h7_next <= h7_next;
            h4_next <= h4_next;
            f11_next <= f11_next;
            h8_next <= h8_next;
            f9_next <= f9_next;
            f5_next <= f5_next;
            f8_next <= f8_next;
            tau1_modo2a_next <= tau1_modo2a_next;
            tau2_modo2a_next <= tau2_modo2a_next;
            phi_modo2a_next <= phi_modo2a_next;       
            divisor1_tdata_next <= divisor1_tdata_next;
            dividend1_tdata_next <= dividend1_tdata_next;
        end
    end


    always @(*)
    begin
        Vdc2p_next_chico = Vdc2p_next[bits_enteros:-bits_decimal];
        h1_next_chico = h1_next[bits_enteros:-bits_decimal];
        h2_next_chico = h2_next[bits_enteros:-bits_decimal];
        f4_next_chico = f4_next[bits_enteros:-bits_decimal];
        h7_next_chico = h7_next[bits_enteros:-bits_decimal];
        f11_next_chico = f11_next[bits_enteros:-bits_decimal];
        h8_next_chico = h8_next[bits_enteros:-bits_decimal];
        f9_next_chico = f9_next[bits_enteros:-bits_decimal];
        f5_next_chico = f5_next[bits_enteros:-bits_decimal];
        tau1_modo2a_final = tau1_modo2a_next[bits_enteros:-bits_decimal];
        tau2_modo2a_final = tau2_modo2a_next[bits_enteros:-bits_decimal];
        phi_modo2a_final  = phi_modo2a_next;
    end


    reg signed [bits_enteros:-bits_decimal] Vdc2p_next_chico, h1_next_chico,h2_next_chico,f4_next_chico,h7_next_chico,f11_next_chico,h8_next_chico, f9_next_chico, f5_next_chico, tau1_modo2a_final, tau2_modo2a_final, phi_modo2a_final;


    reg signed [bits_enteros:-bits_decimal] d_next, d_inv_next, uno_d_inv_next, div_next, aux1_next, resta_next, h3_next, h4_next, f8_next, phi_modo2a_next;
    reg signed [bits_enteros:-bits_decimal] d;, d_inv;, uno_d_inv;, div;, aux1;, resta;, h3;, h4;, f8;, phi_modo2a;

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
