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

// State transitions
always @* begin
    case (s)
        s0: if (E & W & NL & EL & count == min) ns <= s3;
            else if (EL & count == min) ns <= s7;
            else if (NL & count == min) ns <= s3;
            else if (~E & ~W & ~NL & ~EL & count == min) ns <= s3;
            else ns <= s0;
        s1: if (E & W & NL & EL & count == min) ns <= s5;
            else if (W & count == min) ns <= s4;
            else if (EL & count == min) ns <= s5;
            else if (~E & ~W & ~NL & ~EL & count == min) ns <= s5;
            else ns <= s1;
        s2: if (E & W & NL & EL & count == min) ns <= s6;
            else if ((E | W | NL) & count == min) ns <= s6;
            else if (~E & ~W & ~NL & ~EL & count == min) ns <= s6;
            else ns <= s2;
        s3: if (count == min) ns <= s1;
            else ns <= s3;
        s4: if (count == min) ns <= s0;
            else ns <= s4;
        s5: if (count == min) ns <= s2;
            else ns <= s5;
        s6: begin
            if (E | W | NL | EL) ns <= s0; // Conflicting traffic detected, transition to grrg
            else if (count == min) ns <= s0; // No conflicting traffic, transition to grgg
            else ns <= s6; // Stay in s6 until the timer expires
        end
        s7: if (count == min) ns <= s2;
            else ns <= s7;
    endcase
end

// Output logic
always @* begin
    case (s)
        s0: begin
            WTL = g;
				ELTL = r;
				NLTL = r;
				ETL = g;
            
            counter_reset = 0;
        end
        s1: begin
            WTL = r;
				ELTL = r;
				NLTL = g;
				ETL = g;       
            
            counter_reset = 0;
        end
        s2: begin
            WTL = r;
				ELTL = g;
				NLTL = r;
				ETL = r;
				
            counter_reset = 0;
        end
        s3: begin
            WTL = y;
				ELTL = r;
				NLTL = r;
				ETL = g;

            counter_reset = 1;
        end
        s4: begin
            WTL = r;
				ELTL = r;
				NLTL = y;
				ETL = g;
				
            counter_reset = 1;
        end
        s5: begin
            WTL = r;
				ELTL = r;
				NLTL = y;
				ETL = y;
				
            counter_reset = 1;
        end
        s6: begin
            WTL = r;
				ELTL = y;
				NLTL = r;
				ETL = r;

            counter_reset = 1;
        end
        s7: begin
            WTL = y;
				ELTL = r;
				NLTL = r;
				ETL = y;
				
            counter_reset = 1;
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
