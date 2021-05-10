library verilog;
use verilog.vl_types.all;
entity EXE_Stage is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        mem_read_in     : in     vl_logic;
        mem_write_in    : in     vl_logic;
        imm             : in     vl_logic;
        WB_en_in        : in     vl_logic;
        B_in            : in     vl_logic;
        EX_command      : in     vl_logic_vector(3 downto 0);
        SR_in           : in     vl_logic_vector(3 downto 0);
        signed_immediate: in     vl_logic_vector(23 downto 0);
        shifter_operand : in     vl_logic_vector(11 downto 0);
        dst_in          : in     vl_logic_vector(3 downto 0);
        pc_in           : in     vl_logic_vector(31 downto 0);
        val_Rn_in       : in     vl_logic_vector(31 downto 0);
        val_Rm_in       : in     vl_logic_vector(31 downto 0);
        mem_read_out    : out    vl_logic;
        mem_write_out   : out    vl_logic;
        WB_en_out       : out    vl_logic;
        B_out           : out    vl_logic;
        SR_out          : out    vl_logic_vector(3 downto 0);
        dst_out         : out    vl_logic_vector(3 downto 0);
        ALU_res         : out    vl_logic_vector(31 downto 0);
        val_Rm_out      : out    vl_logic_vector(31 downto 0);
        branch_address  : out    vl_logic_vector(31 downto 0)
    );
end EXE_Stage;
