library verilog;
use verilog.vl_types.all;
entity IF_Stage is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        Freeze          : in     vl_logic;
        Branch_Taken    : in     vl_logic;
        Branch_Address  : in     vl_logic_vector(31 downto 0);
        PC_Stage_out    : out    vl_logic_vector(31 downto 0);
        instruction     : out    vl_logic_vector(31 downto 0)
    );
end IF_Stage;
