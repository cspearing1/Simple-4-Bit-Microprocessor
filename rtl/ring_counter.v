module ring_counter(

    input wire clk,
    input wire pulse,
    input wire rst,
    
    output reg [3:0] timing

    );
    
    always @(posedge clk or posedge rst) begin
        //Reset
        if (rst)
            timing <= 4'b0001;
        
        //Wrap around to T0
        else if (timing == 4'b1000)
            timing <= 4'b0001;
            
        //Go to next state on clk high
        else if (pulse)
            timing <= timing << 1;
    end
endmodule
