module SignExtender(BusImm, Imm25, Ctrl);  //Note that Imm25 is 26 bits!
   output reg [63:0] BusImm; //output port

   input [25:0]  Imm25;  //input port 1. 25 bit works for all types (excludes opcode)

   input [2:0]	 Ctrl; //2 bit control signal
   
   wire 	 extBit; //condition variable
   assign extBit = (Ctrl ? 1'b0 : Imm25[25]); //unsigned or signed. If ctrl = 1/0
   //assign BusImm = {{38{extBit}}, Imm25}; //preforms sign extension
   reg [63:0] shift_bits;	

	always @ (Ctrl, Imm25) begin
		case(Ctrl)
			//I

			3'b000	: BusImm = {{52{1'b0}}, Imm25[21:10]};
			//D

			3'b001	: BusImm = {{55{Imm25[20]}}, Imm25[20:12]};

			//B

			3'b010	: BusImm = {{38{Imm25[25]}}, Imm25}; //38

			//CBZ
			
			3'b011	: BusImm = {{45{Imm25[23]}}, Imm25[23:5]}; //45
			

			3'b111  : 
                                  begin
                                  shift_bits = Imm25[22:21] << 4;
                                  BusImm = Imm25[20:5] << shift_bits;
                                  end
		endcase
	end
	   
endmodule


