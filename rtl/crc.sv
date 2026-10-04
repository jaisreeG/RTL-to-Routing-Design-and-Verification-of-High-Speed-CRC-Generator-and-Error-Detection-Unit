module crc_top #(
    parameter DATA_WIDTH    = 8,
    parameter DIVISOR_WIDTH = 4
)(
    input  logic clk,
    input  logic rst,

    input  logic [DATA_WIDTH-1:0] data,
    input  logic [DIVISOR_WIDTH-1:0] divisor,

    input  logic [DATA_WIDTH+DIVISOR_WIDTH-2:0] received_data,

    output logic [DATA_WIDTH+DIVISOR_WIDTH-2:0] transmitted_data,

    output logic valid,
    output logic error
);

    crc_generator #(
        .DATA_WIDTH(DATA_WIDTH),
        .DIVISOR_WIDTH(DIVISOR_WIDTH)
    ) gen (
        .clk(clk),
        .rst(rst),
        .data(data),
        .divisor(divisor),
        .transmitted_data(transmitted_data)
    );

    crc_error_detector #(
        .DATA_WIDTH(DATA_WIDTH),
        .DIVISOR_WIDTH(DIVISOR_WIDTH)
    ) check (
        .clk(clk),
        .rst(rst),
        .transmitted_data(received_data),
        .divisor(divisor),
        .valid(valid),
        .error(error)
    );

endmodule


module crc_generator #(
    parameter DATA_WIDTH    = 8,
    parameter DIVISOR_WIDTH = 4
)(
    input  logic clk,
    input  logic rst,
    input  logic [DATA_WIDTH-1:0] data,
    input  logic [DIVISOR_WIDTH-1:0] divisor,

    output logic [DATA_WIDTH+DIVISOR_WIDTH-2:0] transmitted_data
);

    integer i;

    logic [DATA_WIDTH+DIVISOR_WIDTH-2:0] temp;
    logic [DATA_WIDTH+DIVISOR_WIDTH-2:0] div_ext;

    always_ff @(posedge clk) begin

        if (rst) begin
            transmitted_data <= '0;
        end
        else begin

            temp = {data, {(DIVISOR_WIDTH-1){1'b0}}};

            div_ext = '0;
            div_ext[DIVISOR_WIDTH-1:0] = divisor;

            for (i = DATA_WIDTH-1; i >= 0; i = i-1) begin
                if (temp[i+DIVISOR_WIDTH-1]) begin
                    temp = temp ^ (div_ext << i);
                end
            end

            transmitted_data <=
                {data, temp[DIVISOR_WIDTH-2:0]};

        end

    end

endmodule


module crc_error_detector #(
    parameter DATA_WIDTH    = 8,
    parameter DIVISOR_WIDTH = 4
)(
    input  logic clk,
    input  logic rst,
    input  logic [DATA_WIDTH+DIVISOR_WIDTH-2:0] transmitted_data,
    input  logic [DIVISOR_WIDTH-1:0] divisor,

    output logic valid,
    output logic error
);

    integer i;

    logic [DATA_WIDTH+DIVISOR_WIDTH-2:0] temp;
    logic [DATA_WIDTH+DIVISOR_WIDTH-2:0] div_ext;

    always_ff @(posedge clk) begin

        if (rst) begin
            valid <= 1'b0;
            error <= 1'b0;
        end
        else begin

            temp = transmitted_data;

            div_ext = '0;
            div_ext[DIVISOR_WIDTH-1:0] = divisor;

            for (i = DATA_WIDTH-1; i >= 0; i = i-1) begin
                if (temp[i+DIVISOR_WIDTH-1]) begin
                    temp = temp ^ (div_ext << i);
                end
            end

            if (temp[DIVISOR_WIDTH-2:0] == '0) begin
                valid <= 1'b1;
                error <= 1'b0;
            end
            else begin
                valid <= 1'b0;
                error <= 1'b1;
            end

        end

    end

endmodule
