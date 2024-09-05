`timescale 1ns/1ps

module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
    input[4:0] RA, RB, RW; //The registers are 5 bits wide. RA is egister 1, RB is register 2 and RW is the write register 
    input[63:0] BusW; //This is a 64 bit input bus 
    output[63:0] BusA, BusB; //these are 64 bit output buses. These buses simply store data
    input RegWr; //this is the control signal for the register file 
    input Clk;
    
    reg [63:0] registers [31:0]; //these are our 32 register variables that are each 64 bits wide
    
    /*
    initial begin  //executes first and only once 
        registers[31] <= 64'h0; //64 bit wides all set to 0
    end
    */

    assign #2 BusA = (RA == 5'b11111) ? 64'b0 : registers[RA]; //We set BusA to the 64 bit register specified by RA
    assign #2 BusB = (RB == 5'b11111) ? 64'b0 : registers[RB]; //We set BusB to the 64 bit register specified by RB
    
    
    always @(negedge Clk) //executes multiple times 
    begin
        if (RegWr && RW != 31) //register 31 is always 0. We write if the control signal is on
        begin
        registers[RW] <= #3 BusW; //BusW stores the output which we then write to the write register 
        end
    end

endmodule 