library verilog;
use verilog.vl_types.all;
entity Forwarding_Unit is
    port(
        isForwardingActive: in     vl_logic;
        src1            : in     vl_logic_vector(3 downto 0);
        src2            : in     vl_logic_vector(3 downto 0);
        MEM_Dest        : in     vl_logic_vector(3 downto 0);
        WB_Dest         : in     vl_logic_vector(3 downto 0);
        MEM_WB_EN       : in     vl_logic;
        WB_WB_EN        : in     vl_logic;
        Alu_Src1_Sel    : out    vl_logic_vector(1 downto 0);
        Alu_Src2_Sel    : out    vl_logic_vector(1 downto 0)
    );
end Forwarding_Unit;
