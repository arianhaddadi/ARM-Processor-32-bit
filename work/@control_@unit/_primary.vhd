library verilog;
use verilog.vl_types.all;
entity Control_Unit is
    port(
        S               : in     vl_logic;
        mode            : in     vl_logic_vector(1 downto 0);
        OP              : in     vl_logic_vector(3 downto 0);
        S_out           : out    vl_logic;
        MEM_R           : out    vl_logic;
        MEM_W           : out    vl_logic;
        WB_EN           : out    vl_logic;
        B               : out    vl_logic;
        EXE_CMD         : out    vl_logic_vector(3 downto 0)
    );
end Control_Unit;
