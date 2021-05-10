library verilog;
use verilog.vl_types.all;
entity Condition_Check is
    generic(
        EQ              : vl_logic_vector(3 downto 0) := (Hi0, Hi0, Hi0, Hi0);
        NE              : vl_logic_vector(3 downto 0) := (Hi0, Hi0, Hi0, Hi1);
        CS_HS           : vl_logic_vector(3 downto 0) := (Hi0, Hi0, Hi1, Hi0);
        CC_LO           : vl_logic_vector(3 downto 0) := (Hi0, Hi0, Hi1, Hi1);
        MI              : vl_logic_vector(3 downto 0) := (Hi0, Hi1, Hi0, Hi0);
        PL              : vl_logic_vector(3 downto 0) := (Hi0, Hi1, Hi0, Hi1);
        VS              : vl_logic_vector(3 downto 0) := (Hi0, Hi1, Hi1, Hi0);
        VC              : vl_logic_vector(3 downto 0) := (Hi0, Hi1, Hi1, Hi1);
        HI              : vl_logic_vector(3 downto 0) := (Hi1, Hi0, Hi0, Hi0);
        LS              : vl_logic_vector(3 downto 0) := (Hi1, Hi0, Hi0, Hi1);
        GE              : vl_logic_vector(3 downto 0) := (Hi1, Hi0, Hi1, Hi0);
        LT              : vl_logic_vector(3 downto 0) := (Hi1, Hi0, Hi1, Hi1);
        GT              : vl_logic_vector(3 downto 0) := (Hi1, Hi1, Hi0, Hi0);
        LE              : vl_logic_vector(3 downto 0) := (Hi1, Hi1, Hi0, Hi1);
        AL              : vl_logic_vector(3 downto 0) := (Hi1, Hi1, Hi1, Hi0)
    );
    port(
        condition       : in     vl_logic_vector(3 downto 0);
        Status_Register : in     vl_logic_vector(3 downto 0);
        condition_state : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of EQ : constant is 2;
    attribute mti_svvh_generic_type of NE : constant is 2;
    attribute mti_svvh_generic_type of CS_HS : constant is 2;
    attribute mti_svvh_generic_type of CC_LO : constant is 2;
    attribute mti_svvh_generic_type of MI : constant is 2;
    attribute mti_svvh_generic_type of PL : constant is 2;
    attribute mti_svvh_generic_type of VS : constant is 2;
    attribute mti_svvh_generic_type of VC : constant is 2;
    attribute mti_svvh_generic_type of HI : constant is 2;
    attribute mti_svvh_generic_type of LS : constant is 2;
    attribute mti_svvh_generic_type of GE : constant is 2;
    attribute mti_svvh_generic_type of LT : constant is 2;
    attribute mti_svvh_generic_type of GT : constant is 2;
    attribute mti_svvh_generic_type of LE : constant is 2;
    attribute mti_svvh_generic_type of AL : constant is 2;
end Condition_Check;
