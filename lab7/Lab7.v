module CashRegister(LEDR,SW,KEY,CLOCK_50,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7);
	parameter W=4;
	input [3:0] SW;
	input [2:0] KEY;
	input CLOCK_50;
	output [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7;
	output [5:0] LEDR;
	
	wire[3:0] Total;
	wire [36:0] clock;
	wire ToLarge1;
	wire ToLarge2;
	
	Clock_Div CD(CLOCK_50,clock);
	//CashReg #(.W(W)) CR(.Clock(clock[25]), .C(~KEY[2]), .T(~KEY[1]), .A(~KEY[0]), .X(SW[3:0]), .Total(Total[3:0]));
	CashReg #(.W(W)) CR(clock[22], ~KEY[2], ~KEY[0], ~KEY[1], SW[3:0], Total);
	
	Unsigned_to_7SEG #(.W(W)) U7S1(SW[3:0],HEX7,HEX6,HEX5,HEX4,ToLarge1);
	Unsigned_to_7SEG #(.W(W)) U7S2(Total,HEX3,HEX2,HEX1,HEX0,ToLarge2);

endmodule 