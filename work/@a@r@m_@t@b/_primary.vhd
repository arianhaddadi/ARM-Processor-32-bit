library verilog;
use verilog.vl_types.all;
entity ARM_TB is
    generic(
        clock_period    : integer := 20
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of clock_period : constant is 1;
end ARM_TB;
