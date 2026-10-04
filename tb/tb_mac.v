`timescale 1ns/1ps
module tb_mac;
    reg clk = 0, rst = 1, en = 0;
    reg signed [7:0] a = 0, b = 0;
    wire signed [19:0] acc;

    mac dut (.clk(clk), .rst(rst), .en(en), .a(a), .b(b), .acc(acc));
    always #5 clk = ~clk;

    initial begin
        $dumpfile("mac.vcd");
        $dumpvars(0, tb_mac);
        #12 rst = 0; en = 1;
        a = 3;  b = 4;  @(posedge clk); #1 $display("acc = %0d (expect 12)", acc);
        a = 2;  b = 5;  @(posedge clk); #1 $display("acc = %0d (expect 22)", acc);
        a = -3; b = 4;  @(posedge clk); #1 $display("acc = %0d (expect 10)", acc);
        $finish;
    end
endmodule
