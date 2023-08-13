// Top-level design module

module Timing(SW);
	input SW[3:0];
	output [0:0] LEDG;
	
	combotime M(.a(SW[0]), .b(SW[1]), .c(SW[2]), .d(SW[3]), .z(LEDG[0]));
endmodule