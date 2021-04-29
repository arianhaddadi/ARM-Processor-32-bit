library verilog;
use verilog.vl_types.all;
entity MUX_2_to_1 is
    generic(
        WORD_WIDTH      : integer := 32
    );
    port(
        sel             : in     vl_logic;
        in1             : in     vl_logic_vector(31 downto 0);
        in2             : in     vl_logic_vector(31 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WORD_WIDTH : constant is 1;
end MUX_2_to_1;
