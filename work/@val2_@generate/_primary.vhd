library verilog;
use verilog.vl_types.all;
entity Val2_Generate is
    port(
        imm             : in     vl_logic;
        is_for_memory   : in     vl_logic;
        shifter_operand : in     vl_logic_vector(11 downto 0);
        val_Rm          : in     vl_logic_vector(31 downto 0);
        val2_out        : out    vl_logic_vector(31 downto 0)
    );
end Val2_Generate;
