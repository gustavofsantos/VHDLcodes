library verilog;
use verilog.vl_types.all;
entity ula is
    port(
        clock           : in     vl_logic;
        opcode          : in     vl_logic_vector(31 downto 0);
        rs              : in     vl_logic_vector(31 downto 0);
        rt              : in     vl_logic_vector(31 downto 0);
        rd              : in     vl_logic_vector(31 downto 0);
        shamt           : in     vl_logic_vector(31 downto 0);
        func            : in     vl_logic_vector(31 downto 0);
        res             : out    vl_logic_vector(31 downto 0);
        saida           : out    vl_logic_vector(31 downto 0)
    );
end ula;
