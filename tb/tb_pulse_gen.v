`timescale 1ns / 1ps

module tb_pulse_gen;
    reg clk;
    reg rst;
    reg ce;
    
    wire pulse;
    
    pulse_gen uut (
        .clk (clk),
        .rst (rst),
        .ce (ce),
        .pulse (pulse)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        rst = 1;
        #10;
        rst = 0;
        #15;
        
        ce = 1;
        #1;
        ce = 0;

        
    end
endmodule
