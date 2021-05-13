library verilog;
use verilog.vl_types.all;
entity Val2_Generate is
    port(
        I               : in     vl_logic;
        for_mem         : in     vl_logic;
        shifter_operand : in     vl_logic_vector(11 downto 0);
        Val_Rm          : in     vl_logic_vector(31 downto 0);
        Val2_out        : out    vl_logic_vector(31 downto 0)
    );
end Val2_Generate;
