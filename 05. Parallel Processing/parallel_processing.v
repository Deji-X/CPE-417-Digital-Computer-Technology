module parallel_adder (
    input  [31:0] A0,
    input  [31:0] A1,
    input  [31:0] A2,
    input  [31:0] A3,

    input  [31:0] B0,
    input  [31:0] B1,
    input  [31:0] B2,
    input  [31:0] B3,

    output [31:0] Y0,
    output [31:0] Y1,
    output [31:0] Y2,
    output [31:0] Y3
);

assign Y0 = A0 + B0;
assign Y1 = A1 + B1;
assign Y2 = A2 + B2;
assign Y3 = A3 + B3;

endmodule
