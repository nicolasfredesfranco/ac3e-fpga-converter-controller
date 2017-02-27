`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AC3E
// Engineer: Nicolas I. Fredes Franco
// 
// Create Date:    15:03:16 01/25/2017 
// Design Name: 
// Module Name:    switch 
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
module switch(clk, CE, rst, deadtime, V1, V2, Sp, Ss);
    input clk; // implementar rst de emergencia 
    input CE;
    input rst; 
    input [7:0] deadtime;
    input [1:0] V1, V2;
    output reg [3:0] Sp; //Conmutaciones del primario
    output reg [3:0] Ss; //Conmutaciones del secundario
    

    localparam estado_V1 = 4'd0;
    localparam estado_V0 = 4'd1;
    localparam estado_Vn1 = 4'd2;
    localparam estado_1_0 = 4'd3;
	localparam estado_0_1 = 4'd4;
    localparam estado_0_n1 = 4'd5;
    localparam estado_n1_0 = 4'd6;
    localparam estado_n1_1 = 4'd7;
    localparam estado_1_n1 = 4'd8;
     


    reg [3:0] state1, state2, state1_next, state2_next;
    reg [7:0] contador1, contador1_next, contador2, contador2_next;

	initial
    begin
        state1=estado_V0;
        state2=estado_V0;
    end


    always@(*)// maquina de estados para el voltaje V2
        case(state1)
        estado_V1:    begin 
                        state1_next = (V1==2'b00)? estado_1_0 :((V1==2'b11)?estado_1_n1 : estado_V1);//ojo con la comparacion
                    	contador1_next=8'd0;
                    	Sp=4'b0110;
                    end
        estado_V0:    begin
                        state1_next = (V1==2'b01)? estado_0_1 :((V1==2'b11)?estado_0_n1 : estado_V0);
                    	contador1_next=8'd0;
                    	Sp=4'b0101;
                    end
        estado_Vn1:    begin
                        state1_next = (V1==2'b00)? estado_n1_0 :((V1==2'b01)?estado_n1_1 : estado_Vn1);
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


	always@(*)// maquina de estados para el voltaje V2
        case(state2)
        estado_V1:    begin 
                        state2_next = (V2==2'b00)? estado_1_0 :((V2==2'b11)?estado_1_n1 : estado_V1);//ojo con la comparacion
                    	contador2_next=8'd0;
                    	Ss=4'b1001;
                    end
        estado_V0:    begin
                        state2_next = (V2==2'b01)? estado_0_1 :((V2==2'b11)?estado_0_n1 : estado_V0);
                    	contador2_next=8'd0;
                    	Ss=4'b0101;
                    end
        estado_Vn1:    begin
                        state2_next = (V2==2'b00)? estado_n1_0 :((V2==2'b01)?estado_n1_1 : estado_Vn1);
                    	contador2_next=8'd0;
                    	Ss=4'b0110;
                    end  
        estado_1_0:    begin
                        state2_next = (contador2==deadtime)?estado_V0:estado_1_0;
                    	contador2_next=contador2+8'd1;
                    	Ss=4'b0001;
                    end        
        estado_0_1:    begin
                        state2_next = (contador2==deadtime)?estado_V1:estado_0_1;
                    	contador2_next=contador2+8'd1;
                    	Ss=4'b0001;
                    end    
        estado_0_n1:    begin
                        state2_next = (contador2==deadtime)?estado_Vn1:estado_0_n1;
                    	contador2_next=contador2+8'd1;
                    	Ss=4'b0100;
                    end    
        estado_n1_0:    begin
                        state2_next = (contador2==deadtime)?estado_V0:estado_n1_0;
                    	contador2_next=contador2+8'd1;
                    	Ss=4'b0100;
                    end 
        estado_n1_1:    begin
                        state2_next = (contador2==deadtime)?estado_V1:estado_n1_1;
                    	contador2_next=contador2+8'd1;
                    	Ss=4'b0000;
                    end    
        estado_1_n1:    begin
                        state2_next = (contador2==deadtime)?estado_Vn1:estado_1_n1;
                    	contador2_next=contador2+8'd1;
                    	Ss=4'b0000;
                    end    
        default:    begin
                        state2_next = estado_V0;
                        contador2_next=8'd0;
                        Ss=4'b0000;
                    end
        endcase




    always @(posedge clk or posedge rst)
    begin
        if (rst)
        begin
            state1 <= estado_V1;
            state2 <= estado_V1;
            contador1 <= 8'd0;
            contador2 <= 8'd0;
        end
        else
        begin
            if (CE)
            begin
                state1 <= state1_next;
                state2 <= state2_next;
                contador1 <= contador1_next;
                contador2 <= contador2_next;                  
            end
            else
            begin
                state1 <= state1;
                state2 <= state2;
                contador1 <= contador1;
                contador2 <= contador2; 
            end
        end
    end    

endmodule

