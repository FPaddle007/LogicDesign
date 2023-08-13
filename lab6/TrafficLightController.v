module TrafficLightController(SW,KEY,HEX0,HEX1,HEX2,HEX3,HEX7);
input [17:0] SW;
input [3:0] KEY;
output [6:0] HEX0,HEX1,HEX2,HEX3,HEX7;

reg[2:0] s;
reg[2:0] ns;

assign W = SW[0];
assign EL = SW[1];
assign NL = SW[2];
assign E = SW[3];
assign system_reset = SW[17];

reg[6:0] ETL;
reg[6:0] WTL;
reg[6:0] NLTL;
reg[6:0] ELTL;
assign HEX3 = ETL;
assign HEX0 = WTL;
assign HEX2 = NLTL;
assign HEX1 = ELTL;
parameter g = 7'b0010000;
parameter y = 7'b0010001;
parameter r = 7'b0101111;

parameter s0=0;
parameter s1=1;
parameter s2=2;
parameter s3=3;
parameter s4=4;
parameter s5=5;
parameter s6=6;
parameter s7=7;
parameter min=0;
reg [1:0] count;
reg[1:0] counter_reset;

////////////////// Next State ////////////////////
always@* begin
case(s) 
	s0:if(E&W&NL&EL&count==min) ns <= s3;
		else if(EL&count==min) ns<=s7;
		else if(NL&count==min) ns<=s5;
		else if(~E&~W&~NL&~EL&count==min) ns<= s3;
		else ns<=s0;
	s1:if(E&W&NL&EL&count==min) ns<=s5;
		else if(W&count==min) ns<=s4;
		else if(EL&count==min) ns<=s5;
		else if(~E&~W&~NL&~EL&count==min) ns<= s5;
		else ns<=s1;
	s2:if(E&W&NL&EL&count==min) ns<=s6;
		else if((E|W|NL)&count==min) ns<=s6;
		else if(~E&~W&~NL&~EL&count==min) ns<= s6;
		else ns<=s2;
	s3:begin ns<=s1; end
	s4:begin ns<=s0; end
	s5:begin ns<=s2; end
	s6:if(E&W&NL&EL) ns<=s0;
		else if(~W&NL&~EL) ns<=s1;
		else if(~W&NL&EL) ns<=s1;
		else if(~E&~W&~NL&~EL) ns<= s0 ;
		else ns<=s0;
	s7:begin ns<=s2; end
endcase
end

////////////////// Output ////////////////////
always@* begin 
case(s) 
	s0:begin ETL=g;
		WTL=g;
		NLTL=r;
		ELTL=r;
		counter_reset=0;
		end
	s1:begin ETL=g;
		WTL=r;
		NLTL=g;
		ELTL=r;
		//counter reset output logic
		counter_reset=0;
		end
	s2:begin ETL=r;
		WTL=r;
		NLTL=r;
		ELTL=g;
		//counter reset output logic
		counter_reset=0;
		end
	s3:begin ETL=g;
		WTL=y;
		NLTL=r;
		ELTL=r;
		counter_reset=1;
		end
	s4:begin ETL=g;
		WTL=r;
		NLTL=y;
		ELTL=r;
		counter_reset=1;
		end
	s5:begin ETL=y;
		WTL=r;
		NLTL=y;
		ELTL=r;
		counter_reset=1;
		end
	s6:begin ETL=r;
		WTL=r;
		NLTL=r;
		ELTL=y;
		counter_reset=1;
		end
	s7:begin ETL=y;
		WTL=y;
		NLTL=r;
		ELTL=r;
		counter_reset=1;
		end
endcase
end

////////////////// State Register ////////////////////
always@(posedge KEY[0]) begin
	if(system_reset)begin
	s<=s0;
	count<=3;
	end
	else s<=ns;

//timer
	if(counter_reset) count<=3;
	else if (~counter_reset&count!=0) count<=count-1;
	else count<=0;
	end
	NumDisplay(count,HEX7);
endmodule

module NumDisplay(A,OUT0);
	input [2:0] A;
	output [6:0] OUT0;

	reg [7:0] TCMag[0:3];
	initial begin
		TCMag[0] = 7'b1000000;	
		TCMag[1] = 7'b1111001; 	
		TCMag[2] = 7'b0100100; 	
		TCMag[3] = 7'b0110000; 	
	end
	
	assign OUT0 = TCMag[A];
endmodule

// Ask about how counter is working
// ask about how state register plays into that
// figure out counter reset output logic (probably pretty much what u have in state diagram














