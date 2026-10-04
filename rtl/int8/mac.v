module mac #(parameter W = 8, parameter ACC_W = 20) (
    input                         clk,
    input                         rst,
    input                         en,
    input  signed [W-1:0]         a,
    input  signed [W-1:0]         b,
    output reg signed [ACC_W-1:0] acc
);
    always @(posedge clk) begin
        if (rst)      acc <= 0;
        else if (en)  acc <= acc + a * b;
    end
endmodule
