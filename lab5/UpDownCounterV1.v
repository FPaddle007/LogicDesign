// Top Level Function

/*
In this version of the design you should implement the combinational next-state and output logic using assign statements and the behavioral logic operators (&, |, ^, and ~). 
Flip-flops should be implemented using an always @(posedge Clock), and Reset should be done in the always block.
*/

`timescale 1ns/1ns
module UpDownCounterV1(SW, KEY, LEDR);

// Input

// UpDown = SW[0]...Enable = SW[1]...Reset = SW[17]
input [17:0] SW;
// KEY[0] = CLK
input [0:0] KEY;

// Output

// Taken = LEDR[0]...Strong = LEDR[1]
output [1:0] LEDR;

// Intial State
reg[1:0] Q;
initial Q = 2'b00;

// Next State Logic
wire[1:0] D;
assign D[1] = (~SW[17]) & ((Q[1] & ~SW[1]) + (Q[1] & SW[0]) + (Q[1] & Q[0]) + (Q[0] & SW[1] & SW[0]));
assign D[0] = (~SW[17]) & ((Q[0] & ~SW[1]) + (Q[1] & SW[1] & SW[0]) + (~Q[0] & SW[1] & SW[0]) + (Q[1] & ~Q[0] & SW[1]));

always @(posedge KEY[0])
	begin
		Q <= D;
	end

// Output Assignment
assign LEDR[0] = Q[1];
assign LEDR[1] = ~(Q[0] ^ Q[1]);

endmodule
