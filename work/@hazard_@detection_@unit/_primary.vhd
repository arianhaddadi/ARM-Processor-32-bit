library verilog;
use verilog.vl_types.all;
entity Hazard_Detection_Unit is
    port(
        EXE_WB_en       : in     vl_logic;
        MEM_WB_en       : in     vl_logic;
        has_src1        : in     vl_logic;
        has_src2        : in     vl_logic;
        src1            : in     vl_logic_vector(3 downto 0);
        src2            : in     vl_logic_vector(3 downto 0);
        EXE_dest        : in     vl_logic_vector(3 downto 0);
        MEM_dest        : in     vl_logic_vector(3 downto 0);
        hazard_detected : out    vl_logic
    );
end Hazard_Detection_Unit;
