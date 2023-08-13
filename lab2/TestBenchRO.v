`timescale 1ns/1ns

module RingOsc();
	reg enable;
	parameter N = 7;
	parameter notDELAY=2;
	parameter norDELAY=4;
	wire[N:1] Waveform;
	
	genvar i;
	generate
		for (i=1; i<N; i=i+1)
			begin : notGates
				not #notDELAY notGate(Waveform[i+1], Waveform[i]);
			end
		nor #norDELAY norGate(Waveform[1], Waveform[N], enable);
	endgenerate
	
	initial begin
		enable<=1; #(N*notDELAY+norDELAY);
		enable<=0;
	end
endmodule