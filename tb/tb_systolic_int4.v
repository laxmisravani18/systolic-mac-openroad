`timescale 1ns/1ps
module tb_systolic;
    localparam N = 4, W = 4, AW = 12;
    reg clk = 0, rst = 1;
    reg  [N*W-1:0] a_flat = 0, b_flat = 0;
    wire [N*N*AW-1:0] c_flat;
    reg signed [W-1:0] A [0:N*N-1];
    reg signed [W-1:0] B [0:N*N-1];
    reg signed [AW-1:0] expv, got;
    integer i, j, k, t, errors;

    systolic #(.N(N), .W(W), .ACC_W(AW)) dut (
        .clk(clk), .rst(rst), .a_flat(a_flat), .b_flat(b_flat), .c_flat(c_flat));
    always #5 clk = ~clk;

    initial begin
        for (i = 0; i < N; i = i + 1)
            for (k = 0; k < N; k = k + 1) begin
                A[i*N+k] = i + k - 2;
                B[i*N+k] = 2*i - k;
            end
        #22 rst = 0;
        for (t = 0; t < 3*N; t = t + 1) begin
            for (i = 0; i < N; i = i + 1) begin
                k = t - i;
                a_flat[i*W +: W] = (k >= 0 && k < N) ? A[i*N+k] : 0;
            end
            for (j = 0; j < N; j = j + 1) begin
                k = t - j;
                b_flat[j*W +: W] = (k >= 0 && k < N) ? B[k*N+j] : 0;
            end
            @(posedge clk); #1;
        end
        errors = 0;
        for (i = 0; i < N; i = i + 1)
            for (j = 0; j < N; j = j + 1) begin
                expv = 0;
                for (k = 0; k < N; k = k + 1) expv = expv + A[i*N+k] * B[k*N+j];
                got = c_flat[(i*N+j)*AW +: AW];
                if (got !== expv) begin
                    errors = errors + 1;
                    $display("MISMATCH C[%0d][%0d]: got %0d, expected %0d", i, j, got, expv);
                end
            end
        if (errors == 0) $display("PASS: all %0d results match", N*N);
        $finish;
    end
endmodule
