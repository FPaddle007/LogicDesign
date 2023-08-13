module SensorLogic(ls,rs,lw,rw);
	input [2:0] ls, rs;
	output [2:0] lw, rw;
	wire leftfwd,rightfwd,eqZL,eqZR,eq,eqNZ,gT;
	
	equalTo eq1(ls,rs,eq);
	greaterThan g(ls,rs,gT);
	equalTo eq2(ls,3'b000,eqZL);
	equalTo eq3(rs,3'b000,eqZR);
	assign eqNZ = eq&~eqZL&~eqZR;
	assign leftfwd = eq&eqNZ | (~gT&~eq);
	assign rightfwd = eq&eqNZ | gT;
	
	assign lw[2] = 0;
	assign lw[1] = leftfwd;
	assign lw[0] = ~leftfwd;
	assign rw[2] = 0;
	assign rw[1] = rightfwd;
	assign rw[0] = ~rightfwd;
endmodule