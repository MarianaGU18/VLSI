library ieee;
use ieee.std_logic_1164.all;

entity main is
  port
  (
    clk : in std_logic; -- Reloj de la tarjeta
    ssg : out std_logic_vector(6 downto 0) -- Salida a un display de 7 segmentos
  );
end entity;

architecture arqcontador of main is
  signal clkl : std_logic; -- Señal de reloj ralentizada
  signal a    : integer range 0 to 9; -- Señal del contador
begin
  -- Entidad divisor de frecuencia, de entrada tiene la señal de reloj de la 
  -- tarjeta (a 50MHz) y retorna una señal con velocidad menor.
  u1: entity work.divfreq(rtl) port map(clk, clkl);
  -- Entidad contador, recibe de entrada la señal de reloj ralentizada y
  -- de salida el contador en un número entero.
  u2: entity work.cont(arqcont) port map(clkl, a);
  -- Entidad que convierte la entrada de un número entero en la salida
  -- a los display de siete segmentos.
  u3: entity work.ss7(arqss7) port map(a, ssg);
end architecture;