module register_4_bit(

    input wire clk,
    input wire rst,
    input wire enable,
    input wire [3:0] data_in,
    output reg [3:0] data_out
    );
    
    always @ (posedge clk or posedge rst)
    //Clear register
        if (rst)
            data_out<=4'b0000;
    //Reading from input                
        else if (enable)    
            data_out <= data_in;
endmodule
