module alu(

    //inputs
    input wire [7:0] a,
    input wire [7:0] b,
    input wire [3:0] op,
    
    //outputs 
    output reg [7:0] result

    );
    
    
    always @(*) begin
        case(op)
            4'b0000: result = a + b; //ADD
            4'b0001: result = a - b; //SUB
            4'b0010: result = a & b; //AND
            4'b0011: result = a | b; //OR
            4'b0100: result = a ^ b; //XOR
            4'b0110: result = ~b;    //NOT B
            4'b1000: result = b;     //PASS MUX
            default: result = 8'b00000000;
        endcase
    end    
    
endmodule
