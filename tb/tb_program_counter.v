`timescale 1ns / 1ps

module tb_program_counter;

    reg clk;
    reg rst;
    reg enable;
    
    wire [4:0] pc;
    
    program_counter uut (
    
        .clk (clk),
        .rst (rst),
        .enable (enable),
        .pc (pc)
    
    );
    
    initial begin
        clk = 0;
        forever #5 clk <= ~clk;
    end
    
    initial begin
        rst = 1;
        #10;
        rst = 0;
        #100;
        
        rst = 1;
        #10;
        rst = 0;
    end
 
endmodule
