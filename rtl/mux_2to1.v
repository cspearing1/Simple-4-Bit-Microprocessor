module mux_2to1(

    //inputs
    input wire [7:0] in0,
    input wire [7:0] in1,
    input wire sel,
    
    output wire [7:0] mux_out
    

    );
    //If Sel high output = in1 if low output = in0
    assign mux_out = sel ? in1 : in0;
    
endmodule
