library verilog;
use verilog.vl_types.all;
entity WB_Stage is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        mem_read        : in     vl_logic;
        WB_en           : in     vl_logic;
        dst             : in     vl_logic_vector(3 downto 0);
        ALU_res         : in     vl_logic_vector(31 downto 0);
        mem             : in     vl_logic_vector(31 downto 0);
        WB_en_out       : out    vl_logic;
        WB_Dest         : out    vl_logic_vector(3 downto 0);
        WB_Value        : out    vl_logic_vector(31 downto 0)
    );
end WB_Stage;
