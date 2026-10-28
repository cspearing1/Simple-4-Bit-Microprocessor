module instruction_decoder(

    input wire [3:0] instruction,
    input wire [3:0] timing,
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
    output wire ld_o,
    output wire pc_enable,
    output wire ir_load

    );
    
    wire T0 = timing[0];
    wire T1 = timing[1];
    wire T2 = timing[2];
    wire T3 = timing[3];
    
    localparam OP_LD_A      = 4'b0000;
    localparam OP_LD_B      = 4'b0001;
    localparam OP_LD_O      = 4'b0010;
    localparam OP_LD_SH_A   = 4'b0011;
    localparam OP_LD_SH_B   = 4'b0100;
    localparam OP_SHR       = 4'b0101;
    localparam OP_SHL       = 4'b0110;
    localparam OP_ACC_NZ_A  = 4'b0111;
    localparam OP_ACC_NZ_SH = 4'b1000;
    localparam OP_ADD       = 4'b1001;
    localparam OP_SUB       = 4'b1010;
    localparam OP_INV       = 4'b1011;
    localparam OP_AND       = 4'b1100;
    localparam OP_OR        = 4'b1101;
    localparam OP_XOR       = 4'b1110;
    localparam OP_CLR_ACC   = 4'b1111; 
    
    assign ld_a = (instruction == OP_LD_A) & T2;
    
    assign ld_b = (instruction == OP_LD_B) & T2;
    
    assign ld_o = (instruction == OP_LD_O) & T2;
    
    assign ir_load = T0;
    
    assign pc_enable = T3;
    
    assign shift_load = T2 & (instruction == OP_LD_SH_A | instruction == OP_LD_SH_B);
    
    assign shift_dir = (instruction == OP_SHL);
    
    assign shift_enable = (instruction == OP_SHL | instruction == OP_SHR) & T2;
    
    assign acc_clear = (instruction == OP_CLR_ACC) & T2;
    
    assign mux1_sel = (instruction == OP_LD_B | instruction == OP_LD_SH_B | (instruction == OP_ADD)| (instruction == OP_SUB)
            | (instruction == OP_INV)| (instruction == OP_AND)| (instruction == OP_OR)
            | (instruction == OP_XOR));
            
    assign mux2_sel = (instruction == OP_ACC_NZ_SH | instruction == OP_SHR | instruction == OP_SHL);
    
    assign acc_enable = (((instruction == OP_ACC_NZ_A & flag == 1) | (instruction == OP_ACC_NZ_SH & flag ==1)
            | (instruction == OP_ADD)| (instruction == OP_SUB)| (instruction == OP_INV)| (instruction == OP_AND)| (instruction == OP_OR)
            | (instruction == OP_XOR)) & T2); //|  ((instruction == OP_LD_A) & T3);
              
    assign alu_op = (instruction == OP_ADD)      ? 4'b0000 :
                    (instruction == OP_SUB)      ? 4'b0001 :
                    (instruction == OP_AND)      ? 4'b0010 :
                    (instruction == OP_OR)       ? 4'b0011 :
                    (instruction == OP_XOR)      ? 4'b0100 :
                    (instruction == OP_INV)      ? 4'b0110 :
                    (instruction == OP_LD_A)     ? 4'b1000 :
                    (instruction == OP_ACC_NZ_A) ? 4'b0000 :
                    (instruction == OP_ACC_NZ_SH)? 4'b0000 :
                                                   4'b1000 ;
endmodule
