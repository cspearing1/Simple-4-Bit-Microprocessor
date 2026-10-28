`timescale 1ns / 1ps

module tb_alu;

    reg [4:0] a;
    reg [4:0] b;
    reg [3:0] op;
    
    wire [4:0] result;
    
    alu uut (
    
        .a(a),
        .b(b),
        .op(op),
        .result(result)
    
    );    
    
    initial begin
    
        a = 5'b00000;
        b = 5'b00000;
        op = 4'b0000;
        #20;
        
        //test ADD
        a = 5'b00110;
        b = 5'b00110;
        op = 4'b0000;
        #20;
        
        //test SUB
        op = 4'b0001;
        #20;
        
        //test AND
        op = 4'b0010;
        #20;
        
        //test OR
        op = 4'b0011;
        #20;
        
        //test XOR
        op = 4'b0100;
        #20;
        
        //test NOT A
        op = 4'b0101;
        #20;
        
        //test NOT B
        op = 4'b0110;
        #20;
        
        //test PASS A
        op = 4'b0111;
        #20;
        
        //test PASS B
        op = 4'b1000;
        #20;
    
    end
    
    
endmodule
