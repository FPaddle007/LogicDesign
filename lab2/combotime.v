// Combinational Timing Analysis circuit
`timescale 1ns/1ps
module combotime(a,b,c,d,z);
	input a,b,c,d;
	output z;
	
	nand #(1,2) a2(w,b,c);
	nand #(1,2) a1(x,a,w);
	or #(2.5,5) o1(y,c,d);
	nor #(4,0.5) o2(z,x,y);
endmodule
	
