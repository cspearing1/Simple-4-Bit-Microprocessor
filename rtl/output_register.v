module output_register(

    input wire clk,
    input wire rst,
    input wire enable,
    input wire [7:0] data_in,
    output reg [7:0] data_out
    );
    
    always @ (posedge clk or posedge rst) begin
    //Clear register
        if (rst)
            data_out<=8'b00000000;
    //Reading from input                
        else if (enable)    
            data_out <= data_in;
    end
endmodule
