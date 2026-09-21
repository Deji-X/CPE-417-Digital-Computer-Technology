module fixed_point_adder (
    input  signed [15:0] A,
    input  signed [15:0] B,

    output signed [15:0] Y
);

assign Y = A + B;

endmodule
