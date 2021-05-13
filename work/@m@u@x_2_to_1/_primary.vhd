library verilog;
use verilog.vl_types.all;
entity MUX_2_to_1 is
    generic(
        WORD_WIDTH      : integer := 32
    );
    port(
        \select\        : in     vl_logic;
        inp1            : in     vl_logic_vector;
        inp2            : in     vl_logic_vector;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WORD_WIDTH : constant is 1;
end MUX_2_to_1;
