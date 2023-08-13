module Renee(SW, KEY, HEX0, HEX1);
	input [6:0] SW;
	input [3:0] KEY;
	output [6:0] HEX0, HEX1;
	wire [2:0] lw, rw;
	
	Priority P(.ls(SW[6:4]), .rs(SW[2:0]), .lb(~KEY[3]), .rb(~KEY[2]), .fb(~KEY[1]), .bb(~KEY[0]), .lw(lw), .rw(rw));
	WheelDisplay WD1(lw,HEX1);
	WheelDisplay WD2(rw,HEX0);
endmodule