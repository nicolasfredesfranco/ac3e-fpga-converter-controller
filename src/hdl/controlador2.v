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
    localparam pi = 65'd13493037704; //pi
    

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
    

    
    reg divisor1_tvalid, dividend1_tvalid;
    wire dout_tvalid;
    wire signed [95 : 0] dout_tdata;
    wire signed [bits_enteros:-bits_decimal] dout_tdata_chico;
    reg  signed [63 : 0] divisor1_tdata, dividend1_tdata, divisor1_tdata_next, dividend1_tdata_next;
    wire signed [bits_enteros:-bits_decimal] fs_DAB_fixed;

    assign dout_tdata_chico = {dout_tdata[95],dout_tdata[63:0]};
    assign  fs_DAB_fixed = {{14{fs_DAB[18]}},fs_DAB,32'b0};

divisor caja1 (
  .aclk(clk), // input aclk
  .aclken(CE), // input aclken
  .s_axis_divisor_tvalid(divisor1_tvalid), // input s_axis_divisor_tvalid
  .s_axis_divisor_tdata(divisor1_tdata_next), // input [63 : 0] s_axis_divisor_tdata
  .s_axis_dividend_tvalid(dividend1_tvalid), // input s_axis_dividend_tvalid
  .s_axis_dividend_tdata(dividend1_tdata_next), // input [63 : 0] s_axis_dividend_tdata
  .m_axis_dout_tvalid(dout_tvalid), // output m_axis_dout_tvalid
  .m_axis_dout_tdata(dout_tdata) // output [95 : 0] m_axis_dout_tdata
);
///////////////////////////////////////////////////////////////////////////////////////machine state 1   asociada al modo 2a

fixed_to_float caja2 (
  .a(aux1[32:-31]), // input [63 : 0] a
  .operation_nd(calcular_sqrt1), // input operation_nd
  .clk(clk), // input clk
  .ce(CE), // input ce
  .result(aux1_float), // output [31 : 0] result
  .rdy(rdy_aux1_float) // output rdy
);


sqrt_in_float caja3 (
  .a(aux1_float), // input [31 : 0] a
  .operation_nd(rdy_aux1_float), // input operation_nd
  .clk(clk), // input clk
  .ce(CE), // input ce
  .result(sqrt1_float), // output [31 : 0] result
  .invalid_op(invalid_op_sqrt1), // output invalid_op
  .rdy(rdy_sqrt1_float) // output rdy
);


float_to_fixed caja4 (
  .a(sqrt1_float), // input [31 : 0] a
  .operation_nd(rdy_sqrt1_float), // input operation_nd
  .clk(clk), // input clk
  .ce(CE), // input ce
  .result(sqrt1_corto), // output [63 : 0] result
  .rdy(rdy_sqrt1_corto) // output rdy
);

assign  calcular_sqrt1 = (state1_next==estado7)? 1'b1 : 1'b0;

wire calcular_sqrt1, rdy_aux1_float, rdy_sqrt1_float, rdy_sqrt1_corto, invalid_op_sqrt1;
wire [31:0] aux1_float, sqrt1_float;
wire [63 : 0] sqrt1_corto;
reg signed [bits_enteros:-bits_decimal] sqrt1_next;

always @(posedge clk)
begin
    if (rdy_sqrt1_corto) 
    begin
        sqrt1_next <= {sqrt1_corto,1'b0};    
    end
    else
    begin
        sqrt1_next <= sqrt1_next ;
    end
end

wire aux1_positivo;
assign aux1_positivo = ~(aux1_next[64]);

////
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
                        state1 = (contador1_next >= paso1_2a)? estado2 :estado1;
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
                        state1 = (contador1_next >= paso2_2a)? estado3 :estado2;
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
                        divisor1_tdata = Vdc2p_next_chico[32:-31];
                        dividend1_tvalid = 1'b1;
                        dividend1_tdata = Vdc1[32:-31];                 
                    end  
        estado3:    begin
                        state1 = (contador1_next >= paso3_2a)? estado4 :estado3;
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
                        state1 = (contador1_next >= paso4_2a)? estado5 :estado4; 
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
                        state1 = (contador1_next >= paso5_2a)? estado6 :estado5; 
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
                        dividend1_tdata = Vdc2p_next_chico[32:-31];
                        
                    end    
        estado6:    begin
                        state1 = (contador1_next >= paso6_2a)? ((aux1_positivo)? estado7 : estado10) : estado6 ;
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
                        state1 = (contador1_next >= paso7_2a)? estado8 :estado7;
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
                        h4 = razon_vueltas + sqrt1_next;
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
                        state1 = (contador1_next >= paso8_2a)? estado9 :estado8;
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
                        state1 = (contador1_next >= paso9_2a)? estado10 :estado9;
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
        if (rst)                                              ///arreglar lo que se hace aqui 
        begin
            state1_next <= estado1; 
            contador1_next <= 8'd0; 
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

    reg signed [2*bits_enteros:-2*bits_decimal] Vdc2p_next, h1_next, h2_next, f4_next, h7_next, f11_next, h8_next, f9_next, f5_next, tau1_modo2a_next, tau2_modo2a_next;  
    reg signed [2*bits_enteros:-2*bits_decimal] Vdc2p, h1, h2, f4, h7, f11, h8, f9, f5, tau1_modo2a, tau2_modo2a;  

    reg signed [bits_enteros:-bits_decimal] Vdc2p_next_chico, h1_next_chico,h2_next_chico,f4_next_chico,h7_next_chico,f11_next_chico,h8_next_chico, f9_next_chico, f5_next_chico, tau1_modo2a_final, tau2_modo2a_final, phi_modo2a_final;


    reg signed [bits_enteros:-bits_decimal] d_next, d_inv_next, uno_d_inv_next, div_next, aux1_next, resta_next, h3_next, h4_next, f8_next, phi_modo2a_next;
    reg signed [bits_enteros:-bits_decimal] d, d_inv, uno_d_inv, div, aux1, resta, h3, h4, f8, phi_modo2a;

///////////////////////////////////////////////////////////////////////machine state 2      asociada al modo 2b 





always@(*)// maquina de estados para el voltaje V2
        case(state2_next)
        INIT:    begin 
                        state2 = (sync)? estado1 : INIT;//ojo con la comparacion
                        contador2 = 8'd0;

                        g0 = g0_next;
                        g1 = g1_next;
                        g2 = g2_next;
                        g3 = g3_next;
                        g4 = g4_next;
                        g5 = g5_next;
                        g6 = g6_next;
                        g7 = g7_next;
                        g8 = g8_next;
                        g9 = g9_next;
                        g10 = g10_next;

                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;

                        divisor2_tvalid = 1'b0;
                        divisor2_tdata = divisor2_tdata_next;
                        dividend2_tvalid = 1'b0;
                        dividend2_tdata = dividend2_tdata_next;
                    end
        estado1:    begin
                        state2 = (contador2_next >= paso1_2b)? estado2 :estado1;
                        contador2 = contador2_next + 8'd1;

                        g0 = pi*Vdc1;
                        g1 = g1_next;
                        g2 = -c2*fs_DAB_fixed;
                        g3 = g3_next;
                        g4 = Vdc2*razon_vueltas;
                        g5 = g5_next;
                        g6 = g6_next;
                        g7 = g7_next;
                        g8 = g8_next;
                        g9 = g9_next;
                        g10 = g10_next;

                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;

                        divisor2_tvalid = 1'b0;
                        divisor2_tdata = divisor2_tdata_next;
                        dividend2_tvalid = 1'b0;
                        dividend2_tdata = dividend2_tdata_next;
                    end
        estado2:    begin
                        state2 = (contador2_next >= paso2_2b)? estado3 :estado2;
                        contador2 = contador2_next + 8'd1;

                        g0 = g0_next;
                        g1 = dout2_tdata_chico;
                        g2 = g2_next;
                        g3 = g3_next;
                        g4 = g4_next;
                        g5 = g5_next;
                        g6 = g6_next;
                        g7 = g7_next;
                        g8 = g8_next;
                        g9 = g9_next;
                        g10 = g10_next;

                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;

                        divisor2_tvalid = 1'b1;
                        divisor2_tdata = g4_next_chico[32:-31];
                        dividend2_tvalid = 1'b1;
                        dividend2_tdata = g0_next_chico[32:-31];             
                    end  
        estado3:    begin
                        state2 = (contador2_next >= paso3_2b)? estado4 :estado3;
                        contador2 = contador2_next + 8'd1;

                        g0 = g0_next;
                        g1 = g1_next;
                        g2 = g2_next;
                        g3 = dout2_tdata_chico;
                        g4 = g4_next;
                        g5 = g5_next;
                        g6 = g6_next;
                        g7 = dos_pi2L*fs_DAB_fixed;
                        g8 = g8_next;
                        g9 = g9_next;
                        g10 = g10_next;

                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;

                        divisor2_tvalid = 1'b1;
                        divisor2_tdata = g4_next_chico[32:-31];
                        dividend2_tvalid = 1'b1;
                        dividend2_tdata = g2_next_chico[32:-31];
                        
                    end        
        estado4:    begin
                        state2 = (contador2_next >= paso4_2b)? estado5 :estado4;
                        contador2 = contador2_next + 8'd1;

                        g0 = g0_next;
                        g1 = g1_next;
                        g2 = g2_next;
                        g3 = g3_next;
                        g4 = g4_next;
                        g5 = g5_next;
                        g6 = g6_next;
                        g7 = g7_next;
                        g8 = Iref*g7_next_chico;
                        g9 = g9_next;
                        g10 = g10_next;

                        tau2_modo2b = g3_next + g1_next;
                        phi_modo2b = phi_modo2b_next;

                        divisor2_tvalid = 1'b0;
                        divisor2_tdata = divisor2_tdata_next;
                        dividend2_tvalid = 1'b0;
                        dividend2_tdata = dividend2_tdata_next;
                        
                    end    
        estado5:    begin
                        state2 = (contador2_next >= paso5_2b)? estado6 :estado5;
                        contador2 = contador2_next + 8'd1;

                        g0 = g0_next;
                        g1 = g1_next;
                        g2 = g2_next;
                        g3 = g3_next;
                        g4 = g4_next;
                        g5 = (tau2_modo2b_next>>1);
                        g6 = tau2_modo2b_next*g4_next_chico;
                        g7 = g7_next;
                        g8 = g8_next;
                        g9 = g9_next;
                        g10 = g10_next;

                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;

                        divisor2_tvalid = 1'b0;
                        divisor2_tdata = divisor2_tdata_next;
                        dividend2_tvalid = 1'b0;
                        dividend2_tdata = dividend2_tdata_next;
                        
                    end    
        estado6:    begin
                        state2 = (contador2_next >= paso6_2b)? estado7 :estado6;
                        contador2 = contador2_next + 8'd1;

                        g0 = g0_next;
                        g1 = g1_next;
                        g2 = g2_next;
                        g3 = g3_next;
                        g4 = g4_next;
                        g5 = g5_next;
                        g6 = g6_next;
                        g7 = g7_next;
                        g8 = g8_next;
                        g9 = dout2_tdata_chico;
                        g10 = g5 - pi_medio;

                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;

                        divisor2_tvalid = 1'b1;
                        divisor2_tdata = g6_next_chico[32:-31];
                        dividend2_tvalid = 1'b1;
                        dividend2_tdata = g8_next_chico[32:-31];
                        
                    end 
        estado7:    begin
                        state2 = (contador2_next >= paso7_2b)? estado8 :estado7;
                        contador2 = contador2_next + 8'd1;

                        g0 = g0_next;
                        g1 = g1_next;
                        g2 = g2_next;
                        g3 = g3_next;
                        g4 = g4_next;
                        g5 = g5_next;
                        g6 = g6_next;
                        g7 = g7_next;
                        g8 = g8_next;
                        g9 = g9_next;
                        g10 = g10_next;

                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = g9_next + g10_next;

                        divisor2_tvalid = 1'b0;
                        divisor2_tdata = divisor2_tdata_next;
                        dividend2_tvalid = 1'b0;
                        dividend2_tdata = dividend2_tdata_next;
                        
                    end    
        estado8:    begin
                        state2 = estado1;
                        contador2 = 8'd0;

                        g0 = g0_next;
                        g1 = g1_next;
                        g2 = g2_next;
                        g3 = g3_next;
                        g4 = g4_next;
                        g5 = g5_next;
                        g6 = g6_next;
                        g7 = g7_next;
                        g8 = g8_next;
                        g9 = g9_next;
                        g10 = g10_next;

                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;

                        divisor2_tvalid = 1'b0;
                        divisor2_tdata = divisor2_tdata_next;
                        dividend2_tvalid = 1'b0;
                        dividend2_tdata = dividend2_tdata_next;
                    end     
        default:    begin
                        state2 = estado1;
                        contador2 = 8'd0;

                        g0 = g0_next;
                        g1 = g1_next;
                        g2 = g2_next;
                        g3 = g3_next;
                        g4 = g4_next;
                        g5 = g5_next;
                        g6 = g6_next;
                        g7 = g7_next;
                        g8 = g8_next;
                        g9 = g9_next;
                        g10 = g10_next;

                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;

                        divisor2_tvalid = 1'b0;
                        divisor2_tdata = divisor2_tdata_next;
                        dividend2_tvalid = 1'b0;
                        dividend2_tdata = dividend2_tdata_next;    
                    end
        endcase
    


    always @(posedge clk or posedge rst)
    begin
        if (rst)                                              ///arreglar lo que se hace aqui 
        begin
            state2_next <= estado1;
            contador2_next <= 8'd0;

            g0_next <=  g0_next;
            g1_next <=  g1_next;
            g2_next <=  g2_next;
            g3_next <=  g3_next;
            g4_next <=  g4_next;
            g5_next <=  g5_next;
            g6_next <=  g6_next;
            g7_next <=  g7_next;
            g8_next <=  g8_next;
            g9_next <=  g9_next;
            g10_next <= g10_next;

            tau2_modo2b_next <= tau2_modo2b_next;
            phi_modo2b_next <= phi_modo2b_next;

            divisor2_tdata_next <= divisor2_tdata_next;
            dividend2_tdata_next <= dividend2_tdata_next;
        end
        else if (CE)
        begin
            state2_next <= state2;
            contador2_next <= contador2;

            g0_next <=  g0 ;
            g1_next <=  g1 ;
            g2_next <=  g2 ;
            g3_next <=  g3 ;
            g4_next <=  g4 ;
            g5_next <=  g5 ;
            g6_next <=  g6 ;
            g7_next <=  g7 ;
            g8_next <=  g8 ;
            g9_next <=  g9 ;
            g10_next <= g10 ;

            tau2_modo2b_next <= tau2_modo2b;
            phi_modo2b_next <= phi_modo2b;

            divisor2_tdata_next <= divisor2_tdata;
            dividend2_tdata_next <= dividend2_tdata;  
        end
        else
        begin
            state2_next <= state2_next;
            contador2_next <= contador2_next;

            g0_next <=  g0_next;
            g1_next <=  g1_next;
            g2_next <=  g2_next;
            g3_next <=  g3_next;
            g4_next <=  g4_next;
            g5_next <=  g5_next;
            g6_next <=  g6_next;
            g7_next <=  g7_next;
            g8_next <=  g8_next;
            g9_next <=  g9_next;
            g10_next <= g10_next;

            tau2_modo2b_next <= tau2_modo2b_next;
            phi_modo2b_next <= phi_modo2b_next;

            divisor2_tdata_next <= divisor2_tdata_next;
            dividend2_tdata_next <= dividend2_tdata_next;  
        end
    end


    always @(*)
    begin
        g0_next_chico = g0_next[bits_enteros:-bits_decimal];
        g4_next_chico = g4_next[bits_enteros:-bits_decimal];
        g2_next_chico = g2_next[bits_enteros:-bits_decimal];
        g7_next_chico = g7_next[bits_enteros:-bits_decimal];
        g8_next_chico = g8_next[bits_enteros:-bits_decimal];
        g6_next_chico = g6_next[bits_enteros:-bits_decimal];
    end



    reg signed [2*bits_enteros:-2*bits_decimal] g0, g4, g2, g7, g8, g6, g0_next, g4_next, g2_next, g7_next, g8_next, g6_next;

    reg signed [bits_enteros:-bits_decimal] g0_next_chico, g4_next_chico, g2_next_chico, g7_next_chico, g8_next_chico, g6_next_chico;

    reg signed [bits_enteros:-bits_decimal] g1, g3, g5, g9, g10, g1_next, g3_next, g5_next, g9_next, g10_next;

    reg signed [bits_enteros:-bits_decimal] tau2_modo2b_next, tau2_modo2b, phi_modo2b_next, phi_modo2b;




    
    reg divisor2_tvalid, dividend2_tvalid;
    wire dout2_tvalid;
    wire signed [95 : 0] dout2_tdata;
    wire signed [bits_enteros:-bits_decimal] dout2_tdata_chico;
    reg  signed [63 : 0] divisor2_tdata, dividend2_tdata, divisor2_tdata_next, dividend2_tdata_next;

    assign dout2_tdata_chico = {dout2_tdata[95],dout2_tdata[63:0]};

divisor caja5 (
  .aclk(clk), // input aclk
  .aclken(CE), // input aclken
  .s_axis_divisor_tvalid(divisor2_tvalid), // input s_axis_divisor_tvalid
  .s_axis_divisor_tdata(divisor2_tdata_next), // input [63 : 0] s_axis_divisor_tdata
  .s_axis_dividend_tvalid(dividend2_tvalid), // input s_axis_dividend_tvalid
  .s_axis_dividend_tdata(dividend2_tdata_next), // input [63 : 0] s_axis_dividend_tdata
  .m_axis_dout_tvalid(dout2_tvalid), // output m_axis_dout_tvalid
  .m_axis_dout_tdata(dout2_tdata) // output [95 : 0] m_axis_dout_tdata
);





///////////////////////////////////////////////////////////////////////machine state 3      asociada al modo 1













































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
