`timescale 1ns/1ns
module Testbench();
	reg [3:0] SW;
	wire [6:0] HEX7,HEX6;
	
	NumDisplay ND(SW,HEX7,HEX6);
	
	initial begin
		SW = 4'b0000;#5;
		SW = 4'b0001;#5;
		SW = 4'b1111;#5;
		SW = 4'b0010;#5;
		SW = 4'b1110;#5;
	end
endmodule