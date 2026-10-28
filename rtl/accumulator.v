module accumulator(

    input wire clk,
    input wire rst,
    input wire acc_clear,
    input wire enable,
    input wire [7:0] data_in,
    
    output reg [7:0] data_out
   
    );
    
    always @(posedge clk or posedge rst) begin
    
        if (rst)
            data_out <= 8'b00000000;
        else if (acc_clear)
            data_out <= 8'b00000000;
        else if (enable)
            data_out <= data_in;
        
    end
    
endmodule
