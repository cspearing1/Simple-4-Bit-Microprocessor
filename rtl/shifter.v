module shifter(
    
    input wire clk,
    input wire rst,
    input wire enable,
    input wire load,
    input wire shift_dir,
    input wire [7:0] data_in,
    //input wire save_flag,
    
    output reg [7:0] data_out,
    //output reg saved_flag
    output reg flag

    );
    
    //reg flag;
    
    always @(posedge clk or posedge rst) begin
            // Reset
        if (rst) begin
            data_out <= 8'b00000000;
            flag = 0;
        end
        // Load Shifter
        else if (load ==1) begin
            data_out <= data_in;
        end
        //Shift Right
        else if (shift_dir == 0 && enable  == 1) begin
            flag <= data_out[0];
            data_out <= data_out >> 1;
        end
        //Shift Left
        else if (shift_dir == 1 && enable ==1) begin
            //flag <= data_out[3];
            data_out <= data_out << 1;
        end   
    end
    
    //always @(posedge clk or posedge rst) begin
    //    if (rst) begin
    //        flag <= 1'b0;
    //        saved_flag <= 0;
    //    end
    //            //Flag store
    //    else if (save_flag) 
    //       saved_flag <= flag;
    //    end
        
endmodule
