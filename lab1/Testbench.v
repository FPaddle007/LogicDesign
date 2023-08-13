`timescale 1 ns/1 ns

module Testbench();
	reg [17:0]SW;
	reg [3:0]KEY;
	wire[6:0]LEDR,HEX0;
	
	Selector s(KEY,SW,LEDR,HEX0);
	initial begin
		KEY[3]=0;SW[10]=0;SW[0]=0;#5;
		KEY[3]=0;SW[10]=0;SW[0]=1;#5;
		KEY[3]=0;SW[10]=1;SW[0]=0;#5;
		KEY[3]=0;SW[10]=1;SW[0]=1;#5;
		KEY[3]=1;SW[10]=0;SW[0]=0;#5;
		KEY[3]=1;SW[10]=0;SW[0]=1;#5;
		KEY[3]=1;SW[10]=1;SW[0]=0;#5;
		KEY[3]=1;SW[10]=1;SW[0]=1;#5;
	end
endmodule
		