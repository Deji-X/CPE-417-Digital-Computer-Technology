module superscalar_2_issue (
    input clk,
    input reset,

    input        valid0,
    input        valid1,

    input [3:0]  opcode0,
    input [3:0]  opcode1,

    input [31:0] A0,
    input [31:0] B0,

    input [31:0] A1,
    input [31:0] B1,

    output reg [31:0] result0,
    output reg [31:0] result1
);

always @(posedge clk) begin
    if (reset) begin
        result0 <= 32'b0;
        result1 <= 32'b0;
    end
    else begin

        // Execution lane 0
        if (valid0) begin
            case (opcode0)
                4'b0000: result0 <= A0 + B0;
                4'b0001: result0 <= A0 - B0;
                4'b0010: result0 <= A0 & B0;
                4'b0011: result0 <= A0 | B0;
                default: result0 <= 32'b0;
            endcase
        end

        // Execution lane 1
        if (valid1) begin
            case (opcode1)
                4'b0000: result1 <= A1 + B1;
                4'b0001: result1 <= A1 - B1;
                4'b0010: result1 <= A1 & B1;
                4'b0011: result1 <= A1 | B1;
                default: result1 <= 32'b0;
            endcase
        end
    end
end

endmodule
