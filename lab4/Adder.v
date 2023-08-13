module AddSub4 (A,B,Co,R,Ovf);
	input [3:0] A,B;
	input Co;
	output [3:0] R;
	output Ovf;
	
	wire [4:0] c;			// Carry signals
	assign c[0] = Co;


	FullAdder F0(A[0], B[0]^Co, c[0], R[0], c[1]);

	FullAdder F1(A[1], B[1]^Co, c[1], R[1], c[2]);

	FullAdder F2(A[2], B[2]^Co, c[2], R[2], c[3]);

	FullAdder F3(A[3], B[3]^Co, c[3], R[3], c[4]);

	assign Ovf = c[4]^c[3];
endmodule

module NumDisplay(A,OUT0,OUT1);
	input [3:0] A;
	output [6:0] OUT0, OUT1;

	reg [7:0] TCMag[0:15];
	initial begin
		TCMag[0] = 7'b1000000;	
		TCMag[1] = 7'b1111001; 	
		TCMag[2] = 7'b0100100; 	
		TCMag[3] = 7'b0110000; 	
		TCMag[4] = 7'b0011001; 	
		TCMag[5] = 7'b0010010; 	
		TCMag[6] = 7'b0000010; 	
		TCMag[7] = 7'b1111000; 	
		TCMag[8] = 7'b0000000; 	
		TCMag[9] = 7'b1111000; 	
		TCMag[10] = 7'b0000010;
		TCMag[11] = 7'b0010010;
		TCMag[12] = 7'b0011001;
		TCMag[13] = 7'b0110000;
		TCMag[14] = 7'b0100100;
		TCMag[15] = 7'b1111001;
	end
	
	assign OUT0 = A[3] ? 7'b0111111 : 7'b1111111;
	assign OUT1 = TCMag[A];
endmodule

module DisplayOvf(ovf,OUT);
	input ovf;
	output [6:0] OUT;
	assign OUT = ovf ? 7'b0000110 : 7'b1111111;
endmodule


module Prefix(Ain,Bin,OP,X,Y,Co);
	input [3:0] Ain,Bin;
	input [2:0] OP;
	output [3:0] X,Y;
	output Co;
	
	wire absB,absA,switch;
	assign absB = OP[1]&~OP[2]&Bin[3] ? 1 : 0;
	assign absA = OP[1]&OP[2]&Ain[3] ? 1 : 0;
	assign switch = OP[2]&~OP[1];
	
	
	assign Co = (OP[0]&~OP[1]) | absA | absB ? 1 : 0;
	assign X = ~OP[2]&OP[1] | OP[2]&OP[1] ? 4'b0000 : (switch ? Bin : Ain);
	assign Y = OP[2]&OP[1] ? Ain : (switch ? Ain : Bin);
endmodule
