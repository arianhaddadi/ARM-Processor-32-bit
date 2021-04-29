library verilog;
use verilog.vl_types.all;
entity Status_Reg is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        load            : in     vl_logic;
        status_in       : in     vl_logic_vector(3 downto 0);
        status          : out    vl_logic_vector(3 downto 0)
    );
end Status_Reg;
