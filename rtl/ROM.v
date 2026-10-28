module rom(
    
    input wire [4:0] pc,
    output reg [3:0] rom_out
    
    );
    
    reg [3:0] rom [0:31];
    
    initial begin
        
        rom[0]  = 4'b1111;  // CLR ACC  
        rom[1]  = 4'b0000;  // LD A    
        rom[2]  = 4'b0001;  // LD B 
        rom[3]  = 4'b0100;  // LD SH B
        rom[4]  = 4'b0101;  // SHR
        rom[5]  = 4'b0111;  // ACC NZ A
        rom[6]  = 4'b0101;  // SHR
        rom[7]  = 4'b0011;  // LD SH A
        rom[8]  = 4'b0110;  // SHL
        rom[9]  = 4'b1000;  // ACC NZ SH
        rom[10] = 4'b0100;  // LD SH B
        rom[11] = 4'b0101;  // SHR
        rom[12] = 4'b0101;  // SHR
        rom[13] = 4'b0101;  // SHR
        rom[14] = 4'b0011;  // LD SH A
        rom[15] = 4'b0110;  // SHL
        rom[16] = 4'b0110;  // SHL
        rom[17] = 4'b1000;  // ACC NZ SH
        rom[18] = 4'b0100;  // LD SH B
        rom[19] = 4'b0101;  // SHR
        rom[20] = 4'b0101;  // SHR
        rom[21] = 4'b0101;  // SHR
        rom[22] = 4'b0101;  // SHR
        rom[23] = 4'b0011;  // LD SH A
        rom[24] = 4'b0110;  // SHL
        rom[25] = 4'b0110;  // SHL
        rom[26] = 4'b0110;  // SHL
        rom[27] = 4'b1000;  // ACC NZ SH
        rom[28] = 4'b0010;  // LD O
        rom[29] = 4'b1111;  // CLR ACC
        rom[30] = 4'b1111;  // CLR ACC
        rom[31] = 4'b1111;  // CLR ACC
        
        
    end   
    
    always @(*) begin
        rom_out = rom[pc];
    end     
endmodule
