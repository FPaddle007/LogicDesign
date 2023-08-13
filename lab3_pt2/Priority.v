module Priority(fb,lb,rb,bb,ls,rs,lw,rw);
	input fb,lb,rb,bb;
	input [2:0] ls,rs;
	output [2:0] lw,rw;
	wire [2:0] lwa, lwb, rwa, rwb;
	
	BumperLogic BL(fb,lb,rb,bb,lwa,rwa);
	SensorLogic SL(ls,rs,lwb,rwb);
	
	assign lw = fb|lb|rb|bb ? lwa : lwb;
	assign rw = fb|lb|rb|bb ? rwa : rwb;
endmodule


module WheelDisplay(wheel, SEG);
	input [2:0] wheel;
	output [6:0] SEG;
		parameter [6:0] S = 7'b0010010;
		parameter [6:0] F = 7'b0001110;
		parameter [6:0] R = 7'b0101111;
	assign SEG[6:0] = wheel[2] ? R : (wheel[1] ? F : S);
endmodule