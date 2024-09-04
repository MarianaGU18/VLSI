library ieee;
use ieee.std_logic_1164.all;

entity ss7 is
  port (
    value       : in integer; -- Se recibe un número entero de entrada
    display_out : out std_logic_vector(6 downto 0) -- Se retorna un arreglo
    -- para el display de siete segmentos
  );
end entity;

architecture arqss7 of ss7 is
begin
  -- Dependiendo de la entrada, se ajusta la salida para representar el número
  -- en el display de siete segmentos
  with value select
    display_out <= "1000000" when 0,
    "1111001" when 1,
    "0100100" when 2,
    "0110000" when 3,
    "0011001" when 4,
    "0010010" when 5,
    "0000010" when 6,
    "1111000" when 7,
    "0000000" when 8,
    "0011000" when 9,
    "1111111" when others; -- Si el número no es válido, el display
    -- se apaga.
end architecture;