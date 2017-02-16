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



    reg [3:0] state1, state2, state3, state1_next, state2_next, state3_next;
    reg [7:0] contador1, contador1_next;


    initial
    begin
        tau1=9'd255;
        tau2=9'd147;
        phi=-9'd9;
        state1_next= INIT;
        state2_next= INIT;
        state3_next= INIT;
    end


    localparam bits_enteros = 20;
    localparam bits_decimal = 17;
    localparam razon_vueltas = 38'd720896; // (n1/n2)
    localparam razon_vueltas_inv = 38'd23831; // (n2/n1)
    localparam f1 = 38'd4332; // ((n2/n1)^2 /4) * Isc^2
    localparam uno = 38'd131072;
    localparam cuatro_piL = 38'd41; //4*pi*L
    localparam c1 = 38'd48; //c1 =  2 pi * L * (Ipc + Isc*n2/n1)
    localparam pi = 38'd411774; //pi 
    localparam c2 = 38'd82; //c2=  4pi*L*Ipc
    localparam dos_pi2L = 38'd64; //2 pi^2 * L
    localparam pi_medio = 38'd205887; //pi/2
    localparam escalado = 38'd10638985; // 255/pi
    localparam dos = 38'd262144;// 2 
    localparam Ipc = 38'd262144;// 2
    localparam Isc = 38'd262144;// 2

    

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
    localparam estado_espera = 4'd11;



//////////tiempo de espera para los calculos, ANALIZAR QUE VALORES PONER EN FUNCION DE LA COMPLEJIDAD DE LAS OPERACIONES

    localparam paso1 = 8'd3;
    localparam paso2 = 8'd12;
    localparam paso3 = 8'd15;
    localparam paso4 = 8'd24;
    localparam paso5 = 8'd33;
    localparam paso6 = 8'd36;
    localparam paso7 = 8'd76;
    localparam paso8 = 8'd85;
    localparam paso9 = 8'd100;



///////////////////////////////////////////////////////////////// CAJAS PARA CALCULOS (sacar raiz)

wire signed [bits_enteros:-bits_decimal] fs_DAB_fixed;

assign  fs_DAB_fixed = {{2{fs_DAB[18]}},fs_DAB,17'b0};


////////////////////////////////


wire calcular_sqrt2, rdy_aux2_float, rdy_sqrt2_float, rdy_sqrt2_corto, invalid_op_sqrt2;
wire [31:0] aux2_float, sqrt2_float;
wire [37 : 0] sqrt2_corto;
reg signed [bits_enteros:-bits_decimal] sqrt2_next;




///////////////////////////


fixed_to_float caja1 (
  .a(aux2_next), // input [37 : 0] a
  .operation_nd(calcular_sqrt2), // input operation_nd
  .clk(clk), // input clk
  .ce(CE), // input ce
  .result(aux2_float), // output [31 : 0] result
  .rdy(rdy_aux2_float) // output rdy
);


sqrt_in_float caja2 (
  .a(aux2_float), // input [31 : 0] a
  .operation_nd(rdy_aux2_float), // input operation_nd
  .clk(clk), // input clk
  .ce(CE), // input ce
  .result(sqrt2_float), // output [31 : 0] result
  .invalid_op(invalid_op_sqrt2), // output invalid_op
  .rdy(rdy_sqrt2_float) // output rdy
);


float_to_fixed caja3 (
  .a(sqrt2_float), // input [31 : 0] a
  .operation_nd(rdy_sqrt2_float), // input operation_nd
  .clk(clk), // input clk
  .ce(CE), // input ce
  .result(sqrt2_corto), // // output [37 : 0] result
  .rdy(rdy_sqrt2_corto) // output rdy
);




assign  calcular_sqrt2 = (state3_next==estado7)? 1'b1 : 1'b0;


always @(posedge clk)
begin
    if (rdy_sqrt2_corto) 
    begin
        sqrt2_next <= sqrt2_corto; 
    end
    else
    begin
        sqrt2_next <= sqrt2_next ;
    end
end

wire aux2_positivo;
assign aux2_positivo = ~(aux2_next[20]);



//////
    

    wire calcular_sqrt1, rdy_aux1_float, rdy_sqrt1_float, rdy_sqrt1_corto, invalid_op_sqrt1;
    wire [31:0] aux1_float, sqrt1_float;
    wire [37 : 0] sqrt1_corto;
    reg signed [bits_enteros:-bits_decimal] sqrt1_next;


fixed_to_float caja4 (
  .a(aux1_next), // input [37 : 0] a
  .operation_nd(calcular_sqrt1), // input operation_nd
  .clk(clk), // input clk
  .ce(CE), // input ce
  .result(aux1_float), // output [31 : 0] result
  .rdy(rdy_aux1_float) // output rdy
);


sqrt_in_float caja5 (
  .a(aux1_float), // input [31 : 0] a
  .operation_nd(rdy_aux1_float), // input operation_nd
  .clk(clk), // input clk
  .ce(CE), // input ce
  .result(sqrt1_float), // output [31 : 0] result
  .invalid_op(invalid_op_sqrt1), // output invalid_op
  .rdy(rdy_sqrt1_float) // output rdy
);


float_to_fixed caja6 (
  .a(sqrt1_float), // input [31 : 0] a
  .operation_nd(rdy_sqrt1_float), // input operation_nd
  .clk(clk), // input clk
  .ce(CE), // input ce
  .result(sqrt1_corto), // output [37 : 0] result
  .rdy(rdy_sqrt1_corto) // output rdy
);

assign  calcular_sqrt1 = (state1_next==estado7)? 1'b1 : 1'b0;



always @(posedge clk)
begin
    if (rdy_sqrt1_corto) 
    begin
        sqrt1_next <= sqrt1_corto;    
    end
    else
    begin
        sqrt1_next <= sqrt1_next ;
    end
end

wire aux1_positivo;
assign aux1_positivo = ~(aux1_next[20]);


/////////////////////////////////// ///////////////////////////// cajas para dividir


 
    reg signed [bits_enteros:-bits_decimal] divisor, dividendo, divisor_next, dividendo_next;

    wire [31 : 0] divisor_float, dividendo_float, division_float;
    wire  rdy_divisor_float, rdy_dividendo_float, rdy_division_float, rdy_division;

    wire signed [bits_enteros:-bits_decimal] division;

    wire divide;
    assign divide = (rdy_divisor_float && rdy_dividendo_float);



fixed_to_float caja7 (
  .a(divisor_next), // input [37 : 0] a
  .operation_nd(1'b1), // input operation_nd
  .clk(clk), // input clk
  .ce(CE), // input ce
  .result(divisor_float), // output [31 : 0] result
  .rdy(rdy_divisor_float) // output rdy
);

fixed_to_float caja8 (
  .a(dividendo_next), // input [37 : 0] a
  .operation_nd(1'b1), // input operation_nd
  .clk(clk), // input clk
  .ce(CE), // input ce
  .result(dividendo_float), // output [31 : 0] result
  .rdy(rdy_dividendo_float) // output rdy
);



div_in_float caja9 (
  .a(dividendo_float), // input [31 : 0] a
  .b(divisor_float), // input [31 : 0] b
  .operation_nd(divide), // input operation_nd
  .clk(clk), // input clk
  .ce(CE), // input ce
  .result(division_float), // output [31 : 0] result
  .rdy(rdy_division_float) // output rdy
);




float_to_fixed caja10 (
  .a(division_float), // input [31 : 0] a
  .operation_nd(rdy_division_float), // input operation_nd
  .clk(clk), // input clk
  .ce(CE), // input ce
  .result(division), // output [37 : 0] result
  .rdy(rdy_division) // output rdy
);



/////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////machine state 1   asociada al modo 2a
////
    always@(*)// maquina de estados para el voltaje V2
        case(state1_next)
        INIT:    begin 
                        state1 = (sync)? estado1 : INIT;//ojo con la comparacion
                        contador1 = 8'd0;
                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor = divisor_next;
                        dividendo = dividend1_tdata_next;
                    end
        estado1:    begin
                        state1 = (contador1_next >= paso1)? estado2 :estado1;
                        contador1 = contador1_next + 8'd1;

                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor = divisor_next;
                        dividendo = dividend1_tdata_next;
                    end
        estado2:    begin
                        state1 = (contador1_next >= paso2)? estado3 :estado2;
                        contador1 = contador1_next + 8'd1;

                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor = divisor_next;
                        dividendo = dividend1_tdata_next;              
                    end  
        estado3:    begin
                        state1 = (contador1_next >= paso3)? estado4 :estado3;
                        contador1 = contador1_next + 8'd1;

                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor = divisor_next;
                        dividendo = dividend1_tdata_next;
                        
                    end        
        estado4:    begin
                        state1 = (contador1_next >= paso4)? estado5 :estado4; 
                        contador1 = contador1_next + 8'd1;

                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor = divisor_next;
                        dividendo = dividend1_tdata_next;
                        
                    end    
        estado5:    begin
                        state1 = (contador1_next >= paso5)? estado6 :estado5; 
                        contador1 = contador1_next + 8'd1;

                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor = divisor_next;
                        dividendo = dividend1_tdata_next;
                        
                    end    
        estado6:    begin
                        state1 = (contador1_next >= paso6)? ((aux1_positivo)? estado7 : estado_espera) : estado6 ;
                        contador1 = contador1_next + 8'd1;

                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor = divisor_next;
                        dividendo = dividend1_tdata_next;
                        
                    end 
        estado7:    begin
                        state1 = (contador1_next >= paso7)? estado8 :estado7;
                        contador1 = contador1_next + 8'd1;

                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor = divisor_next;
                        dividendo = dividend1_tdata_next;
                        
                    end    
        estado8:    begin
                        state1 = (contador1_next >= paso8)? estado9 :estado8;
                        contador1 = contador1_next + 8'd1;

                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor = divisor_next;
                        dividendo = dividend1_tdata_next;
                    end    
        
        estado9:    begin
                        state1 = (contador1_next >= paso9)? estado10 :estado9;
                        contador1 = contador1_next + 8'd1;

                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor = divisor_next;
                        dividendo = dividend1_tdata_next;
                        
                    end    
        
        estado10:   begin
                        state1 = estado1;
                        contador1 = 8'd0;

                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor = divisor_next;
                        dividendo = dividend1_tdata_next;
                    end    
        estado_espera:    begin
                        state1 = (contador1_next >= paso9)? estado10 :estado_espera;
                        contador1 = contador1_next + 8'd1;

                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor = divisor_next;
                        dividendo = dividend1_tdata_next;
                        
                    end    

        default:    begin
                        state1 = estado1;
                        contador1 = 8'd0;

                        tau1_modo2a = tau1_modo2a_next;
                        tau2_modo2a = tau2_modo2a_next;
                        phi_modo2a = phi_modo2a_next;

                        divisor = divisor_next;
                        dividendo = dividend1_tdata_next;
                        
                    end
        endcase
    

    always @(posedge clk or posedge rst)
    begin
        if (rst)                                              ///arreglar lo que se hace aqui 
        begin
            state1_next <= estado1; 
            contador1_next <= 8'd0; 

            tau1_modo2a_next <= tau1_modo2a_next;
            tau2_modo2a_next <= tau2_modo2a_next;
            phi_modo2a_next <= phi_modo2a_next;
        end
        else if (CE)
        begin
            state1_next <= state1; 
            contador1_next <= contador1; 

            tau1_modo2a_next <= tau1_modo2a;
            tau2_modo2a_next <= tau2_modo2a;
            phi_modo2a_next <= phi_modo2a;
        end
        else
        begin
            state1_next <= state1_next; 
            contador1_next <= contador1_next; 

            tau1_modo2a_next <= tau1_modo2a_next;
            tau2_modo2a_next <= tau2_modo2a_next;
            phi_modo2a_next <= phi_modo2a_next;
        end
    end


    always @(*)
    begin
        Vdc2p_next_chico = Vdc2p_next[bits_enteros:-bits_decimal];

        phi_modo2a_final  = phi_modo2a_next;
    end



///////////////////////////////////////////////////////////////////////machine state 2      asociada al modo 2b 



    always@(*)// maquina de estados para el voltaje V2
        case(state2_next)
        INIT:    begin 
                        state2 = (sync)? estado1 : INIT;//ojo con la comparacion

                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;
                    end
        estado1:    begin
                        state2 = (contador1_next >= paso1)? estado2 :estado1;


                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;
                    end
        estado2:    begin
                        state2 = (contador1_next >= paso2)? estado3 :estado2;

                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;             
                    end  
        estado3:    begin
                        state2 = (contador1_next >= paso3)? estado4 :estado3;

                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;
                        
                    end        
        estado4:    begin
                        state2 = (contador1_next >= paso4)? estado5 :estado4; 

                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;
                        
                    end    
        estado5:    begin
                        state2 = (contador1_next >= paso5)? estado6 :estado5; 

                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;
                        
                    end    
        estado6:    begin
                        state2 = (contador1_next >= paso6)? estado7 : estado6 ;

                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;
                        
                    end 
        estado7:    begin
                        state2 = (contador1_next >= paso7)? estado_espera :estado7;

                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;
                        
                    end      
        estado10:   begin
                        state2 = estado1;

                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;
                    end    
        estado_espera:    begin
                        state2 = (contador1_next >= paso9)? estado10 :estado_espera;

                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;
                        
                    end    
        default:    begin
                        state2 = estado1;

                        tau2_modo2b = tau2_modo2b_next;
                        phi_modo2b = phi_modo2b_next;
                        
                    end
        endcase
    



    always @(posedge clk or posedge rst)
    begin
        if (rst)                                              ///arreglar lo que se hace aqui 
        begin
            state2_next <= estado1;
            tau2_modo2b_next <= tau2_modo2b_next;
            phi_modo2b_next <= phi_modo2b_next;
        end
        else if (CE)
        begin
            state2_next <= state2;
            tau2_modo2b_next <= tau2_modo2b;
            phi_modo2b_next <= phi_modo2b;
  
        end
        else
        begin
            state2_next <= state2_next;
            tau2_modo2b_next <= tau2_modo2b_next;
            phi_modo2b_next <= phi_modo2b_next; 
        end
    end


    always @(*)
    begin
        g0_next_chico = g0_next[bits_enteros:-bits_decimal];
        g4_next_chico = g4_next[bits_enteros:-bits_decimal];

    end







///////////////////////////////////////////////////////////////////////machine state 3      asociada al modo 1

    always@(*)// maquina de estados para el voltaje V2
        case(state3_next)
        INIT:    begin 
                        state3 = (sync)? estado1 : INIT;//ojo con la comparacion

                        tau2_modo1 = tau2_modo1_next;
                        phi_modo1 = phi_modo1_next;

                    end
        estado1:    begin
                        state3 = (contador1_next >= paso1)? estado2 :estado1;

                        tau2_modo1 = tau2_modo1_next;
                        phi_modo1 = phi_modo1_next;

                    end
        estado2:    begin
                        state3 = (contador1_next >= paso2)? estado3 :estado2;

                        tau2_modo1 = tau2_modo1_next;
                        phi_modo1 = phi_modo1_next;
             
                    end  
        estado3:    begin
                        state3 = (contador1_next >= paso3)? estado4 :estado3;

                        tau2_modo1 = tau2_modo1_next;
                        phi_modo1 = phi_modo1_next; 
                    end        
        estado4:    begin
                        state3 = (contador1_next >= paso4)? estado5 :estado4; 

                        tau2_modo1 = tau2_modo1_next;
                        phi_modo1 = phi_modo1_next;
                    end    
        estado5:    begin
                        state3 = (contador1_next >= paso5)? estado6 :estado5; 

                        tau2_modo1 = tau2_modo1_next;
                        phi_modo1 = phi_modo1_next;
                        
                    end    
        estado6:    begin
                        state3 = (contador1_next >= paso6)? ((aux1_positivo)? estado7 : estado_espera) : estado6 ;

                        tau2_modo1 = tau2_modo1_next;
                        phi_modo1 = phi_modo1_next;

                    end 
        estado7:    begin
                        state3 = (contador1_next >= paso7)? estado8 :estado7;

                        tau2_modo1 = tau2_modo1_next;
                        phi_modo1 = phi_modo1_next;

                    end    
        estado8:    begin
                        state3 = (contador1_next >= paso8)? estado9 :estado8;

                        tau2_modo1 = tau2_modo1_next;
                        phi_modo1 = phi_modo1_next;

                    end    
        
        estado9:    begin
                        state3 = (contador1_next >= paso9)? estado10 :estado9;

                        tau2_modo1 = tau2_modo1_next;
                        phi_modo1 = phi_modo1_next;
                        
                    end    
        
        estado10:   begin
                        state3 = estado1;

                        tau2_modo1 = tau2_modo1_next;
                        phi_modo1 = phi_modo1_next;

                    end    
        estado_espera:    begin
                        state3 = (contador1_next >= paso9)? estado10 :estado_espera;

                        tau2_modo1 = tau2_modo1_next;
                        phi_modo1 = phi_modo1_next;
                        
                    end    

        default:    begin
                        state3 = estado1;

                        tau2_modo1 = tau2_modo1_next;
                        phi_modo1 = phi_modo1_next;
                        
                    end
        endcase
  

    always @(posedge clk or posedge rst)
    begin
        if (rst)                                              ///arreglar lo que se hace aqui 
        begin
            state3_next <= estado1;
            tau2_modo1_next <= tau2_modo1_next;
            phi_modo1_next <= phi_modo1_next;

        end
        else if (CE)
        begin
            state3_next <= state3;
            tau2_modo1_next <= tau2_modo1;
            phi_modo1_next <= phi_modo1;
 
        end
        else
        begin
            state3_next <= state3_next;
            tau2_modo1_next <= tau2_modo1_next;
            phi_modo1_next <= phi_modo1_next;

        end
    end


    always @(*)
    begin
        k0_next_chico = k0_next[bits_enteros:-bits_decimal];

    end

 


//////////////////////////////////////////////////////////////////////////////






always @(*)
begin
    flag1 = phi_modo2b_next - tau2_modo2b_next + pi;
    flag2 = tau2_modo1_next - phi_modo1_next;
end

reg signed [bits_enteros:-bits_decimal] flag1, flag2;

reg signed [8:0] tau1_modo2a_adaptado, tau2_modo2a_adaptado, phi_modo2a_adaptado, tau2_modo2b_adaptado, phi_modo2b_adaptado, tau2_modo1_adaptado, phi_modo1_adaptado;
reg signed [2*bits_enteros:-2*bits_decimal] tau1_modo2a_inter, tau2_modo2a_inter, phi_modo2a_inter, tau2_modo2b_inter, phi_modo2b_inter, tau2_modo1_inter, phi_modo1_inter;

always @(*)
begin
    tau1_modo2a_inter = escalado*tau1_modo2a_final;
    tau2_modo2a_inter = escalado*tau2_modo2a_final;
    phi_modo2a_inter = escalado*phi_modo2a_final;
    tau2_modo2b_inter = escalado*tau2_modo2b_next;
    phi_modo2b_inter = escalado*phi_modo2b_next;
    tau2_modo1_inter = escalado*tau2_modo1_next;
    phi_modo1_inter = escalado*phi_modo1_next; 
end



always @(*)
begin
    tau1_modo2a_adaptado = {tau1_modo2a_inter[20],tau1_modo2a_inter[7:0]};
    tau2_modo2a_adaptado = {tau2_modo2a_inter[20],tau2_modo2a_inter[7:0]};
    phi_modo2a_adaptado = {phi_modo2a_inter[20],phi_modo2a_inter[7:0]};
    tau2_modo2b_adaptado = {tau2_modo2b_inter[20],tau2_modo2b_inter[7:0]};
    phi_modo2b_adaptado = {phi_modo2b_inter[20],phi_modo2b_inter[7:0]};
    tau2_modo1_adaptado = {tau2_modo1_inter[20],tau2_modo1_inter[7:0]};
    phi_modo1_adaptado = {phi_modo1_inter[20],phi_modo1_inter[7:0]};
end


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
    if (aux1_positivo && (tau1_modo2a_final < pi)) //preguntar a miguel porque restringe a que sea menor a pi 
    begin
        tau1 <= tau1_modo2a_adaptado;   
        tau2 <= tau2_modo2a_adaptado;
        phi <= phi_modo2a_adaptado;
        modo <= 2'd0;   
    end
    else if ((phi_modo2b_next[20]) && (~flag1[20])) 
    begin 
        tau1 <= 9'd255;   
        tau2 <= tau2_modo2b_adaptado;
        phi <= phi_modo2b_adaptado;
        modo <= 2'd1;
    end
    else if (aux2_positivo && (~phi_modo1_next[20]) && (~flag2[20])) // es necesario agregar flag 2, ver referencia en verde
    begin
        tau1 <= 9'd255;   
        tau2 <= tau2_modo1_adaptado;
        phi <= phi_modo1_adaptado;
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
