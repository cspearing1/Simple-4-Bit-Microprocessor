`timescale 1ns / 1ps
module tb_ce_debouncer;
    reg clk;
    reg rst;
    reg btn;
    wire ce;
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    ce_debouncer uut(
        .clk (clk),
        .rst (rst),
        .btn (btn),
        .ce (ce)
    );
    
    integer print_count;
    
    initial begin
        print_count = 0;
    end
    
    always @(posedge clk) begin
        if (print_count == 100000) begin
            print_count <= 0;
            $display("t=%0t btn=%b btn_stable=%b counter=%0d ce=%b",
                $time,
                uut.btn,
                uut.btn_stable,
                uut.counter,
                uut.ce);
        end
        else begin
            print_count <= print_count + 1;
        end
    end
    
    initial begin
        rst = 1;
        #10;
        rst = 0;
        #10;
        
        btn = 1;
        #10000000;
        btn = 0;
        #10000000;
        btn = 1;
        #10000000;
        btn = 0;
        #10000000;
        
    end
    
endmodule
