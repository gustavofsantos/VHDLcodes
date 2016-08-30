library verilog;
use verilog.vl_types.all;
entity ula_vlg_sample_tst is
    port(
        clock           : in     vl_logic;
        func            : in     vl_logic_vector(31 downto 0);
        opcode          : in     vl_logic_vector(31 downto 0);
        rd              : in     vl_logic_vector(31 downto 0);
        rs              : in     vl_logic_vector(31 downto 0);
        rt              : in     vl_logic_vector(31 downto 0);
        shamt           : in     vl_logic_vector(31 downto 0);
        sampler_tx      : out    vl_logic
    );
end ula_vlg_sample_tst;
