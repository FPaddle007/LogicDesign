// Figure 1 circuit 
`timescale 1ns/1ps
module TestBench();
	reg a,b,c,d;
	wire z;
	
	combotime C(a,b,c,d,z);
	initial begin
	a=0; b=0; c=0; d=0; #20;
	a=1; b=0; c=0; d=0; #20;	
	a=0; b=0; c=0; d=0; #20;	

	a=1; b=1; c=0; d=0; #20;	
	a=1; b=1; c=1; d=0; #20;	
	a=1; b=1; c=0; d=0; #20;
	
	a=1; b=0; c=0; d=0; #20;	
	a=1; b=0; c=0; d=1; #20;	
	a=1; b=0; c=0; d=0; #20;
	end
endmodule
	