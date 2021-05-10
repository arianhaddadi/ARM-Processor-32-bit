`include "constants.h"

module ARM_TB;

    reg clk;
    reg rst;


    ARM CPU(
    .clk(clk),
    .rst(rst)
    );

    initial begin
        clk = 0;
        forever clk = #`CLOCK_PERIOD ~clk;
    end

    initial begin
        rst = 1;
        # (`CLOCK_PERIOD / 2);
        rst = 0;
        # (600*`CLOCK_PERIOD);
        $stop;
    end
endmodule