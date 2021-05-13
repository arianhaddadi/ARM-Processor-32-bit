library verilog;
use verilog.vl_types.all;
entity Memory is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        MEM_W_EN        : in     vl_logic;
        MEM_R_EN        : in     vl_logic;
        ALU_res         : in     vl_logic_vector(31 downto 0);
        Val_Rm          : in     vl_logic_vector(31 downto 0);
        MEM_out         : out    vl_logic_vector(31 downto 0)
    );
end Memory;
