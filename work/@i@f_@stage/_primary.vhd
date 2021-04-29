library verilog;
use verilog.vl_types.all;
entity IF_Stage is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        freeze          : in     vl_logic;
        branch_taken    : in     vl_logic;
        pc              : out    vl_logic_vector(31 downto 0);
        branch_addr     : in     vl_logic_vector(31 downto 0);
        instruction     : out    vl_logic_vector(31 downto 0)
    );
end IF_Stage;
