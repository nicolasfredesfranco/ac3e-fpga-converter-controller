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
    reg [13:0] Vdc1;
    reg [13:0] Vdc2;
    reg [13:0] Iref;

    
	
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
		Vdc1 = 14'd2785; //340 V
		Vdc2 = 14'd826; // 100.8 V
		Iref = 14'd2294;  //equivale a 10 A
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