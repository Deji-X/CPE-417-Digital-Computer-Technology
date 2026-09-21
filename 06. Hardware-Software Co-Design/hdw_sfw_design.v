module hw_multiplier (
    input clk,
    input reset,

    input        start,
    input [31:0] A,
    input [31:0] B,

    output reg [63:0] result,
    output reg        done
);

always @(posedge clk) begin

    if (reset) begin
        result <= 64'b0;
        done   <= 1'b0;
    end

    else begin

        done <= 1'b0;

        if (start) begin
            result <= A * B;
            done   <= 1'b1;
        end

    end

end

endmodule
