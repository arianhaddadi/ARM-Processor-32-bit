library verilog;
use verilog.vl_types.all;
entity Register_File is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        WB_EN           : in     vl_logic;
        WB_Dest         : in     vl_logic_vector(3 downto 0);
        src1            : in     vl_logic_vector(3 downto 0);
        src2            : in     vl_logic_vector(3 downto 0);
        WB_Res          : in     vl_logic_vector(31 downto 0);
        reg1            : out    vl_logic_vector(31 downto 0);
        reg2            : out    vl_logic_vector(31 downto 0)
    );
end Register_File;
