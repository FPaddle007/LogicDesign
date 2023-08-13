// Behavioral description of majority of 3 boolean

module MAJ (a,b,c,m);
	input a, b, c;
	output m;
	
	assign m = a && b || a && c || b && c;
endmodule
