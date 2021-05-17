library verilog;
use verilog.vl_types.all;
entity EXE_Stage is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        I               : in     vl_logic;
        MEM_R_EN_in     : in     vl_logic;
        MEM_W_EN_in     : in     vl_logic;
        WB_EN_in        : in     vl_logic;
        B_in            : in     vl_logic;
        Forwarding_Sel1 : in     vl_logic_vector(1 downto 0);
        Forwarding_Sel2 : in     vl_logic_vector(1 downto 0);
        EXE_CMD         : in     vl_logic_vector(3 downto 0);
        Status_Register_in: in     vl_logic_vector(3 downto 0);
        Dest_in         : in     vl_logic_vector(3 downto 0);
        shifter_operand : in     vl_logic_vector(11 downto 0);
        signed_immediate: in     vl_logic_vector(23 downto 0);
        PC_in           : in     vl_logic_vector(31 downto 0);
        Val_Rn_in       : in     vl_logic_vector(31 downto 0);
        Val_Rm_in       : in     vl_logic_vector(31 downto 0);
        MEM_ALU_RES     : in     vl_logic_vector(31 downto 0);
        WB_ALU_RES      : in     vl_logic_vector(31 downto 0);
        MEM_R_EN_out    : out    vl_logic;
        MEM_W_EN_out    : out    vl_logic;
        WB_EN_out       : out    vl_logic;
        B_out           : out    vl_logic;
        Status_Register_out: out    vl_logic_vector(3 downto 0);
        Dest_out        : out    vl_logic_vector(3 downto 0);
        ALU_Res         : out    vl_logic_vector(31 downto 0);
        Val_Rm_out      : out    vl_logic_vector(31 downto 0);
        Branch_Address  : out    vl_logic_vector(31 downto 0)
    );
end EXE_Stage;
