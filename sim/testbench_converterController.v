`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:47:49 01/24/2017
// Design Name:   top
// Module Name:   C:/Users/Usuario/Documents/GitHub/ac3e-fpga-converter-controller/proj/testbench_converterController.v
// Project Name:  converter_controller
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbench_converterController;

	// Inputs
	reg clk;
	reg [8:0] t1;
	reg [8:0] t2;
	reg [8:0] phi;
	reg [18:0] fs_DAB;
	reg sync;

	// Outputs
	wire [1:0] V1;
	wire [1:0] V2;


	always 
	begin
	#5 clk= ~clk;
	end
	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clk(clk), 
		.t1(t1), 
		.t2(t2), 
		.phi(phi), 
		.fs_DAB(fs_DAB), 
		.sync(sync), 
		.V1(V1), 
		.V2(V2)
	);

	initial begin
		// Initialize Inputs
		clk = 0;

		/*
		NOTA:
		t1 y t2 se mueve entre 0 y 255  (0 a pi)
		phi se mueve entre -255 y 255   (-pi a pi)
		*/



		////// MODE 1
		/*
		t1 = 9'd223; //CORRESPONDE A 7PI/8
		t2 = 9'd128;//CORRESPONDE A PI/2
		phi = 9'd64; //CORRESPONDE A PI/4
		
		*/
		//////////////////////////////

		////// MODE 2
		
		t1 = 9'd223; //CORRESPONDE A 7PI/8
		t2 = 9'd128; //CORRESPONDE A PI/2
		phi = -9'd32; //CORRESPONDE A -PI/8
		
		//////////////////

		fs_DAB = 19'd100000; // OPERANDO A 100KHz

		sync = 0;


		// Wait 100 ns for global reset to finish
		#1000;
		sync =1;
		#100
		sync=0;        
		// Add stimulus here

	end


      
endmodule

