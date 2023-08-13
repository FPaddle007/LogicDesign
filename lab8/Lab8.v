module Lab8(SW,KEY,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7,LEDG,CLOCK_50);
input [17:0] SW;
input [3:0] KEY;
input CLOCK_50;
output [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7;
output [8:0] LEDG;
wire [36:0] clock;
wire [10:0] total;
Clock_Div CD(CLOCK_50,clock);


FourFuncCalc Calc(clock[22],SW[17]&~KEY[0],SW[17]&~KEY[3],~SW[17]&~KEY[3],~SW[17]&~KEY[2],~SW[17]&~KEY[1],~SW[17]&~KEY[0],SW[10:0],total,LEDG[0]);
Binary_to_7SEG Result1(total,1,HEX3,HEX2,HEX1,HEX0);
Binary_to_7SEG Number1(SW[10:0],0,HEX7,HEX6,HEX5,HEX4);

endmodule