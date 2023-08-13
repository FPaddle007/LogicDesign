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

module Robbie_Display(action, SEG);
	input action;
	output [6:0] SEG;
		parameter [6:0] S = 7'b0010010;
		parameter [6:0] F = 7'b0001110;
	my7bit21mux m1(action, S, F, SEG);
endmodule
		
module Robbie_Controller(ls,fs,rs,lwa,rwa);
	input ls,fs,rs;
	output lwa,rwa;
	
	or left_wheel(lwa,fs,rs);
	or right_wheel(rwa,ls,fs);
endmodule