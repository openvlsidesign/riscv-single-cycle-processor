module riscv_top (
    input logic clk,
    input logic reset,
    output logic [31:0] WriteData, DataAdr,
    output logic MemWrite
);
logic zero_flag;
logic [31:0] instr;
logic  [1:0] pc_src;
logic [2:0] imm_src_i;
logic reg_file_writeen_i;
logic alu_src_i;
logic [2:0] alu_control_i;
logic [1:0] result_src_i;

datapath datapath_inst (
    .clk                (clk),
    .rst_n              (reset),
    .imm_src_i          (imm_src_i),
    .data_mem_writeen_i (MemWrite),
    .reg_file_writeen_i (reg_file_writeen_i),
    .alu_control_i      (alu_control_i),
    .alu_src_i          (alu_src_i),
    .result_src_i       (result_src_i),
    .pc_src_i           (pc_src),
    .write_data_o       (WriteData),
    .data_address_o     (DataAdr),
    .zero_o             (zero_flag),
    .instr_o            (instr)

);

controller controller_inst (
    .op_i               (instr[6:0]),
    .funct3             (instr[14:12]),
    .funct7             (instr[29]),
    .result_src_o       (result_src_i),
    .imm_src_o          (imm_src_i),
    .mem_write_o        (MemWrite),
    .reg_write_o        (reg_file_writeen_i),
    .alu_src_o          (alu_src_i),
    .alu_ctrl_o         (alu_control_i),
    .zero_flag_i        (zero_flag),
    .pc_src_o           (pc_src)
);


endmodule