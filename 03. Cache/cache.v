module direct_mapped_cache (
    input clk,
    input reset,

    input        read_en,
    input [31:0] address,

    output reg [31:0] data_out,
    output reg        hit
);

    reg valid [0:3];
    reg [26:0] tag [0:3];
    reg [63:0] data [0:3];

    wire [1:0] index;
    wire [26:0] address_tag;
    wire [2:0] offset;

    assign index       = address[4:3];
    assign offset      = address[2:0];
    assign address_tag = address[31:5];

    integer i;

    always @(posedge clk) begin

        if (reset) begin
            for (i = 0; i < 4; i = i + 1) begin
                valid[i] <= 1'b0;
                tag[i]   <= 27'b0;
                data[i]  <= 64'b0;
            end

            data_out <= 32'b0;
            hit      <= 1'b0;
        end

        else if (read_en) begin

            if (valid[index] && tag[index] == address_tag) begin

                hit <= 1'b1;

                if (offset < 4)
                    data_out <= data[index][31:0];
                else
                    data_out <= data[index][63:32];

            end

            else begin
                hit      <= 1'b0;
                data_out <= 32'b0;
            end
        end
    end

endmodule
