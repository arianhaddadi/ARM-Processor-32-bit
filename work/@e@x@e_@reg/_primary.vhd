library verilog;
use verilog.vl_types.all;
entity EXE_Reg is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        mem_read_in     : in     vl_logic;
        mem_write_in    : in     vl_logic;
        WB_en_in        : in     vl_logic;
        dst_in          : in     vl_logic_vector(3 downto 0);
        val_Rm_in       : in     vl_logic_vector(31 downto 0);
        ALU_res_in      : in     vl_logic_vector(31 downto 0);
        mem_read_out    : out    vl_logic;
        mem_write_out   : out    vl_logic;
        WB_en_out       : out    vl_logic;
        dst_out         : out    vl_logic_vector(3 downto 0);
        ALU_res_out     : out    vl_logic_vector(31 downto 0);
        val_Rm_out      : out    vl_logic_vector(31 downto 0)
    );
end EXE_Reg;
