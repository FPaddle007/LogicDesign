`timescale 1ns/1ns
module TestBench();
	reg [2:0] SW;
	wire [6:0] HEX0, HEX1;
	
	Robbie R(SW, HEX1, HEX0);
	initial begin
		SW = 3'b000;#5;
		SW = 3'b010;#5;
		SW = 3'b101;#5;
		SW = 3'b011;#5;
		SW = 3'b110;#5;
		SW = 3'b111;#5;
		SW = 3'b100;#5;
		SW = 3'b001;#5;
	end
endmodule