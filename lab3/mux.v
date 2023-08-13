module mux(i0, i1, S, m);
	input i0, i1, S;
	output m;
	
	not n(nout, S);
	and a1(aout1, i0, nout);
	and a2(aout2, i1, S);
	or o1(m, aout1, aout2);
endmodule