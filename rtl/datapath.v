module datapath(

        input wire clk,
        input wire rst,
        input wire [3:0] switches,
        
        //control signnals from control unit
        input wire ld_a,
        input wire ld_b,
        input wire ld_o,
        input wire mux1_sel,
        input wire mux2_sel,
        input wire shift_enable,
        input wire shift_load,
        input wire shift_dir,
        input wire acc_enable,
        input wire acc_clear,
        input wire [3:0] alu_op,
        //outputs
        output wire [7:0] leds,
        output wire flag

    );
    
    //wires connecting modules
    wire [3:0] a_out;
    wire [3:0] b_out;
    wire [7:0] mux1_out;
    wire [7:0] shifter_out;
    wire [7:0] mux2_out;
    wire [7:0] alu_out;
    wire [7:0] acc_out;
    
    
    //  A Register - loads from switches when ld_a is high
    register_4_bit reg_a (
    
    .clk (clk),
    .rst (rst),
    .enable (ld_a),
    .data_in (switches),
    .data_out (a_out)
    
    );
    
    // B Register - loads from switches when ld_b is high
    register_4_bit reg_b (
    
    .clk (clk),
    .rst (rst),
    .enable (ld_b),
    .data_in (switches),
    .data_out (b_out)
    
    );
    
    // MUX1 - selects between A and B to feed into shifter
    mux_2to1 mux1 (
    
    .in0({4'b0000, a_out}),
    .in1({4'b0000, b_out}),
    .sel(mux1_sel),
    .mux_out(mux1_out)
    
    );
    
    // Shifter - shifts MUX1 output left or right
    shifter shift_unit (
    
    .clk (clk),
    .rst (rst),
    .enable (shift_enable),
    .load (shift_load),
    .shift_dir (shift_dir),
    .data_in (mux1_out),
    .data_out (shifter_out),
    .flag (flag)
 //   .saved_flag (saved_flag),
 //   .save_flag (save_flag)
    
    );
    
    // MUX2 - selects between shifter output and A register to feed ALU
    mux_2to1 mux2 (
    
    .in0(mux1_out),
    .in1(shifter_out),
    .sel(mux2_sel),
    .mux_out(mux2_out)
    
    );
    
    // ALU - operates on MUX2 output and Accumulator output
    alu alu_unit (
    
    .a (acc_out),
    .b (mux2_out),
    .op (alu_op),
    .result (alu_out)
    
    );
    
    // Accumulator - takes output from ALU and feedsback
    accumulator acc (
    
    .clk (clk),
    .rst (rst),
    .acc_clear (acc_clear),
    .enable (acc_enable),
    .data_in (alu_out),
    .data_out (acc_out)
    
    );
    
    // Output Register - takes output from acc to leds
    output_register reg_out(
    
    .clk (clk),
    .rst (rst),
    .enable (ld_o),
    .data_in (acc_out),
    .data_out (leds)
    
    );
    
endmodule
