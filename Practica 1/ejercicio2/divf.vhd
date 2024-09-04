library ieee;
use ieee.std_logic_1164.all;

entity divf is
port
	(
	clk  : in std_logic; --Tomará el reloj de la tarjeta como entrada.
	clkl : buffer std_logic:='0' --Declaramos una variable para usar como un reloj más lento.
	);
end entity;

architecture arqdivf of divf is
signal contador : integer range 0 to 25000000; --Se declara una señal que contará desde 0 hasta 25000000.

begin
	process (clk)
		begin
			if (rising_edge(clk)) then --Si se detecta un flanco de subida en el reloj de la tarjeta, se procede a la condicional siguiente.
				if (contador = 25000000) then --Si el contador llega a 25000000, se regresa a 0 y se invierte el valor de clkl.
					contador <= 0;
					clkl     <= not clkl;
				else
					contador <= contador + 1; --Cada flanco de subida se le suma uno al contador.
				end if;
			end if;
	end process;
end architecture;