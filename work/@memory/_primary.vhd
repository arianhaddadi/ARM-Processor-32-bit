library verilog;
use verilog.vl_types.all;
entity Memory is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        mem_w_en        : in     vl_logic;
        mem_r_en        : in     vl_logic;
        alu_res         : in     vl_logic_vector(31 downto 0);
        Val_Rm          : in     vl_logic_vector(31 downto 0);
        res_data        : out    vl_logic_vector(31 downto 0)
    );
end Memory;
