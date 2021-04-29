library verilog;
use verilog.vl_types.all;
entity Mem_Stage is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        mem_read        : in     vl_logic;
        mem_write       : in     vl_logic;
        WB_en           : in     vl_logic;
        dst             : in     vl_logic_vector(3 downto 0);
        ALU_res         : in     vl_logic_vector(31 downto 0);
        val_Rm          : in     vl_logic_vector(31 downto 0);
        mem_read_out    : out    vl_logic;
        WB_en_out       : out    vl_logic;
        dst_out         : out    vl_logic_vector(3 downto 0);
        ALU_res_out     : out    vl_logic_vector(31 downto 0);
        mem_out         : out    vl_logic_vector(31 downto 0)
    );
end Mem_Stage;
