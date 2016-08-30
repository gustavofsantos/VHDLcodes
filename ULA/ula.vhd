--****************************************--
-- Autor: Gustavo Santos						--
-- Email: gfdsantos at inf ufpel edu br	--
--------------------------------------------
-- Universidade Federal de Pelotas			--
-- Sistemas Digitais Avançados 2016/2		--
--****************************************--

library ieee;
use ieee.std_logic_1164.all; 	-- para usar o tipo std_logic
use ieee.numeric_std.all;		-- para usar o tipo inteiro e as operações aritméticas

-- definição da entidade
-- 	a ula funcionará como um processador de instruções
entity ula is
	port(
		clock:  in  std_logic;-- sinal de clock
		opcode: in  integer;  -- código de operação (a mesma sempre, foi criada uma porta para ela para manter o padrão)
		rs:     in  integer;  -- registrador
		rt:     in  integer;  -- registrador 
		rd:     in  integer;  -- registrador destino
		shamt:  in  integer;  -- campo de deslocamento (não foi usado)
		func:   in  integer;  -- campo de selecionamento de funções (SOMA, SUB, MULT, AND, OR, NOT)
		res:    out integer;  -- saída do banco de registradores
		saida:  out integer); -- saída da variável interna que armazena o resultado das operações
end ula;

architecture arquitetura of ula is
-- codigo das operações (mais educativo)
constant cod_soma: integer := 1;
constant cod_subt: integer := 2;
constant cod_mult: integer := 3;
constant cod_and:  integer := 4;
constant cod_or:   integer := 5;
constant cod_not:  integer := 6;

-- cria um tipo de dado como array de inteiros de 32 posições (32 registradores)
type banco_de_registradores is array (31 downto 0) of integer;

-- define bdr como o banco de registradores 
signal bdr: banco_de_registradores;

-- sinal temporário para armazenar o resultado das operações
signal resultado: integer;

-- função que calcula a operação de AND entre dois inteiros
function int_and(op1, op2: integer) return integer is
variable vet_op1, vet_op2, vet_res: std_logic_vector(31 downto 0);
variable int_res: integer;
begin
	vet_op1 := std_logic_vector(to_unsigned(op1, 32));
	vet_op2 := std_logic_vector(to_unsigned(op2, 32));
	vet_res := vet_op1 and vet_op2;
	int_res := to_integer(unsigned(vet_res));
	return int_res;
end int_and;

-- função que calcula a operação de OR entre dois inteiros
function int_or(op1, op2: integer) return integer is
variable vet_op1, vet_op2, vet_res: std_logic_vector(31 downto 0);
variable int_res: integer;
begin
	vet_op1 := std_logic_vector(to_unsigned(op1, 32));
	vet_op2 := std_logic_vector(to_unsigned(op2, 32));
	vet_res := vet_op1 or vet_op2;
	int_res := to_integer(unsigned(vet_res));
	return int_res;
end int_or;

-- função que calcula a operação de NOT em um inteiro
function int_not(op: integer) return integer is
variable vet_op, vet_res: std_logic_vector(31 downto 0);
variable int_res: integer;
begin
	vet_op  := std_logic_vector(to_unsigned(op, 32));
	vet_res := not vet_op;
	int_res := to_integer(unsigned(vet_res));
	return int_res;
end int_not;

-- logica da ula
begin
	process(clock)
	begin
		-- o campo OPCODE foi ignorado, pois foi levado em conta
		-- que o opcode é sempre o mesmo (operação na ULA)
		if rising_edge(clock) then
			if (func = cod_soma) then
				resultado <= rs + rt;
			elsif (func = cod_subt) then
				resultado <= rs - rt;
			elsif (func = cod_mult) then
				resultado <= rs * rt;
			elsif (func = cod_and) then
				resultado <= int_and(rs, rt);
			elsif (func = cod_or) then
				resultado <= int_or(rs, rt);
			elsif (func = cod_not) then
				resultado <= int_not(rs);
			end if;
			-- salva na posição passada no campo RD o resultado da operação realizada
			bdr(rd) <= resultado;
			-- redireciona os resultados para a saída
			saida <= resultado;
			res <= bdr(rd);
		end if;
	end process;
end arquitetura;