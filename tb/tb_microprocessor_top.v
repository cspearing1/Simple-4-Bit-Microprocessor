    `timescale 1ns / 1ps
    
    module tb_microprocessor_top;
    
        reg clk;
        reg CPU_RESETN;
        reg [3:0] switches;
        reg btn;
        
        wire [7:0] leds;
        
        microprocessor_top uut (
            .clk (clk),
            .btn (btn),
            .CPU_RESETN (CPU_RESETN),
            .switches (switches),
            .leds (leds)
        );
        
        initial begin
            clk = 0;
            forever #5 clk = ~clk;
        end
            
    always @(posedge clk) begin
        if (uut.control_unit.pc_out == 28 && uut.control_unit.timing[3] == 1) begin
            $display("A = %0d", uut.datapath.a_out);
            $display("B = %0d", uut.datapath.b_out);
            $display("Result = %0d", leds);
            //$finish;
        end
    end
    always @(posedge clk) begin
    if (uut.ce) begin
        $display("ce pulse | timing=%b | pc=%0d | pc_enable=%b",
            $time,
            uut.control_unit.timing,
            uut.control_unit.pc_out,
            uut.control_unit.pc_enable);
    end
    end
    
    initial begin
        CPU_RESETN = 0;
        btn = 0;
        switches = 4'b0000;
        #10;
        CPU_RESETN = 1;
        #10;
        
        // CLR ACC (instruction 0)
        btn = 1; #10000000; btn = 0; #10000000;
        
        // LD A (instruction 1)
        switches = 4'b1111;  // A = 12
        btn = 1; #10000000; btn = 0; #10000000;
        
        // LD B (instruction 2)
        switches = 4'b1010;  // B = 2
        btn = 1; #10000000; btn = 0; #10000000;
        
        // instructions 3-28
        repeat(26) begin
            btn = 1; #10000000; btn = 0; #10000000;
        end
    end
    endmodule
