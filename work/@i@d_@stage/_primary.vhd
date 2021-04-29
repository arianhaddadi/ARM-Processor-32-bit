library verilog;
use verilog.vl_types.all;
entity ID_Stage is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        freeze          : in     vl_logic;
        reg_file_enable : in     vl_logic;
        status_register : in     vl_logic_vector(3 downto 0);
        reg_file_wb_address: in     vl_logic_vector(3 downto 0);
        pc_in           : in     vl_logic_vector(31 downto 0);
        instruction_in  : in     vl_logic_vector(31 downto 0);
        reg_file_wb_data: in     vl_logic_vector(31 downto 0);
        mem_read_out    : out    vl_logic;
        mem_write_out   : out    vl_logic;
        WB_en_out       : out    vl_logic;
        Imm_out         : out    vl_logic;
        B_out           : out    vl_logic;
        SR_update_out   : out    vl_logic;
        has_src2        : out    vl_logic;
        has_src1        : out    vl_logic;
        EX_command_out  : out    vl_logic_vector(3 downto 0);
        reg_file_src1   : out    vl_logic_vector(3 downto 0);
        reg_file_src2   : out    vl_logic_vector(3 downto 0);
        reg_file_dst    : out    vl_logic_vector(3 downto 0);
        signed_immediate: out    vl_logic_vector(23 downto 0);
        shifter_operand : out    vl_logic_vector(11 downto 0);
        pc              : out    vl_logic_vector(31 downto 0);
        instruction     : out    vl_logic_vector(31 downto 0);
        val_Rn          : out    vl_logic_vector(31 downto 0);
        val_Rm          : out    vl_logic_vector(31 downto 0)
    );
end ID_Stage;
