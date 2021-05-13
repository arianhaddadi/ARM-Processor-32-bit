`timescale 1ns/1ns

module ARM_TB;

    reg clk = 0;
    reg rst;

    ARM CPU(
        .clk(clk),
        .rst(rst)
    );

    always #10 clk = ~clk;

    initial begin
        rst = 1;
        # (5);
        rst = 0;
        # (7000);
    $stop;
    end
    
endmodule