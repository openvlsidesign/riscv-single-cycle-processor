module datapath (
    input logic         clk, rst_n,
    
    input logic [2:0]   imm_src_i,
    
    input logic         data_mem_writeen_i,
    
    input logic         reg_file_writeen_i,

    input logic [2:0]   alu_control_i,
    input logic         alu_src_i,

    input logic [1:0]   result_src_i,

    input logic         pc_src_i,

    output logic        zero_o,
    output logic [31:0] instr_o,

    output logic [31:0] write_data_o,
    output logic [31:0] data_address_o
);

logic   [31:0]  pc, rd1, rd2, immext, alu_result, data_mem_o;

assign write_data_o = rd2;
assign data_address_o = alu_result;

program_counter prg_cntr (
    .clk                (clk),
    .rst_n              (rst_n),
    .pc_src_i           (pc_src_i),
    .pc_target_i        (pc + immext),
    .pc_o               (pc)

);

instr_mem instr_memory (
    .pc_i               (pc),
    .instr_o            (instr_o)
);

logic [31:0] reg_file_wr_data;

always_comb begin
    case(result_src_i)
        2'b00: reg_file_wr_data = alu_result; // ALU result
        2'b01: reg_file_wr_data = data_mem_o; // Data memory output
        2'b10: reg_file_wr_data = pc + 4; // PC + 4 (next instruction address)
        default: reg_file_wr_data = 32'b0; // Default case
    endcase
end

register_file reg_file (
    .clk                (clk),
    .rst_n              (rst_n),
    .rs1                (instr_o[19:15]),
    .readdata1_o        (rd1),

    .rs2                (instr_o[24:20]),
    .readdata2_o        (rd2),

    .wr_data_i          (reg_file_wr_data),
    .reg_file_writeen_i (reg_file_writeen_i),
    .dest_reg_i         (instr_o[11:7])


);

sign_extend se_inst (
    .instr_i            (instr_o),
    .imm_src_i          (imm_src_i),
    .immext_o           (immext)
);

alu alu_inst (
    .a_i                (rd1),
    .b_i                (alu_src_i ? immext : rd2),
    .alu_control_i      (alu_control_i),
    
    .result_o           (alu_result),
    .zero_o             (zero_o)
);

data_mem data_memory (
    .clk                (clk),
    .rst_n              (rst_n),
    .address_i          (alu_result),
    .wr_en_i            (data_mem_writeen_i),
    .write_data_i       (rd2),
    
    .data_mem_o         (data_mem_o)

);

endmodule