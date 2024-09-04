library ieee;
use ieee.std_logic_1164.all;

entity cont2 is
port
	(
	clk: in std_logic;
	conteo: buffer integer;
	bandera: out std_logic --Añadimos otra salida al contador.
	);
end entity;

architecture arqcont2 of cont2 is
begin
	process (clk)
		begin
			if (rising_edge(clk)) then
				if (conteo = 9) then
					conteo <= 0;
					bandera <= '1'; --Cuando el conteo se reinicia, se activa la bandera.
				else
					conteo <= conteo + 1;
					bandera <= '0'; --Mientras se hace el conteo de 0 a 9, la bandera se mantiene en 0.
				end if;
			end if;
	end process;
end architecture;