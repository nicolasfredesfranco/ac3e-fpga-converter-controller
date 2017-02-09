`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.02.2017 11:36:02
// Design Name: 
// Module Name: test_controlador
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


module test_controlador();
	// Inputs
	reg clk;
	reg trigger;
	reg	[13:0] Vdc1;
	reg [13:0] Vdc2;
	reg [13:0] Iref;
	reg [18:0] fs_DAB;

	// Outputs
	wire [8:0] tau1;
	wire [8:0] tau2;
	wire [8:0] phi;
	wire [1:0] modo;
	// UUT
		controlador inst_controlador
		(
			.clk    (clk),
			.trigger (trigger),
			.Vdc1   (Vdc1),
			.Vdc2   (Vdc2),
			.Iref   (Iref),
			.fs_DAB (fs_DAB),
			.tau1   (tau1),
			.tau2   (tau2),
			.phi    (phi),
			.modo   (modo)
		);



	always 
	begin
	#5 clk= ~clk;
	end



	always 
	begin
	#5000 trigger= ~trigger;
	end


	initial begin
		clk = 1'b0;
		trigger = 1'b0;
		Vdc1 = 14'd2785; //340 V
		Vdc2 = 14'd826; // 100.8 V
		Iref = 14'd1638;  //equivale a 10 A
		fs_DAB = 19'd100000;
		#20000;
		Iref = -14'd1638;
		#20000;
		Iref = -14'd6554;
		// La prueba
	end

	

endmodule
