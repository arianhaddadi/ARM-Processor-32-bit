library verilog;
use verilog.vl_types.all;
entity MEM_Stage_Reg is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        MEM_R_EN_in     : in     vl_logic;
        WB_EN_in        : in     vl_logic;
        Dest_in         : in     vl_logic_vector(3 downto 0);
        ALU_Res_in      : in     vl_logic_vector(31 downto 0);
        MEM_in          : in     vl_logic_vector(31 downto 0);
        MEM_R_EN_out    : out    vl_logic;
        WB_EN_out       : out    vl_logic;
        Dest_out        : out    vl_logic_vector(3 downto 0);
        ALU_Res_out     : out    vl_logic_vector(31 downto 0);
        MEM_out         : out    vl_logic_vector(31 downto 0)
    );
end MEM_Stage_Reg;
