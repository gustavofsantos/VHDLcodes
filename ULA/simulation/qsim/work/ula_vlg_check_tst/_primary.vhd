library verilog;
use verilog.vl_types.all;
entity ula_vlg_check_tst is
    port(
        res             : in     vl_logic_vector(31 downto 0);
        saida           : in     vl_logic_vector(31 downto 0);
        sampler_rx      : in     vl_logic
    );
end ula_vlg_check_tst;
