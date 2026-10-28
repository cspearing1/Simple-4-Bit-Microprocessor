module program_counter(

    input wire clk,
    input wire rst,
    input wire enable,
    
    output reg [4:0] pc

    );
    
    always @(posedge clk or posedge rst)
        // Reset
        if (rst) 
            pc <= 5'b00000;
        
        // Add 1 to PC
        else if (enable)
            pc <= pc + 5'b00001;
endmodule
