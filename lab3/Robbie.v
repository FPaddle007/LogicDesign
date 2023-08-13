module Robbie(SW,HEX1, HEX0);
	input [2:0] SW;
	output [6:0] HEX0;
	output [6:0] HEX1;
	wire lw, rw;
	
	Robbie_Controller R_C(.ls(SW[2]), .fs(SW[1]), .rs(SW[0]), .lwa(lw), .rwa(rw));
	Robbie_Display left_display(lw, HEX1);
	Robbie_Display right_display(rw, HEX0);
endmodule