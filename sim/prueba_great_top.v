`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.02.2017 10:50:13
// Design Name: 
// Module Name: prueba_great_top
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


module prueba_great_top();
// Inputs

	reg clk;
	reg CE;
	reg rst;
    reg sync;
    reg [32:-32] Vdc1;
    reg [32:-32] Vdc2;
    reg [32:-32] Iref;

    
	
	// Outputs
	wire trigger;
	wire [1:0] modo;
	wire Sp1, Sp2, Sp3, Sp4, Ss1, Ss2, Ss3, Ss4;
	
	// UUT
		great_top inst_great_top
		(
			.clk     (clk),
			.CE      (CE),
			.rst     (rst),
			.sync    (sync),
			.Vdc1    (Vdc1),
			.Vdc2    (Vdc2),
			.Iref    (Iref),
			.Sp1      (Sp1),
			.Sp2      (Sp2),
			.Sp3      (Sp3),
			.Sp4      (Sp4),
			.Ss1      (Ss1),
			.Ss2      (Ss2),
			.Ss3      (Ss3),
			.Ss4      (Ss4),
			.trigger (trigger),
			.modo    (modo)
		);



	always 
	begin
	#5 clk= ~clk;
	end




	initial begin
		clk = 1'b0;
		CE  = 1'b1;
		rst = 1'b0;
		Vdc1 = 65'd1460288880640; //340 V
		Vdc2 = 65'd432932703436; // 100.8 V  432932703436
		Iref = 65'd85899345920;  //equivale a 20 A
		sync = 1'b0;

		#700

		sync = 1'b1;

		
		/*
		#14300;
		Iref = 14'd2294;// -10 A
		#20000;
		Iref = 14'd6554; // 40 A
		// La prueba
		*/
	end


endmodule
