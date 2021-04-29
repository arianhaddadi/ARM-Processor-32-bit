library verilog;
use verilog.vl_types.all;
entity ID_Reg is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        flush           : in     vl_logic;
        mem_read_in     : in     vl_logic;
        mem_write_in    : in     vl_logic;
        WB_en_in        : in     vl_logic;
        Imm_in          : in     vl_logic;
        B_in            : in     vl_logic;
        SR_update_in    : in     vl_logic;
        EX_command_in   : in     vl_logic_vector(3 downto 0);
        status_register_in: in     vl_logic_vector(3 downto 0);
        reg_file_dst_in : in     vl_logic_vector(3 downto 0);
        signed_immediate_in: in     vl_logic_vector(23 downto 0);
        shifter_operand_in: in     vl_logic_vector(11 downto 0);
        pc_in           : in     vl_logic_vector(31 downto 0);
        instruction_in  : in     vl_logic_vector(31 downto 0);
        val_Rn_in       : in     vl_logic_vector(31 downto 0);
        val_Rm_in       : in     vl_logic_vector(31 downto 0);
        mem_read_out    : out    vl_logic;
        mem_write_out   : out    vl_logic;
        WB_en_out       : out    vl_logic;
        Imm_out         : out    vl_logic;
        B_out           : out    vl_logic;
        SR_update_out   : out    vl_logic;
        EX_command_out  : out    vl_logic_vector(3 downto 0);
        status_register_out: out    vl_logic_vector(3 downto 0);
        signed_immediate_out: out    vl_logic_vector(23 downto 0);
        shifter_operand_out: out    vl_logic_vector(11 downto 0);
        reg_file_dst_out: out    vl_logic_vector(3 downto 0);
        pc              : out    vl_logic_vector(31 downto 0);
        instruction     : out    vl_logic_vector(31 downto 0);
        val_Rn_out      : out    vl_logic_vector(31 downto 0);
        val_Rm_out      : out    vl_logic_vector(31 downto 0)
    );
end ID_Reg;
