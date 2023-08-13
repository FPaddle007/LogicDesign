module Calculator(SW,KEY,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7);
	input [7:0] SW;
	input [2:0] KEY;
	output [6:0] HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
	wire [3:0] X,Y,SUM;
	wire Co,ovf;
	
	NumDisplay D1(SW[7:4], HEX7, HEX6);
	NumDisplay D2(SW[3:0], HEX5, HEX4);
	
	Prefix P(SW[7:4], SW[3:0], ~KEY[2:0],X,Y,Co);
	AddSub4 AS(X,Y,Co,SUM,ovf);
	NumDisplay D3(SUM,HEX3,HEX2);
	DisplayOvf D4(ovf,HEX1);
endmodule



