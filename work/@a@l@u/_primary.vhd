library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        carry           : in     vl_logic;
        EX_command      : in     vl_logic_vector(3 downto 0);
        val1            : in     vl_logic_vector(31 downto 0);
        val2            : in     vl_logic_vector(31 downto 0);
        SR              : out    vl_logic_vector(3 downto 0);
        res             : out    vl_logic_vector(31 downto 0)
    );
end ALU;
