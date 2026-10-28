`timescale 1ns / 1ps

module tb_bit_4_register;

    //Inputs
    reg clk;
    reg rst;
    reg enable;
    reg [3:0] data_in;
    
    //Outputs
    wire [3:0] data_out;
    
    
    //Initate unit
    register_4_bit uut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .data_in(data_in),
        .data_out(data_out)
    );
    
    //Initialise clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
    //Initalise inputs
    rst=0;
    enable = 0;
    data_in = 4'b0000;
    
    
    #20
    
    //Test data_in without enable
    data_in = 4'b0011;
    #10;
    rst = 1;
    #10;
    rst = 0;
    #10;
    
    //Test rst
    data_in = 4'b1111;
    enable = 1;
    #10;
    enable = 0;
    #10;
    rst = 1;
    #10;
    rst = 0;
    
    end
    
    
endmodule
