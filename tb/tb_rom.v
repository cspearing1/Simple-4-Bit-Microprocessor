`timescale 1ns / 1ps

module tb_rom;

    reg [4:0] pc;
    
    wire [3:0] rom_out;
    
    rom uut (
    
        .pc (pc),
        .rom_out (rom_out)
    
    );
    
    initial begin
        pc = 0;
        forever #10 pc <= pc + 5'b00001;
    end
    

endmodule
