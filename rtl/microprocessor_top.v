module microprocessor_top(

    input wire clk,
    input wire btn,
    input wire CPU_RESETN,
    input wire [3:0] switches,
    
    output wire [7:0] leds

    );
    
    wire rst = ~CPU_RESETN;
    wire ce;
    wire pulse;
    wire mux1_sel;
    wire mux2_sel;
    wire [3:0] alu_op;
    wire acc_enable;
    wire shift_load;
    wire shift_enable;
    wire acc_clear;
    wire shift_dir;
    wire ld_a;
    wire ld_b;
    wire ld_o;
    wire flag;
    
    datapath datapath (
        .clk (clk),
        .rst (rst),
        .switches (switches),
        .ld_a (ld_a),
        .ld_b (ld_b),
        .ld_o (ld_o),
        .mux1_sel (mux1_sel),
        .mux2_sel (mux2_sel),
        .shift_enable (shift_enable),
        .shift_load (shift_load),
        .shift_dir (shift_dir),
        .acc_enable (acc_enable),
        .acc_clear (acc_clear),
        .alu_op (alu_op),
        .leds (leds),
        .flag (flag)
    );
    
    control_unit control_unit (
        .clk (clk),
        .pulse (pulse),
        .rst (rst),
        .ld_a (ld_a),
        .ld_b (ld_b),
        .ld_o (ld_o),
        .mux1_sel (mux1_sel),
        .mux2_sel (mux2_sel),
        .flag (flag),
        .shift_enable (shift_enable),
        .shift_load (shift_load),
        .shift_dir (shift_dir),
        .acc_enable (acc_enable),
        .acc_clear (acc_clear),
        .alu_op (alu_op)
    );
    
    ce_debouncer ce_debouncer(
        .clk (clk),
        .rst (rst),
        .btn (btn),
        .ce (ce)
    );
    
    pulse_gen pulse_gen (
        .clk (clk),
        .rst (rst),
        .ce (ce),
        .pulse (pulse)
    );
    
endmodule
