library verilog;
use verilog.vl_types.all;
entity ID_Stage_Reg is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        Flush           : in     vl_logic;
        MEM_R_EN_in     : in     vl_logic;
        MEM_W_EN_in     : in     vl_logic;
        WB_EN_in        : in     vl_logic;
        Imm_in          : in     vl_logic;
        B_in            : in     vl_logic;
        S_in            : in     vl_logic;
        EX_CMD_in       : in     vl_logic_vector(3 downto 0);
        Status_Register_in: in     vl_logic_vector(3 downto 0);
        Dest_in         : in     vl_logic_vector(3 downto 0);
        shifter_operand_in: in     vl_logic_vector(11 downto 0);
        signed_immediate_in: in     vl_logic_vector(23 downto 0);
        PC_in           : in     vl_logic_vector(31 downto 0);
        Val_Rn_in       : in     vl_logic_vector(31 downto 0);
        Val_Rm_in       : in     vl_logic_vector(31 downto 0);
        MEM_R_EN_out    : out    vl_logic;
        MEM_W_EN_out    : out    vl_logic;
        WB_EN_out       : out    vl_logic;
        Imm_out         : out    vl_logic;
        B_out           : out    vl_logic;
        S_out           : out    vl_logic;
        EX_CMD_out      : out    vl_logic_vector(3 downto 0);
        status_register_out: out    vl_logic_vector(3 downto 0);
        Dest_out        : out    vl_logic_vector(3 downto 0);
        shifter_operand_out: out    vl_logic_vector(11 downto 0);
        signed_immediate_out: out    vl_logic_vector(23 downto 0);
        PC_out          : out    vl_logic_vector(31 downto 0);
        Val_Rn_out      : out    vl_logic_vector(31 downto 0);
        Val_Rm_out      : out    vl_logic_vector(31 downto 0)
    );
end ID_Stage_Reg;
