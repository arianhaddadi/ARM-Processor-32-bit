library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        carry           : in     vl_logic;
        EXE_CMD         : in     vl_logic_vector(3 downto 0);
        val1            : in     vl_logic_vector(31 downto 0);
        val2            : in     vl_logic_vector(31 downto 0);
        SR              : out    vl_logic_vector(3 downto 0);
        result          : out    vl_logic_vector(31 downto 0)
    );
end ALU;
