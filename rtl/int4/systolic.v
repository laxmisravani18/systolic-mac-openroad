module systolic #(parameter N = 4, parameter W = 4, parameter ACC_W = 12) (
    input                           clk,
    input                           rst,
    input  [N*W-1:0]                a_flat,
    input  [N*W-1:0]                b_flat,
    output [N*N*ACC_W-1:0]          c_flat
);
    wire [N*(N+1)*W-1:0] a_bus;
    wire [(N+1)*N*W-1:0] b_bus;
    genvar i, j;
    generate
        for (i = 0; i < N; i = i + 1) begin : ROWIN
            assign a_bus[(i*(N+1))*W +: W] = a_flat[i*W +: W];
        end
        for (j = 0; j < N; j = j + 1) begin : COLIN
            assign b_bus[j*W +: W] = b_flat[j*W +: W];
        end
        for (i = 0; i < N; i = i + 1) begin : R
            for (j = 0; j < N; j = j + 1) begin : C
                pe #(.W(W), .ACC_W(ACC_W)) u (
                    .clk(clk), .rst(rst),
                    .a_in (a_bus[(i*(N+1)+j)*W +: W]),
                    .b_in (b_bus[(i*N+j)*W +: W]),
                    .a_out(a_bus[(i*(N+1)+j+1)*W +: W]),
                    .b_out(b_bus[((i+1)*N+j)*W +: W]),
                    .acc  (c_flat[(i*N+j)*ACC_W +: ACC_W])
                );
            end
        end
    endgenerate
endmodule
