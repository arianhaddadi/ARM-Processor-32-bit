library verilog;
use verilog.vl_types.all;
entity Control_Unit is
    port(
        S               : in     vl_logic;
        mode            : in     vl_logic_vector(1 downto 0);
        op_code         : in     vl_logic_vector(3 downto 0);
        SR_update       : out    vl_logic;
        has_src1        : out    vl_logic;
        mem_read        : out    vl_logic;
        mem_write       : out    vl_logic;
        WB_en           : out    vl_logic;
        B               : out    vl_logic;
        EX_command      : out    vl_logic_vector(3 downto 0)
    );
end Control_Unit;
