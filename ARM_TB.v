`timescale 1ns/1ns

module ARM_TB;

    reg clk;
    reg rst;


    ARM CPU(
        .clk(clk),
        .rst(rst)
    );

    initial begin
        clk = 0;
        forever clk = #20 ~clk;
    end

    initial begin
        rst = 1;
        # (20 / 2);
        rst = 0;
        # (600*20);
        $stop;
    end
endmodule