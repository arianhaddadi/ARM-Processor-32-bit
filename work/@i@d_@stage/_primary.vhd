library verilog;
use verilog.vl_types.all;
entity ID_Stage is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        hazard          : in     vl_logic;
        WB_EN           : in     vl_logic;
        Status_Register : in     vl_logic_vector(3 downto 0);
        WB_Dest         : in     vl_logic_vector(3 downto 0);
        PC_in           : in     vl_logic_vector(31 downto 0);
        instruction_in  : in     vl_logic_vector(31 downto 0);
        WB_Value        : in     vl_logic_vector(31 downto 0);
        MEM_R_EN_out    : out    vl_logic;
        MEM_W_EN_out    : out    vl_logic;
        WB_EN_out       : out    vl_logic;
        Imm_out         : out    vl_logic;
        B_out           : out    vl_logic;
        S_out           : out    vl_logic;
        with_src2       : out    vl_logic;
        with_src1       : out    vl_logic;
        EX_CMD_out      : out    vl_logic_vector(3 downto 0);
        Reg_src1        : out    vl_logic_vector(3 downto 0);
        Reg_src2        : out    vl_logic_vector(3 downto 0);
        Reg_Dest        : out    vl_logic_vector(3 downto 0);
        shifter_operand : out    vl_logic_vector(11 downto 0);
        signed_immediate: out    vl_logic_vector(23 downto 0);
        PC_out          : out    vl_logic_vector(31 downto 0);
        Val_Rn          : out    vl_logic_vector(31 downto 0);
        Val_Rm          : out    vl_logic_vector(31 downto 0)
    );
end ID_Stage;
