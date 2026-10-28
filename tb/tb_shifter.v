`timescale 1ns / 1ps

module tb_shifter;
    
    reg clk;
    reg rst;
    reg enable;
    reg load;
    reg shift_dir;
    reg [3:0] data_in;
    
    wire [3:0] data_out;
    wire flag;
    
    shifter uut(
        
        .clk (clk),
        .rst (rst),
        .enable (enable),
        .load (load),
        .shift_dir(shift_dir),
        .data_in(data_in),
        .data_out(data_out),
        .flag(flag)
    
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

     always @(posedge clk or posedge rst) begin
        
        rst = 1;
        #10;
        rst = 0;
        #10;
        
        shift_dir = 0;
        data_in = 4'b0000;
        #20;
        
        //Test Shift Left
        data_in = 4'b1100;
        load = 1;
        shift_dir = 1;
        #10;
        load = 0;
        enable = 1;
        #10;
        enable = 0;
        
        //Test Shift Right
        data_in = 4'b0011;
        load = 1;
        shift_dir = 0;
        #10;
        load = 0;
        enable = 1;
        #10;
        enable = 0;
    end
    

endmodule
