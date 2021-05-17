library verilog;
use verilog.vl_types.all;
entity Hazard_Detection_Unit is
    port(
        EXE_WB_EN       : in     vl_logic;
        MEM_WB_EN       : in     vl_logic;
        with_src1       : in     vl_logic;
        with_src2       : in     vl_logic;
        isForwardingActive: in     vl_logic;
        EXE_MEM_R_EN    : in     vl_logic;
        src1            : in     vl_logic_vector(3 downto 0);
        src2            : in     vl_logic_vector(3 downto 0);
        EXE_Dest        : in     vl_logic_vector(3 downto 0);
        MEM_Dest        : in     vl_logic_vector(3 downto 0);
        has_hazard      : out    vl_logic
    );
end Hazard_Detection_Unit;
