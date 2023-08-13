module mux(S, i0, i1, m);
	input i0, i1, S;
	output m;
	
	not n(nout, S);
	and a1(aout1, i0, nout);
	and a2(aout2, i1, S);
	or o1(m, aout1, aout2);
endmodule

module my7bit21mux(sel, in0, in1, f);
	input sel;
	input [6:0] in0, in1;
	output [6:0] f;
	
	mux m1[6:0](sel,in0,in1,f);
endmodule

module CONNECT(sel,in0,in1,LEDR,HEX0);
	input[3:0] sel;
	input[6:0] in0,in1;
	output[6:0] LEDR;
	output[6:0] HEX0;
	wire[6:0] temp;
	
	my7bit21mux m1(~sel[3],in0,in1,temp);
	assign LEDR = temp;
	assign HEX0 = ~temp;
endmodule

module Selector(KEY,SW,LEDR,HEX0);
	input[3:0] KEY;
	input [17:0] SW;
	output [6:0] LEDR;
	output [6:0] HEX0;
	CONNECT inst1(KEY, SW[16:10], SW[6:0], LEDR, HEX0);
endmodule
	