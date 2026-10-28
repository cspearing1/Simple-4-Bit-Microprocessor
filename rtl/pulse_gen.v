module pulse_gen(
    input wire clk,
    input wire rst,
    input wire ce,
    output reg pulse
    );
    
    reg running;
    reg [1:0] count;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pulse <= 0;
            running <= 0;
            count <= 0;
        end
        else if (ce & ~running) begin
            running <= 1;
            count <= 0;
            pulse <= 1;
        end
        else if (running) begin
            if (count == 3) begin
                running <= 0;
                pulse <= 0;
                count <= 0;
            end
            else begin
                count <= count + 1;
                pulse <= 1;
            end
        end
    end
endmodule
