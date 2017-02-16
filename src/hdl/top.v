`timescale 1ns / 1ps  //OJO !! HAY QUE ARREGLAR ESTO 
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
///////////////////////////////////////////////////////////////////////////////////
module voltajes(clk, CE, rst, fs_clk, t1, t2, phi, fs_DAB, sync, V1, V2, trigger); //<3
    input clk; // implementar rst de emergencia
    input CE;
    input rst;
    input [27:0] fs_clk;  
    input signed [8:0] t1, t2; //se entregan valores entre 0 y 255 (el signo es para operar con phi)
    input signed [8:0] phi; //se entrega entre -255 y 255
    input signed [18:0] fs_DAB;// esta en Hz y va de 0 a 150000
    input sync; //signal de disparo 
    //output [3:0] Sp; //Conmutaciones del primario
    //output [3:0] Ss; //Conmutaciones del secundario
    
    //parameter deadtime=8'd0; //ver que escala usar    

    localparam INIT = 3'd0;
    localparam estado1 = 3'd1;
    localparam estado2 = 3'd2;
    localparam estado3 = 3'd3;
    localparam estado4 = 3'd4;

    output reg signed [1:0] V1, V2;  // dejar como variables internas despues 
    output reg trigger; //para sincronizar al medir

    reg [2:0] state1, state2, state1_next, state2_next;
    reg [2:0] state3, state3_next;
    reg signed [18:0] contador1, contador2, contador1_next, contador2_next; //revisar numero de bits
    reg signed [18:0] tau1_cuentas, pi_cuentas, tau2_cuentas, phi_cuentas;
    reg signed [18:0] link1_1, link1_2, link1_3, link1_4, link2_1, link2_2, link2_3, link2_4; 

    initial
        begin
            state1=INIT;
            state2=INIT;
            state3=INIT;//Nueva maquina diseñada para sincronizar las otras 2
            pi_cuentas = 19'd500;
            tau1_cuentas = 19'd499;
            phi_cuentas = -19'd17;
            tau2_cuentas = 19'd288;
        end


    // se procede a adaptar los inputs a numero de cuentas de reloj

    wire div_tau1_valid;
    wire div_tau2_valid;
    wire div_phi_valid;
    wire div_pi_valid;
    wire [55:0] div_data_tau1;
    wire [55:0] div_data_tau2;
    wire [55:0] div_data_phi;
    wire [55:0] div_data_pi;

    wire signed [27:0] div_quo_tau1;  // Nota, verificar el tratamiento de datos con signo      
    wire signed [27:0] div_quo_tau2;  // Nota, verificar el tratamiento de datos con signo      
    wire signed [27:0] div_quo_phi;   // Nota, verificar el tratamiento de datos con signo  
    wire signed [26:0] div_quo_pi;   // Nota, verificar el tratamiento de datos con signo  

    assign div_quo_tau1 = div_data_tau1[51:24]; // [51:24]
    assign div_quo_tau2 = div_data_tau2[51:24];
    assign div_quo_phi = div_data_phi[51:24];
    assign div_quo_pi  = div_data_pi [50:24];

    reg signed [27:0] phi_cuentas_aux;
    reg signed [27:0] phi_cuentas_aux_next;
    reg signed [18:0] tau1_cuentas_next;
    reg signed [27:0] tau1_cuentas_aux;
    reg signed [27:0] tau1_cuentas_aux_next;
    reg signed [18:0] pi_cuentas_next;
    reg signed [18:0] tau2_cuentas_next;
    reg signed [27:0] tau2_cuentas_aux;
    reg signed [27:0] tau2_cuentas_aux_next;
    reg signed [18:0] phi_cuentas_next;

    /////////////////////////////

    wire [27:0] quotient;
    wire [27:0] fs_clk_medios;


    assign  quotient = (fs_clk>>9);
    assign fs_clk_medios = {fs_clk >> 1} ;

    ////////////////////////////
    always@(*) //concatenacion de jaime para poder dividir (complemento a2)
    begin // 196_078 consutar referencia en verde
        tau1_cuentas_aux_next= (t1*quotient);// 
        tau1_cuentas_next = (div_tau1_valid) ? div_quo_tau1 : tau1_cuentas;
        //tau1_cuentas_next=tau1_cuentas_aux/fs_DAB;// OJO quizas la division genera problema de timing
        pi_cuentas_next=(div_pi_valid) ? div_quo_pi : pi_cuentas;// el numero debe ser 5*10^7
        tau2_cuentas_aux_next= (t2*quotient);// OJO quizas la division genera problema de timing
        tau2_cuentas_next = (div_tau2_valid) ? div_quo_tau2 : tau2_cuentas;
        //tau2_cuentas_next=tau2_cuentas_aux/fs_DAB;// OJO quizas la division genera problema de timing
        //phi_cuentas=({{10{phi[8]}},phi}*196078)/fs_DAB;// OJO quizas la division genera problema de timing;
        phi_cuentas_aux_next=phi*quotient;// OJO quizas la division genera problema de timing;
        phi_cuentas_next = (div_phi_valid) ? div_quo_phi : phi_cuentas;
        //phi_cuentas_next=phi_cuentas_aux/fs_DAB;// OJO quizas la division genera problema de timing;
    end

    always@(posedge clk) //concatenacion de jaime para poder dividir (complemento a2)
    begin // 196_078 consutar referencia en verde
        tau1_cuentas_aux <= tau1_cuentas_aux_next;
        tau1_cuentas <= tau1_cuentas_next;
        pi_cuentas <= pi_cuentas_next;
        tau2_cuentas <= tau2_cuentas_next;
        tau2_cuentas_aux <= tau2_cuentas_aux_next;
        phi_cuentas <= phi_cuentas_next;
        phi_cuentas_aux <= phi_cuentas_aux_next;
    end

    div_gen_v4_0_0 DivTau1 (
      .aclken(CE),
      .aclk(clk),                                           // input aclk
      .s_axis_divisor_tvalid(1'b1),                         // input s_axis_divisor_tvalid
      .s_axis_divisor_tready(),                             // output s_axis_divisor_tready
      .s_axis_divisor_tdata({{5{fs_DAB[18]}},fs_DAB}),      // input [23 : 0] s_axis_divisor_tdata
      .s_axis_dividend_tvalid(1'b1),                        // input s_axis_dividend_tvalid
      .s_axis_dividend_tready(),                            // output s_axis_dividend_tready
      .s_axis_dividend_tdata({{4{tau1_cuentas_aux[27]}},tau1_cuentas_aux}),      // input [31 : 0] s_axis_dividend_tdata
      .m_axis_dout_tvalid(div_tau1_valid),                  // output m_axis_dout_tvalid
      .m_axis_dout_tdata(div_data_tau1)                     // output [55 : 0] m_axis_dout_tdata
    );
    
    div_gen_v4_0_0 DivTau2 (
      .aclken(CE),
      .aclk(clk),                                           // input aclk
      .s_axis_divisor_tvalid(1'b1),                         // input s_axis_divisor_tvalid
      .s_axis_divisor_tready(),                             // output s_axis_divisor_tready
      .s_axis_divisor_tdata({{5{fs_DAB[18]}},fs_DAB}),      // input [23 : 0] s_axis_divisor_tdata
      .s_axis_dividend_tvalid(1'b1),                        // input s_axis_dividend_tvalid
      .s_axis_dividend_tready(),                            // output s_axis_dividend_tready
      .s_axis_dividend_tdata({{4{tau2_cuentas_aux[27]}},tau2_cuentas_aux}),              // input [31 : 0] s_axis_dividend_tdata
      .m_axis_dout_tvalid(div_tau2_valid),                  // output m_axis_dout_tvalid
      .m_axis_dout_tdata(div_data_tau2)                     // output [55 : 0] m_axis_dout_tdata
    );
    
    div_gen_v4_0_0 DivPhi (
      .aclken(CE),
      .aclk(clk),                                           // input aclk
      .s_axis_divisor_tvalid(1'b1),                         // input s_axis_divisor_tvalid
      .s_axis_divisor_tready(),                             // output s_axis_divisor_tready
      .s_axis_divisor_tdata({{5{fs_DAB[18]}},fs_DAB}),      // input [23 : 0] s_axis_divisor_tdata
      .s_axis_dividend_tvalid(1'b1),                        // input s_axis_dividend_tvalid
      .s_axis_dividend_tready(),                            // output s_axis_dividend_tready
      .s_axis_dividend_tdata({{4{phi_cuentas_aux[27]}},phi_cuentas_aux}),           // input [31 : 0] s_axis_dividend_tdata
      .m_axis_dout_tvalid(div_phi_valid),                   // output m_axis_dout_tvalid
      .m_axis_dout_tdata(div_data_phi)                      // output [55 : 0] m_axis_dout_tdata
    );

    div_gen_v4_0_1_pi DivPi (
      .aclken(CE),
      .aclk(clk),                                           // input aclk
      .s_axis_divisor_tvalid(1'b1),                         // input s_axis_divisor_tvalid
      .s_axis_divisor_tready(),                             // output s_axis_divisor_tready
      .s_axis_divisor_tdata({{5{fs_DAB[18]}},fs_DAB}),      // input [23 : 0] s_axis_divisor_tdata
      .s_axis_dividend_tvalid(1'b1),                        // input s_axis_dividend_tvalid
      .s_axis_dividend_tready(),                            // output s_axis_dividend_tready
      .s_axis_dividend_tdata({{4{fs_clk_medios[27]}},fs_clk_medios}), // input [31 : 0] s_axis_dividend_tdata
      .m_axis_dout_tvalid(div_pi_valid),                    // output m_axis_dout_tvalid
      .m_axis_dout_tdata(div_data_pi)                       // output [55 : 0] m_axis_dout_tdata
    );


    //se definen los valores de transicion entre estados (numero de cuentas)

    reg signed [18:0] link1_1_next;
    reg signed [18:0] link1_2_next;
    reg signed [18:0] link1_3_next;
    reg signed [18:0] link1_4_next;
    reg signed [18:0] link2_1_next;
    reg signed [18:0] link2_2_next;
    reg signed [18:0] link2_3_next;
    reg signed [18:0] link2_4_next;

    always@(*) 
    begin 
        link1_1_next =  pi_cuentas - tau1_cuentas;
        link1_2_next = pi_cuentas;
        link1_3_next =  2*pi_cuentas - tau1_cuentas;
        link1_4_next =  2*pi_cuentas - 19'd1;
        link2_1_next = pi_cuentas + phi_cuentas - tau2_cuentas;
        link2_2_next = pi_cuentas + phi_cuentas;
        link2_3_next =  2*pi_cuentas + phi_cuentas - tau2_cuentas;
        link2_4_next =  2*pi_cuentas + phi_cuentas;
    end

    always @(posedge clk) begin
        link1_1 <= link1_1_next;
        link1_2 <= link1_2_next;
        link1_3 <= link1_3_next;
        link1_4 <= link1_4_next;
        link2_1 <= link2_1_next;
        link2_2 <= link2_2_next;
        link2_3 <= link2_3_next;
        link2_4 <= link2_4_next;
    end



    always@(*)// maquina de estados para el voltaje V1
        case(state1)
        INIT:       begin 
                        state1_next = (sync)?estado1:INIT;
                        V1=2'd0;
                    end    
        estado1:    begin 
                        state1_next = (contador1>=link1_1)?estado2:estado1;// los valores de los link 
                        V1=2'd0;
                    end
        estado2:    begin 
                        state1_next = (contador1>=link1_2)?estado3:estado2;// estan dados por las transiciones
                        V1=2'd1;
                    end
        estado3:    begin
                        state1_next = (contador1>=link1_3)?estado4:estado3;// entre los estados
                        V1=2'd0;
                    end    
        estado4:    begin
                        state1_next = (contador1>=link1_4)?estado1:estado4;
                        V1=-2'd1;
                    end    
        default:    begin
                        state1_next=estado1; 
                        V1=2'd0;
                    end    
        endcase


    always@(*)// maquina de estados para el voltaje V2
        case(state2)
        INIT:       begin 
                        state2_next = (sync)?estado1:INIT;
                        V2=2'd0;
                    end
        estado1:    begin
                        state2_next = (contador2>=link2_1)?estado2:estado1;// los valores de los link 
                        V2=2'd0;
                    end
        estado2:    begin
                        state2_next = (contador2>=link2_2)?estado3:estado2;// estan dados por las transiciones
                        V2=2'd1;
                    end  
        estado3:    begin
                        state2_next = (contador2>=link2_3)?estado4:estado3;// entre los estados
                        V2=2'd0;
                    end        
        estado4:    begin
                        state2_next = (contador2>=link2_4)?estado1:estado4;
                        V2=-2'd1;
                    end    
        default:    begin
                        state2_next=estado1;
                        V2=2'd0;
                    end
        endcase


    always@(*)// maquina de estados para el voltaje V2
        case(state3)
        INIT:       begin 
                        state3_next = ((state1==estado4) || (state2==estado4))?estado1:INIT;//preguntar como se hace el o
                    end
        estado1:    begin
                        state3_next = (state2==estado1)?estado2:((state1==estado1)?estado3:estado1);
                    end
        estado2:    begin
                        state3_next = (state1==estado1)?estado4:estado2;
                    end  
        estado3:    begin
                        state3_next = (state2==estado1)?estado4:estado3;
                    end        
        estado4:    begin
                        state3_next = INIT;
                    end    
        default:    begin
                        state3_next = INIT;
                    end
        endcase




    always@(*)
    begin
        if(state1==INIT)
            contador1=19'd0;
        else 
        begin   
            contador1=(contador1_next>link1_4-19'd1)? 19'd0 : contador1_next+19'd1;//IMPORTANTE: arrreglar valor en el que se resetea
        end
    end


    always@(*)
    begin
        if(state2==INIT)
            contador2=19'd0;
        else 
        begin
            if(state3==estado4)
            begin
                contador2 = contador1;        
            end 
            else
            begin
                contador2 = ((contador2_next>(link2_4-19'd1) && (contador2_next[18]==1'b0)))? phi_cuentas : contador2_next+19'd1;//IMPORTANTE: arrreglar valor en el que se resetea
            end
        end
    end


    always @(posedge clk or posedge rst)
    begin
        if (rst)
        begin
            contador1_next <= 19'd0;
            contador2_next <= 19'd0; 
        end
        else
        begin
            if (CE)
            begin
                contador1_next <= contador1;
                contador2_next <= contador2;
            end
            else
            begin
                contador1_next <= contador1_next;
                contador2_next <= contador2_next;                        
            end        
        end
    end



    always @(posedge clk or posedge rst)
    begin
        if (rst)
        begin
            state1 <= estado1;
            state2 <= estado1;
            state3 <= INIT; 
        end
        else
        begin
            if (CE)
            begin
                state1 <= state1_next;
                state2 <= state2_next;
                state3 <= state3_next;
            end
            else
            begin
                state1 <= state1;
                state2 <= state2;
                state3 <= state3;                       
            end        
        end
    end


 

    //----------- solo para ver en el ociloscopio 



    always@(*)
    begin
        if(contador1_next<pi_cuentas)
            trigger=1'b1;
        else 
            trigger=1'b0;  
    end






endmodule

