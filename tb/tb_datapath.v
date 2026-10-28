`timescale 1ns / 1ps

module tb_datapath;

    reg clk;
    reg rst;
    reg [3:0] switches;
    
    //control signnals from control unit
    reg ld_a;
    reg ld_b;
    reg ld_o;
    reg mux1_sel;
    reg mux2_sel;
    reg shift_enable;
    reg shift_load;
    reg shift_dir;
    //reg save_flag;
    reg acc_enable;
    reg [3:0] alu_op;
    //outputs
    wire [4:0] leds;
    //wire saved_flag;
    wire flag;
    
    datapath uut (
        
        .clk (clk),
        .rst (rst),
        .switches (switches),
        .ld_a (ld_a),
        .ld_b (ld_b),
        .ld_o (ld_o),
        .mux1_sel (mux1_sel),
        .mux2_sel (mux2_sel),
        .shift_load (shift_load),
        .shift_enable (shift_enable),
        .shift_dir (shift_dir),
        //.//save_flag (//save_flag),
        .acc_enable (acc_enable),
        .alu_op (alu_op),
        
        .leds (leds),
        .flag(flag)
        
    );
   
   //Initialise clock
   initial begin 
        clk = 0;
        forever #5 clk = ~clk;
   end
   
   //tests
   initial begin
        
        //test rst
        #10;
        rst = 1;
        #10
        rst = 0;
        
        //test load A
        switches = 4'b1110;
        ld_a = 1;
        #10;
        ld_a = 0;
        #10;
        
        //test load B
        switches = 4'b0101;
        ld_b = 1;
        #10;
        ld_b = 0;
        #10;
        
        //test ADD
        
        //Pass through input
        alu_op = 4'b1000;
        //Select input Reg A
        mux1_sel = 0;
        mux2_sel = 0;
        //Accumulator takes input A
        #10;
        acc_enable = 1;
        #10;
        acc_enable = 0;
        #10;
        //Selects input Reg B
        mux1_sel = 1;
        //Adds inputs
        alu_op = 4'b0000;
        //Accumulator takes final value
        #10;
        acc_enable = 1;
        #10;
        acc_enable = 0;
        #10;
        //Load accumulator to output register
        ld_o = 1;
        #10;
        ld_o = 0;
        #10;
        
        //reset before next test
        rst = 1;
        #10;
        rst = 0;
        #10;
        
        // Multiplication test
        
        //0 Load A
        switches = 4'b0100;
        ld_a = 1;
        #10;
        ld_a = 0;
        #10;
        $display("A = %0d", uut.a_out);
        
        //1 Load B
        switches = 4'b0101;
        ld_b = 1;
        #10;
        ld_b = 0;
        #10;
        $display("B = %0d", uut.b_out);
        
        //2 Load B into shifter
        mux1_sel = 1;
        shift_load = 1;
        #10;
        shift_load = 0;
        #10;
        $display("Step 2 - after LD SH B: shifter=%b", uut.shift_unit.data_out);
        
        //3 Shift B Right once
        shift_dir = 0;
        shift_enable = 1;
        #10;
        shift_enable = 0;
        #10;
        $display("Step 3 - after SHR: shifter=%b flag=%b", uut.shift_unit.data_out, flag);
        
        //4 ACC NZ A - check flag
        mux1_sel = 0;
        mux2_sel = 0;
        #10;
        if (flag == 1) begin
            alu_op = 4'b0000;
            acc_enable = 1;
            #10;
            acc_enable = 0;
            #10;
        end
        else begin
            #10;
        end
        $display("Step 4 - after ACC NZ A: acc=%b(%0d) flag=%b", uut.acc_out, uut.acc_out, flag);
        
        //5 Shift B Right once
        shift_dir = 0;
        shift_enable = 1;
        #10;
        shift_enable = 0;
        #10;
        $display("Step 5 - after SHR: shifter=%b flag=%b", uut.shift_unit.data_out, flag);
        
        //6 Load A into shifter
        mux1_sel = 0;
        shift_load = 1;
        #10;
        shift_load = 0;
        #10;
        $display("Step 6 - after LD SH A: shifter=%b", uut.shift_unit.data_out);
        
        //7 Shift A Left once
        shift_dir = 1;
        shift_enable = 1;
        #10;
        shift_enable = 0;
        #10;
        $display("Step 7 - after SHL: shifter=%b(%0d) flag=%b", uut.shift_unit.data_out, uut.shift_unit.data_out, flag);
        
        //8 ACC NZ SH - check flag
        mux2_sel = 1;
        #10;
        if (flag == 1) begin
            alu_op = 4'b0000;
            acc_enable = 1;
            #10;
            acc_enable = 0;
            #10;
        end
        else begin
            #10;
        end
        $display("Step 8 - after ACC NZ SH: acc=%b(%0d) flag=%b", uut.acc_out, uut.acc_out, flag);
        
        //9 LD SH B
        mux1_sel = 1;
        shift_load = 1;
        #10;
        shift_load = 0;
        #10;
        $display("Step 9 - after LD SH B: shifter=%b", uut.shift_unit.data_out);
        
        //10 SHR
        shift_dir = 0;
        shift_enable = 1;
        #10;
        shift_enable = 0;
        #10;
        $display("Step 10 - after SHR: shifter=%b flag=%b", uut.shift_unit.data_out, flag);
        
        //11 SHR
        shift_dir = 0;
        shift_enable = 1;
        #10;
        shift_enable = 0;
        #10;
        $display("Step 11 - after SHR: shifter=%b flag=%b", uut.shift_unit.data_out, flag);
        
        //12 SHR
        shift_dir = 0;
        shift_enable = 1;
        #10;
        shift_enable = 0;
        #10;
        $display("Step 12 - after SHR: shifter=%b flag=%b", uut.shift_unit.data_out, flag);
        
        //13 LD SH A
        mux1_sel = 0;
        shift_load = 1;
        #10;
        shift_load = 0;
        #10;
        $display("Step 13 - after LD SH A: shifter=%b", uut.shift_unit.data_out);
        
        //14 SHL
        shift_dir = 1;
        shift_enable = 1;
        #10;
        shift_enable = 0;
        #10;
        $display("Step 14 - after SHL: shifter=%b(%0d) flag=%b", uut.shift_unit.data_out, uut.shift_unit.data_out, flag);
        
        //15 SHL
        shift_dir = 1;
        shift_enable = 1;
        #10;
        shift_enable = 0;
        #10;
        $display("Step 15 - after SHL: shifter=%b(%0d) flag=%b", uut.shift_unit.data_out, uut.shift_unit.data_out, flag);
        
        //16 ACC NZ SH - check flag
        mux2_sel = 1;
        #10;
        $display("Step 16 debug: shifter=%b mux2_out=%b acc_in=%b flag=%b",
        uut.shift_unit.data_out,
        uut.mux2_out,
        uut.alu_out,flag);
        $display("Step 16 debug2: alu_a=%b(%0d) alu_b=%b(%0d) alu_op=%b alu_out=%b(%0d)",
        uut.alu_unit.a,
        uut.alu_unit.a,
        uut.alu_unit.b,
        uut.alu_unit.b,
        uut.alu_unit.op,
        uut.alu_unit.result,
        uut.alu_unit.result);
        
        if (flag == 1) begin
            alu_op = 4'b0000;
            acc_enable = 1;
            #10;
            acc_enable = 0;
            #10;
        end
        else begin
            #10;
        end
        $display("Step 16 - after ACC NZ SH: acc=%b(%0d) flag=%b", uut.acc_out, uut.acc_out, flag);
        
        //17 LD SH B
        mux1_sel = 1;
        shift_load = 1;
        #10;
        shift_load = 0;
        #10;
        $display("Step 17 - after LD SH B: shifter=%b", uut.shift_unit.data_out);
        
        //18 SHR
        shift_dir = 0;
        shift_enable = 1;
        #10;
        shift_enable = 0;
        #10;
        $display("Step 18 - after SHR: shifter=%b flag=%b", uut.shift_unit.data_out, flag);
        
        //19 SHR
        shift_dir = 0;
        shift_enable = 1;
        #10;
        shift_enable = 0;
        #10;
        $display("Step 19 - after SHR: shifter=%b flag=%b", uut.shift_unit.data_out, flag);
        
        //20 SHR
        shift_dir = 0;
        shift_enable = 1;
        #10;
        shift_enable = 0;
        #10;
        $display("Step 20 - after SHR: shifter=%b flag=%b", uut.shift_unit.data_out, flag);
        
        //21 SHR
        shift_dir = 0;
        shift_enable = 1;
        #10;
        shift_enable = 0;
        #10;
        $display("Step 21 - after SHR: shifter=%b flag=%b", uut.shift_unit.data_out, flag);
        
        //22 LD SH A
        mux1_sel = 0;
        shift_load = 1;
        #10;
        shift_load = 0;
        #10;
        $display("Step 22 - after LD SH A: shifter=%b", uut.shift_unit.data_out);
        
        //23 SHL
        shift_dir = 1;
        shift_enable = 1;
        #10;
        shift_enable = 0;
        #10;
        $display("Step 23 - after SHL: shifter=%b(%0d) flag=%b", uut.shift_unit.data_out, uut.shift_unit.data_out, flag);
        
        //24 SHL
        shift_dir = 1;
        shift_enable = 1;
        #10;
        shift_enable = 0;
        #10;
        $display("Step 24 - after SHL: shifter=%b(%0d) flag=%b", uut.shift_unit.data_out, uut.shift_unit.data_out, flag);
        
        //25 SHL
        shift_dir = 1;
        shift_enable = 1;
        #10;
        shift_enable = 0;
        #10;
        $display("Step 25 - after SHL: shifter=%b(%0d) flag=%b", uut.shift_unit.data_out, uut.shift_unit.data_out, flag);
        
        //26 ACC NZ SH - check flag
        mux2_sel = 1;
        #10;
        if (flag == 1) begin
            alu_op = 4'b0000;
            acc_enable = 1;
            #10;
            acc_enable = 0;
            #10;
        end
        else begin
            #10;
        end
        $display("Step 26 - after ACC NZ SH: acc=%b(%0d) flag=%b", uut.acc_out, uut.acc_out, flag);
        
        //27 LD O
        ld_o = 1;
        #10;
        ld_o = 0;
        #10;
        $display("Final Result: %0d", leds);
   end
   
endmodule

