module greaterThan(a,b,out);
	input [2:0] a,b;
	output out;
	
	assign out = a[2]&~b[2] | 
					(a[2]~^b[2]) & (a[1]&~b[1]) | 
					(a[2]~^b[2]) & (a[1]~^b[1]) & (a[0]&~b[0]);
endmodule


module equalTo(a,b,out);
	input [2:0] a,b;
	output out;
	
	assign out = (a[2]~^b[2]) & (a[1]~^b[1]) & (a[0]~^b[0]);
endmodule