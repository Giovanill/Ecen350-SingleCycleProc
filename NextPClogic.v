`timescale 1ns / 1ps

module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
       input [63:0] CurrentPC, SignExtImm64;  //SignExtImm64 is the output of our sign extender module. CurrentPC is the current address of the program counter
       input Branch, ALUZero, Uncondbranch; //These are our control signals related to branches 
       output reg [63:0] NextPC; //this is the next Porgram counter address
       
       /* write your code here */ 
       always @ (*) 
       begin
            if (Uncondbranch) //this is the unconditional branch condition  
            begin
            NextPC = CurrentPC + SignExtImm64 * 4; //The nextPC in this case is the SignExtImm64 shifted left 2 + current pc
            end
            
            else if (Branch && ALUZero) //This is the conditional branch condition 
            begin
            NextPC = CurrentPC + SignExtImm64 * 4; //this is the other condtion in the or gate
            end
            
            else //This is the case where we dont branch 
            begin 
            NextPC = CurrentPC + 4;
            end
            
       end
endmodule
