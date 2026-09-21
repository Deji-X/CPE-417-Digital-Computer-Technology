module overflow_detector (
    input  signed [7:0] A,
    input  signed [7:0] B,
    output signed [7:0] Result,
    output Overflow
);

    wire signed [8:0] Sum;

    assign Sum = A + B;

    assign Result = Sum[7:0];

    assign Overflow =
        (~A[7] & ~B[7] & Sum[7]) |
        ( A[7] &  B[7] & ~Sum[7]);

endmodule
