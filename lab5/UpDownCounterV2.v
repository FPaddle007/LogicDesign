// Top - Level Module

/*
In this version of the design, you should specify sequential behavior following the example in verilog_ref_seqv2.pdf [Check Canvas Page to see example]
Note that you may NOT use an adder or addition to solve this problem (but see the post-lab).
*/

module UpDownCounterV2(SW, KEY, LEDR);

// Input

// UpDown = SW[0]...Enable = SW[1]...Reset = SW[17]
input [17:0] SW;
// KEY[0] = CLK
input [0:0] KEY;

// Output

// Taken = LEDR[0]...Strong = LEDR[1]
output [1:0] LEDR;
reg [1:0] LEDR;

// States
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

reg [2:0] state;
reg [2:0] next_state;

always @(posedge KEY[0])
	begin
		case(state)
		A:	if(SW[0] == 1 && SW[1] == 1)
				next_state = B;
			else if ((SW[1] == 0) || (SW[1] == 1 && SW[0] == 0))
				next_state = A;
				
		B: if(SW[0] == 1 && SW[1] == 1)
				next_state = C;
			else if (SW[1] == 0)
				next_state = B;
			else if (SW[0] == 0 && SW[1] == 1)
			    next_state = A;
				
		C: if(SW[0] == 1 && SW[1] == 1)
				next_state = D;
			else if (SW[0] == 0 && SW[1] == 1)
				next_state = B;
			else if (SW[1] == 0)
				next_state = C;
				
		D: if (SW[0] == 0 && SW[1] == 1)
				next_state = C;
			else if ((SW[0] == 1 && SW[1] == 1) || (SW[1] == 0))
				next_state = D;
				
		endcase
	end

// Reset
always @(posedge KEY[0])
	begin
		if (SW[17] == 1)
			state <= A;
		else
			state <= next_state;
	end
	
// Output
always @(posedge KEY[0])
	begin 
		case(state)
		A: begin
			LEDR[0] = 0;
			LEDR[1] = 1;
		end
		
		B: begin
			LEDR[0] = 0;
			LEDR[1] = 0;
		end
		
		C: begin
			LEDR[0] = 1;
			LEDR[1] = 0;
		end
		
		D: begin
			LEDR[0] = 1;
			LEDR[1] = 1;
		end
		endcase
	end
		
endmodule
