// ModelSim allows the use of "generate".
// This module defines a parameterized W-bit RCA adder/dubtsctor
module AddSub
	#(parameter W = 16)			// Default width
	(A, B, c0, S, ovf);
	input [W-1:0] A, B;			// W-bit unsigned inputs
	input c0;								// Carry-in
	output [W-1:0] S;				// W-bit unsigned output
	output ovf;							// Overflow signal

	wire [W:0] c;						// Carry signals
	assign c[0] = c0;

// Instantiate and "chain" W full adders 
	genvar i;
	generate
		for (i = 0; i < W; i = i + 1)
			FullAdder FA[W-1:0](A[i], B[i] ^ c[0], c[i], S[i], c[i+1]);
	endgenerate

// Overflow
		assign ovf = c[W-1] ^ c[W];
endmodule

/*
// BoothMul TestBench
`timescale 1ns/100ps
module TestBench();
	parameter W = 8;							// Data bit width
	localparam WW = 2 * W;

	reg Clock;
	always #5 Clock = ~Clock;

	reg Reset;
	reg Start;

	reg signed [W-1:0] Q, M;
	wire signed [WW-1:0] P;

	BoothMul #(.W(W)) BM(Clock, Reset, Start, M, Q, P);

	initial begin
		Clock = 0; Reset = 1;
		#10;
		Reset = 0;
		M = 'd7; Q = -'d8;
		Start = 1;
		#10;
		Start = 0;
		#(4 * W * 10);
		M = 'd7; Q = -'d6;
		Start = 1;
		#10;
		Start = 0;
		#(4 * W * 10);
		M = 'd13; Q = -'d10;
		Start = 1;
		#10;
		Start = 0;
		#(4 * W * 10);
		M = 'd15; Q = 'd15;
		Start = 1;
		#10;
		Start = 0;
		#(4 * W * 10);
	end
endmodule
*/


// Four-Function Calculator TestBench
`timescale 1ns/100ps
module TestBench();
	parameter WIDTH = 11;							// Data bit width

// Inputs and Outputs
	reg Clock;
	reg Clear;											// C button
	reg Equals;											// = button: displays result so far; does not repeat previous operation
	reg Add;												// + button
	reg Subtract;										// - button
	reg Multiply;										// x button (multiply)
	reg Divide;											// Divide button
	reg [WIDTH-1:0] NumberSM; 					// Must be entered in sign-magnitude on SW[W-1:0]
	wire signed [WIDTH-1:0] Result;
	wire Overflow;
	wire CantDisplay;
	wire [4:0] State;

	wire signed [WIDTH-1:0] NumberTC;
	SM2TC #(.width(WIDTH)) SM2TC1(NumberSM, NumberTC);
	FourFuncCalc #(.W(WIDTH)) FFC(Clock, Clear, Equals, Add, Subtract, Multiply, Divide, NumberSM, Result, Overflow, State);

	
// Define 10 ns Clock
	always #5 Clock = ~Clock;
	
	initial begin
	Clock = 0;
	
//  1 + 3 = 4

		#10; Equals = 1; NumberSM = 1; 
		#10; Equals = 0;

		#20; Add = 1;
		#20; Add = 0;
		#20; Equals = 1; NumberSM = 3; 
		#20; Equals = 0;

//  4-4=0
		#20; Subtract = 1;
		#20; Subtract = 0;
		#20; Equals = 1; NumberSM = 4;
		#30; Equals = 0;

		
//  1023 + -1023 = 0

		#20; Add = 1;
		#20; Add = 0;
		#20; Equals = 1; NumberSM = 1023; 
		#20; Equals = 0;
		
		#20; Add = 1;
		#20; Add = 0;
		#20; Equals = 1; NumberSM[10] = 1; NumberSM[9:0] = 1023;
		#20; Equals = 0;

//  1023 + 10 = 1033 (ovf)
		#20; Add = 1;
		#20; Add = 0;
		#20; Equals = 1; NumberSM = 1023; 
		#20; Equals = 0;

		#20; Add = 1;
		#20; Add = 0;
		#20; Equals = 1; NumberSM = 10; 
		#20; Equals = 0;
		end
		
		
		/*
		//  1 X 2 X 3 = 6

		#10; Equals = 1; NumberSM = 1; 
		#10; Equals = 0;

		#20; Multiply = 1;
		#20; Multiply = 0;
		#20; Equals = 1; NumberSM = 2;
		#20; Equals = 0;
		
		#500; NumberSM = 3;
		#20; Multiply = 1;
		#20; Multiply = 0;
		#20; Equals = 1;
		#10; Equals = 0;
		
		//  -2 X -1 = 2
		#10; Equals = 1;NumberSM[10]=1;NumberSM[9:0] = 2;
		#10; Equals = 0;

		#20; Multiply = 1;
		#20; Multiply = 0;
		#20; Equals = 1; NumberSM[10]=1;NumberSM[9:0] = 1;
		#20; Equals = 0;
		
		
		//  3 X 0 = 0
		#10; Equals = 1;NumberSM=3;
		#10; Equals = 0;

		#20; Multiply = 1;
		#20; Multiply = 0;
		#20; Equals = 1; NumberSM=0;
		#20; Equals = 0;
		end
		*/
	
endmodule
