`timescale 1ns / 1ps

module tb_mux_2to1;
    //inputs
    reg [3:0] in0;
    reg [3:0] in1;
    reg sel;
    
    //outputs
    wire [3:0] mux_out;
    
    mux_2to1 uut (
        .in0(in0),
        .in1(in1),
        .sel(sel),
        .mux_out(mux_out)
    );
    
    initial begin
    
    in0 = 4'b0000;
    in1 = 4'b0000;
    sel = 0;
    #20;
    
    //test selecting 0
    in0 = 4'b1111;
    #10;
    in1 = 4'b1100;
    #10
    
    //test selecting 1
    sel = 1;
    #10;
    
    
    end
    
    
endmodule
