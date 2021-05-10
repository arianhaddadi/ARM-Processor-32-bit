library verilog;
use verilog.vl_types.all;
entity IF_Reg is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        Freeze          : in     vl_logic;
        Flush           : in     vl_logic;
        PC_in           : in     vl_logic_vector(31 downto 0);
        instruction_in  : in     vl_logic_vector(31 downto 0);
        PC_out          : out    vl_logic_vector(31 downto 0);
        instruction_out : out    vl_logic_vector(31 downto 0)
    );
end IF_Reg;
