`timescale 1ns / 1ps

module tb_microprocessor_top_custom;
    
        reg clk;
        reg CPU_RESETN;
        reg [3:0] switches;
        reg btn;
        
        wire [7:0] leds;
        
        microprocessor_top uut (
            .clk (clk),
            .btn (btn),
            .CPU_RESETN (CPU_RESETN),
            .switches (switches),
            .leds (leds)
        );
        
        initial begin
            clk = 0;
            forever #5 clk = ~clk;
        end
        
        initial begin
            switches = 4'b0000;
            btn = 0;
            CPU_RESETN = 0;
            #10;
            CPU_RESETN = 1;
            //ADD
            switches = 4'b1011;
            #10;
            btn = 1;
            #10000000;
            btn = 0;
            #10000000;
            btn = 1;
            #10000000;
            btn = 0;
            #10000000;
            btn = 1;
            #10000000;
            btn = 0;
            #10000000;
            switches = 4'b0111;
            #10;
            btn = 1;
            #10000000;
            btn = 0;
            #10000000;
            btn = 1;
            #10000000;
            btn = 0;
            #10000000;
            btn = 1;
            #10000000;
            btn = 0;
            #10000000;
            
            //AND
            switches = 4'b1111;
            #10;
            btn = 1;
            #10000000;
            btn = 0;
            #10000000;
            btn = 1;
            #10000000;
            btn = 0;
            #10000000;
            btn = 1;
            #10000000;
            btn = 0;
            #10000000;
            switches = 4'b0101;
            #10;
            btn = 1;
            #10000000;
            btn = 0;
            #10000000;
            btn = 1;
            #10000000;
            btn = 0;
            #10000000;
            btn = 1;
            #10000000;
            btn = 0;
            #10000000;
            
            //XOR
            switches = 4'b1011;
            #10;
            btn = 1;
            #10000000;
            btn = 0;
            #10000000;
            btn = 1;
            #10000000;
            btn = 0;
            #10000000;
            btn = 1;
            #10000000;
            btn = 0;
            #10000000;
            switches = 4'b0001;
            #10;
            btn = 1;
            #10000000;
            btn = 0;
            #10000000;
            btn = 1;
            #10000000;
            btn = 0;
            #10000000;
            btn = 1;
            #10000000;
            btn = 0;
            #10000000;
            #10000000;
        end
endmodule
