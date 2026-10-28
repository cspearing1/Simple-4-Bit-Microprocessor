module ce_debouncer(

    input wire clk,
    input wire rst,
    input wire btn,
    
    output reg ce

    );
    
    reg [17:0] counter;
    reg btn_stable;
    
    reg btn_previous;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            btn_stable <= 0;
            counter <= 0;
        end
        else if (btn != btn_stable) begin
            if (counter == 18'h3FFFF) begin
                btn_stable <= btn;
                counter  <= 0;
            end
            else begin
                counter <= counter + 1;
            end
        end
        else begin
            counter <= 0;
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            btn_previous <= 0;
            ce <= 0;
        end
        else begin
            btn_previous <= btn_stable;
            ce <= btn_stable & ~btn_previous;
        end
    end

endmodule
