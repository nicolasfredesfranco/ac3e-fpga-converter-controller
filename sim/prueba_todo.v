`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:07:00 01/26/2017
// Design Name:   main
// Module Name:   C:/Users/Usuario/Documents/GitHub/ac3e-fpga-converter-controller/proj/prueba_todo.v
// Project Name:  converter_controller
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: main
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module prueba_todo;

	// Inputs
	reg clk;
	reg sync;
	reg switch;

	// Outputs
	wire [3:0] Sp;
	wire [3:0] Ss;
	wire trigger;
	wire clk2;

	// Instantiate the Unit Under Test (UUT)
	main uut (
		.clk(clk), 
		.sync(sync), 
		.switch(switch), 
		.Sp(Sp), 
		.Ss(Ss), 
		.trigger(trigger),
		.clk2(clk2)
	);


	always 
	begin
		#5 clk= ~clk;
	end

	initial begin
		// Initialize Inputs

		clk = 0;
		sync = 0; 

		switch = 0;

		// Wait 100 ns for global reset to finish
		#1000;	
		sync =1;
		#100
		sync=0;   

		// Wait 100 ns for global reset to finish
		#50000

		switch = 1;
        
		// Add stimulus here

	end
      
endmodule

