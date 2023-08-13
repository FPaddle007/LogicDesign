`timescale 1ns/1ns
module Testbench();
	reg [6:0] SW;
	reg [3:0] KEY;
	wire [6:0] HEX0, HEX1;
	
	Renee R(SW,KEY,HEX0,HEX1);
	
	initial begin
		SW = 7'b0010010;KEY = 4'b1111;#5;
		SW = 7'b0010001;KEY = 4'b1111;#5;
		SW = 7'b1010101;KEY = 4'b1100;#5;
	end
endmodule