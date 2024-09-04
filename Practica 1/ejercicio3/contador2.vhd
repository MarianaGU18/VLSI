library ieee;
use ieee.std_logic_1164.all;

entity contador2 is
port(
	clk: in std_logic;
	ssg: out std_logic_vector(6 downto 0);
	bandera: out std_logic --Añadimos otra salida que contiene la bandera de cont2.
	);
end entity;

architecture arqcontador2 of contador2 is
signal clkl: std_logic;
signal conteo: integer range 0 to 9;
begin
	u1: entity work.divf(arqdivf) port map(clk,clkl);
	u2: entity work.cont2(arqcont2) port map(clkl,conteo, bandera); --Le pasamos la bandera del cont modificado a nustra nueva bandera.
	u3: entity work.ss7(arqss7) port map(conteo,ssg);
end architecture;