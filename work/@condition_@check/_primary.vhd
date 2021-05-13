library verilog;
use verilog.vl_types.all;
entity Condition_Check is
    port(
        condition       : in     vl_logic_vector(3 downto 0);
        Status_Register : in     vl_logic_vector(3 downto 0);
        state           : out    vl_logic
    );
end Condition_Check;
