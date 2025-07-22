module program_counter (
    input   logic clk, rst_n,
    input   logic pc_src_i,
    input   logic [31:0] pc_target_i,
    output  logic [31:0] pc_o
);

always_ff @(posedge clk) begin
if(rst_n)
    pc_o <= '0;
else
    pc_o <= pc_src_i ? pc_target_i : pc_o + 'd4;
end 

endmodule