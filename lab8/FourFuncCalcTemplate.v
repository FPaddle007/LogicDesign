// EECS 270																	TO DO: COPY TESTBENCH IN BOOTHMUL OVER TO TESTBENCH, TEST MULTIPLIER WITH TESTBENCH, SHOW MULTIPLICATION ONCE WORKING, DIVISION
// Lab 7:Four-Function Calculator Template
module FourFuncCalc
	#(parameter W = 11)			// Default bit width
	(Clock, Clear, Equals, Add, Subtract, Multiply, Divide, Number, Result, Overflow,State);
	localparam WW = 2 * W;		// Double width for Booth multiplier
	//localparam BoothIter = $clog2(W);	// Width of Booth Counter
	input Clock;
	input Clear;				// C button
	input Equals;				// = button: displays result so far; does not repeat previous operation
	input Add;					// + button
	input Subtract;				// - button
	input Multiply;				// x button (multiply)
	input Divide;				// / button (division quotient)
	input [W-1:0] Number; 			// Must be entered in sign-magnitude on SW[W-1:0]
	output signed [W-1:0] Result;		// Calculation result in two's complement
	output Overflow;				// Indicates result can't be represented in W bits
	output [4:0] State;

  
//****************************************************************************************************
// Datapath Components
//****************************************************************************************************


//----------------------------------------------------------------------------------------------------
// Registers
// For each register, declare it along with the controller commands that
// are used to update its state following the example for register A
//----------------------------------------------------------------------------------------------------
	
	reg signed [W-1:0] A;			// Accumulator
	wire CLR_A, LD_A;			// CLR_A: A <= 0; LD_A: A <= Q
	reg signed [W-1:0] N_TC;
	wire CLR_N_TC, LD_N_TC;

  
//----------------------------------------------------------------------------------------------------
// Number Converters
// Instantiate the three number converters following the example of SM2TC1
//----------------------------------------------------------------------------------------------------

	wire signed [W-1:0] NumberTC;	// Two's complement of Number
	SM2TC #(.width(W)) SM2TC1(Number, NumberTC);

	
//----------------------------------------------------------------------------------------------------
// Adder/Subtractor 
//----------------------------------------------------------------------------------------------------
	wire signed [W-1:0] Y1;
	wire signed [W-1:0] Y2;
	wire c0;					// 0: Add, 1: Subtract
	wire ovf;				// Overflow
	wire [W-1:0] R;
	AddSub #(.W(W)) AddSub1(Y1, Y2, c0, R, ovf);
	wire PSgn = R[W-1] ^ ovf;		// Corrected P Sign on Adder/Subtractor overflow
//----------------------------------------------------------------------------------------------------


//----------------------------------------------------------------------------------------------------
// Multiplier
//----------------------------------------------------------------------------------------------------					
	localparam BoothIter = $clog2(W);	// Width of Booth counter
	wire signed [W-1:0] M;						// Multiplier
	wire signed [WW:W+1] P;					// Product

	
	// Datapath Components
	reg signed [WW:0] PM;						// Product/Multiplier double register
	wire M_LD;												// Load multiplier
	wire P_LD;												// Load product
	wire PM_ASR;											// Arithmetic Shift Right of PM

	reg [BoothIter-1:0] CTR;					// Iteration counter
	wire CTR_DN;											// Count down
	
//----------------------------------------------------------------------------------------------------
// MUXes
// Use conditional assignments to create the various MUXes
// following the example for MUX Y1
//----------------------------------------------------------------------------------------------------
	///////////////////////////////////////////////NOT ADDER//////////////////////////////////////
	
	//wire SEL_D;
	wire signed [W-1:0] Y3;
	assign Y3 = A;				//SEL_D ? D[W-1:0]:A
	
	wire SEL_P;									
	assign Y1 = SEL_P ? PM[WW:W+1] : Y3;	// 1: Y1 = P; 0: Y1 = Y3

	assign Y2 = N_TC;		// SEL_D ? N_SM : N_TC
	
	wire SEL_M;
	wire signed [W-1:0] Y4;
	assign Y4 = SEL_M ? PM[W:1] : R;
	
	wire SEL_Q;
	wire signed [W-1:0] Y5;
	assign Y5 = Y4;		// SEL_Q ? Q_TC : Y4;
	
	wire SEL_N;
	wire signed [W-1:0] Y6;
	assign Y6 = SEL_N ? Y2 : Y5;
	

//****************************************************************************************************
/* Datapath Controller
   Suggested Naming Convention for Controller States:
     All names start with X (since the tradtional Q connotes quotient in this project)
     XAdd, XSub, XMul, and XDiv label the start of these operations
     XA: Prefix for addition states (that follow XAdd)
     XS: Prefix for subtraction states (that follow XSub)
     XM: Prefix for multiplication states (that follow XMul)
     XD: Prefix for division states (that follow XDiv)
*/
//****************************************************************************************************


//----------------------------------------------------------------------------------------------------
// Controller State and State Labels
// Replace ? with the size of the state registers X and X_Next after
// you know how many controller states are needed.
// Use localparam declarations to assign labels to numeric states.
// Here are a few "common" states to get you started.
//----------------------------------------------------------------------------------------------------

	reg [7:0] X, X_Next;

	// Addition only
	localparam XInit = 'd0;	// Power-on state (A == 0)
	localparam XLoadNTC1 = 'd1;		// Pick numeric assignments
	localparam XLoadA1	= 'd2;
	localparam XResult = 'd3;
	localparam XNextNumAdd = 'd4;
	localparam XLoadNTC2 = 'd5;
	localparam XLoadA2 = 'd6;
	localparam XOvf = 'd7;
	localparam XClear	= 'd8;
	localparam XNextNumSub = 'd9;
	localparam XLoadNTC3 = 'd10;
	localparam XLoadA3 = 'd11;
	localparam XNextNumMult = 'd12;
	localparam XLoadNTC4= 'd13;
	localparam XCheck = 'd14;
	localparam XAdd = 'd15;
	localparam XSub = 'd16;
	localparam XMore = 'd17;
	localparam XDone = 'd18;
	localparam XNext = 'd19;


//----------------------------------------------------------------------------------------------------
// Controller State Transitions
// This is the part of the project that you need to figure out.
// It's best to use ModelSim to simulate and debug the design as it evolves.
// Check the hints in the lab write-up about good practices for using
// ModelSim to make this "chore" manageable.
// The transitions from XInit are given to get you started.
//----------------------------------------------------------------------------------------------------
	always @*
	case (X)
		XInit:if(Clear)
					X_Next <= XInit;
				else if (Equals)
					X_Next <= XLoadNTC1;
				else if (Add)
					X_Next <= XNextNumAdd;
				else if (Subtract)
					X_Next <= XNextNumSub;
				else if (Multiply)
					X_Next <= XNextNumMult;
				else
					X_Next <= XInit;
					
		XLoadNTC1:begin X_Next<=XLoadA1; end
		XLoadA1: begin X_Next<=XResult; end
		XResult:if(Clear)
						X_Next<=XClear;
					else if(Add)
						X_Next<=XNextNumAdd;
					else if(Subtract)
						X_Next<=XNextNumSub;
					else if(Multiply)
						X_Next<=XNextNumMult;
					else
						X_Next<=XResult;
		XNextNumAdd:if(Clear)
							X_Next<=XInit;
						else if(Equals)
							X_Next<=XLoadNTC2;
						else
							X_Next<=XNextNumAdd;
		XLoadNTC2:begin X_Next<=XLoadA2; end
		XLoadA2:if(~ovf)
						X_Next<=XResult;
						else
						X_Next<=XOvf;
		XOvf:if(Clear)
					X_Next<=XInit;
				else
					X_Next<=XOvf;
		XClear:begin X_Next<=XInit; end
		XNextNumSub:if(Clear)
							X_Next<=XInit;
						else if(Equals)
							X_Next<=XLoadNTC3;
						else
							X_Next<=XNextNumSub;
		XLoadNTC3:begin X_Next<=XLoadA3;end
		XLoadA3:if(~ovf)
						X_Next<=XResult;
					else
						X_Next<=XOvf;
		XNextNumMult:if(Clear)
							X_Next<=XInit;
						 else if(Equals)
							X_Next<=XLoadNTC4;
					    else
							X_Next<=XNextNumMult;
		XLoadNTC4:begin X_Next<=XCheck; end
		XCheck:if (~PM[1] & PM[0])
					X_Next<=XAdd;
				 else if(PM[1] & ~PM[0])
					X_Next<=XSub;
				 else
					X_Next<=XNext;
		XMore:if(CTR=='d0)
					X_Next<=XDone;
				else 
					X_Next<=XCheck;
		XDone:begin X_Next<=XResult;end
		XNext:begin X_Next<=XMore;end
		XAdd:begin X_Next<=XNext;end
		XSub:begin X_Next<=XNext;end
	endcase
  
  
//----------------------------------------------------------------------------------------------------
// Initial state on power-on
// Here's a freebie!
//----------------------------------------------------------------------------------------------------

	initial begin
		X <= XClear;
		A <= 'd0;
		N_TC <= 'd0;
		PM <= 'd0;
		CTR <= W;
		
		////////////////////////////////////////////////////NOT ADDER///////////////////////
		/*
		N_SM <= 'd0;
		MCounter <= W;		//BoothIter'dW;
		PM <= 'd0;      			//WW+1'd0;
		*/
	end


//----------------------------------------------------------------------------------------------------
// Controller Commands to Datapath
// No freebies here!
// Using assign statements, you need to figure when the various controller
// commands are asserted in order to properly implement the datapath
// operations.
//----------------------------------------------------------------------------------------------------
assign c0 = (X==XNextNumSub) | (X==XLoadNTC3) | (X==XLoadA3) | (X==XSub);
assign CLR_N_TC = (X==XClear);
assign CLR_A = (X==XClear);
assign LD_N_TC = (X==XLoadNTC1) | (X==XLoadNTC2) | (X==XLoadNTC3) | (X==XLoadNTC4);
assign LD_A = (X==XLoadA1) | (X==XLoadA2) | (X==XLoadA3) | (X==XDone);
assign SEL_D=0;
assign SEL_P=(X==XLoadNTC4) | (X==XNextNumMult) | (X==XCheck) | (X==XDone) | (X==XNext) | (X==XAdd) | (X==XSub);
assign SEL_M=(X==XLoadNTC4) | (X==XNextNumMult) | (X==XCheck) | (X==XDone) | (X==XNext) | (X==XAdd) | (X==XSub);
assign SEL_Q=0;
assign SEL_N=0;
assign M_LD	= (X == XLoadNTC4);
assign P_LD	= (X == XAdd) | (X == XSub);
assign PM_ASR 	= (X == XNext);
assign CTR_DN 	= (X == XNext);
assign AllDone	= (X == XDone);

//----------------------------------------------------------------------------------------------------  
// Controller State Update
//----------------------------------------------------------------------------------------------------

	always @(posedge Clock)
		if (Clear)
			X <= XClear;
		else
			X <= X_Next;

      
//----------------------------------------------------------------------------------------------------
// Datapath State Update
// This part too is your responsibility to figure out.
// But there is a hint to get you started.
//----------------------------------------------------------------------------------------------------
	wire signed [W:0] ZERO; 					// (W+1)-bit 0 since `(W+1)'d0 does not work
	assign ZERO = 'd0;
	always @(posedge Clock)
	begin
		N_TC <= LD_N_TC ? NumberTC : N_TC;
		A <= CLR_A ? 0 : (LD_A ? Y6 : A);
			if (Clear)
				begin
					PM[WW:W+1] <= 'd0;			// CHANGED THIS ONE SINCE MODELSIM
					PM[0] <= 0;
					CTR <= W;
				end
			else
				begin
					PM <=
						(M_LD? $signed({ZERO, A, 1'b0}) :				// Load A
							(P_LD ? $signed({PSgn, R, PM[W:0]}) :	// Add/Sub
								(PM_ASR ? PM >>> 1 :								// ASR
								 PM																	// Unchanged
								)        
							)
						);
					CTR <= M_LD ? W : (CTR_DN ? CTR - 1 : CTR);
				end
	end

 
//---------------------------------------------------------------------------------------------------- 
// Calculator Outputs
// The two outputs are Result and Overflow, get it?
//----------------------------------------------------------------------------------------------------
	assign P = AllDone? PM[WW:1] : 'd0;
	assign Result = A;
	assign Overflow = (X==XOvf);
	assign State = X;
endmodule