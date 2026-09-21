module simple_fpu (
    input  [31:0] A,
    input  [31:0] B,

    input  [1:0] opcode,

    output reg [31:0] result
);

always @(*) begin

    case (opcode)

        2'b00:
            result = $shortrealtobits(
                $bitstoshortreal(A) +
                $bitstoshortreal(B)
            );

        2'b01:
            result = $shortrealtobits(
                $bitstoshortreal(A) -
                $bitstoshortreal(B)
            );

        2'b10:
            result = $shortrealtobits(
                $bitstoshortreal(A) *
                $bitstoshortreal(B)
            );

        2'b11:
            result = $shortrealtobits(
                $bitstoshortreal(A) /
                $bitstoshortreal(B)
            );

    endcase

end

endmodule
