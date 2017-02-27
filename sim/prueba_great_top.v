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
	reg rst;
    reg sync;
    reg [11:0] Vdc1;
    reg [11:0] Vdc2;
    reg [11:0] Iref;

    
	
	// Outputs
	wire trigger;
	wire [1:0] modo;
	wire Sp1, Sp2, Sp3, Sp4, Ss1, Ss2, Ss3, Ss4;
	
	// UUT
		great_top inst_great_top
		(
			.clk     (clk),
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
		rst = 1'b0;
		Vdc1 = 12'd3481; // 340 V
		Vdc2 = 12'd3440; //  100.8 V  
		Iref = 12'd3072;  // 10 A
		sync = 1'b0;

		#700

		sync = 1'b1;

		#14300;
		Iref = 12'd1024;// -10 A
		#20000;
		Iref = 12'd4095; // 20 A
		// La prueba
	
	end


endmodule
