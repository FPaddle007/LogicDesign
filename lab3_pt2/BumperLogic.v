module BumperLogic(fb,lb,rb,bb,lw,rw);
	input fb,lb,rb,bb;
	output [2:0] lw,rw;
	assign lw[2] = (fb&~lb&~rb&~bb) | (~fb&lb&~rb&~bb) | (fb&lb&~rb&~bb);
	assign lw[1] = (~fb&~lb&~rb&bb) | (~fb&lb&~rb&bb);
	assign lw[0] = (~fb&~lb&rb&~bb) | (fb&~lb&rb&~bb) | (~fb&~lb&rb&bb) | (fb&~lb&~rb&bb) | (~fb&lb&rb&~bb);
	
	assign rw[2] = (fb&~lb&~rb&~bb) | (~fb&~lb&rb&~bb) | (fb&~lb&rb&~bb);
	assign rw[1] = (~fb&~lb&~rb&bb) | (~fb&~lb&rb&bb);
	assign rw[0] = (~fb&lb&~rb&~bb) | (fb&lb&~rb&~bb) | (~fb&lb&~rb&bb) | (fb&~lb&~rb&bb) | (~fb&lb&rb&~bb);
endmodule