module Booth_Multiplier #(
    parameter N = 4
)(
    input clk,
    input reset,
    input start,

    input signed [N-1:0] multiplicand,
    input signed [N-1:0] multiplier,

    output reg signed [2*N-1:0] product,
    output reg done
);

    reg signed [N:0] A;
    reg signed [N:0] M;
    reg signed [N-1:0] Q;
    reg Q_minus_1;

    integer count;
    reg busy;

    reg signed [N:0] A_next;

    always @(*) begin

        A_next = A;

        case ({Q[0], Q_minus_1})

            2'b01:
                A_next = A + M;

            2'b10:
                A_next = A - M;

            default:
                A_next = A;

        endcase

    end


    always @(posedge clk) begin

        if (reset) begin

            A         <= 0;
            M         <= 0;
            Q         <= 0;
            Q_minus_1 <= 0;

            count     <= 0;
            busy      <= 0;

            product   <= 0;
            done      <= 0;

        end

        else begin

            done <= 0;

            if (start && !busy) begin

                A <= 0;

                M <= {{1{multiplicand[N-1]}}, multiplicand};

                Q <= multiplier;

                Q_minus_1 <= 0;

                count <= 0;

                busy <= 1;

            end

            else if (busy) begin

                // Save old Q0
                Q_minus_1 <= Q[0];

                // Arithmetic right shift of {A_next, Q, Q_minus_1}
                A <= {A_next[N], A_next[N:1]};

                Q <= {A_next[0], Q[N-1:1]};

                if (count == N-1) begin

                    product <= {A_next[N-1:0], Q};

                    done <= 1;

                    busy <= 0;

                    count <= 0;

                end

                else begin

                    count <= count + 1;

                end

            end

        end

    end

endmodule
