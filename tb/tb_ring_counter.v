`timescale 1ns / 1ps

module tb_ring_counter;
    
    reg pulse;
    reg clk;
    reg rst;
    
    wire [3:0] timing;
    
    ring_counter uut (
    
        .clk (clk),
        .rst (rst),
        .pulse (pulse),
        .timing (timing)
    
    );
    
    initial begin
        pulse = 0;
        forever #5 pulse = ~pulse;
    end
    
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        rst = 1;
        #10;
        rst = 0;
        #80;
        
        rst = 1;
        #10;
        rst = 0;
    end
    
endmodule
