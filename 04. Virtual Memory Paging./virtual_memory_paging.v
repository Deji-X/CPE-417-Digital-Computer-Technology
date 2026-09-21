module simple_paging (
    input  [31:0] virtual_address,

    output [31:0] physical_address,
    output        page_fault
);

    reg [19:0] page_table [0:3];
    reg [3:0]  valid;

    wire [19:0] vpn;
    wire [11:0] offset;

    assign vpn    = virtual_address[31:12];
    assign offset = virtual_address[11:0];

    wire [1:0] page_index;

    assign page_index = virtual_address[13:12];

    assign page_fault = !valid[page_index];

    assign physical_address =
        page_fault ?
        32'b0 :
        {page_table[page_index], offset};

    initial begin

        valid = 4'b1111;

        page_table[0] = 20'h00100;
        page_table[1] = 20'h00200;
        page_table[2] = 20'h00300;
        page_table[3] = 20'h00400;

    end

endmodule
