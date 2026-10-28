module control_unit(

    input wire clk,
    input wire pulse,
    input wire rst,
    input wire flag,
    
    output wire mux1_sel,
    output wire mux2_sel,
    output wire [3:0] alu_op,
    output wire acc_enable,
    output wire shift_load,
    output wire shift_enable,
    output wire acc_clear,
    output wire shift_dir,
    output wire ld_a,
    output wire ld_b,
    output wire ld_o

    );
    
    wire [3:0] timing;
    wire [4:0] pc_out;
    wire [3:0] rom_out;
    wire [3:0] instruction;
    
    wire pc_enable;
    wire ir_load;
    
    register_4_bit ir (
        .clk (clk),
        .rst (rst),
        .enable (ir_load),
        .data_in (rom_out),
        .data_out (instruction)
    );
    
    ring_counter ring_counter (
        .clk (clk),
        .pulse (pulse),
        .rst (rst),
        .timing (timing)
    );
    
    program_counter pc (
        .clk (clk),
        .rst (rst),
        .enable (pc_enable),
        .pc (pc_out)
    );
    
    rom rom (
        .pc (pc_out),
        .rom_out (rom_out)
    );
    
    instruction_decoder decoder (
        .instruction (instruction),
        .timing (timing),
        .flag (flag),
        .mux1_sel (mux1_sel),
        .mux2_sel (mux2_sel),
        .alu_op (alu_op),
        .acc_enable (acc_enable),
        .shift_load (shift_load),
        .shift_enable (shift_enable),
        .acc_clear (acc_clear),
        .shift_dir (shift_dir),
        .ld_a (ld_a),
        .ld_b (ld_b),
        .ld_o (ld_o),
        .pc_enable (pc_enable),
        .ir_load (ir_load)
    );
    
endmodule
