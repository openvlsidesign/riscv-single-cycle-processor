module sign_extend (
    input   logic [31:0] instr_i, //For I type [31:20] is the immediate value. 12 bit signed value input. Ex- lw x6, -4(x9)
                                //For S type {[31:25],[11:7]} is the immediate value. Ex - sw x6, 8(x9)
    input   logic [2:0] imm_src_i,
    output  logic [31:0] immext_o //Sign extend 12bit signed value
);


//logic to determine the immediate input to sign extension module.
always_comb begin
    case (imm_src_i)
        3'b000: immext_o = {{20{instr_i[31]}}, instr_i[31:20]};                               // I-type
        3'b001: immext_o = {{20{instr_i[31]}}, instr_i[31:25], instr_i[11:7]};                // S-type
        3'b010: immext_o = {{20{instr_i[31]}}, instr_i[7], instr_i[30:25], instr_i[11:8], 1'b0}; // B-type
        3'b011: immext_o = {{12{instr_i[31]}}, instr_i[19:12], instr_i[20], instr_i[30:21], 1'b0}; // J-type
        default: immext_o = '0;
    endcase
end

endmodule