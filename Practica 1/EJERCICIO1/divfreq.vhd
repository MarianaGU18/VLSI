library ieee;
use ieee.std_logic_1164.all;

entity divfreq is
  port
  (
    clk  : in std_logic; -- De entrada se recibe una señal de reloj
    clkl : buffer std_logic -- De salida se retorna una señal ralentizada
  );
end entity;

architecture rtl of divfreq is
  -- Internamente se tiene un contador para los flancos de subida.
  -- En este caso, se limita en 25 millones, es decir, 25MHz
  signal contador : integer range 0 to 25000000;
begin
  -- En la lista de sensibilidad se toma en cuenta la señal de reloj de entrada.
  process (clk)
  begin
    -- Entra en el if en cada flanco de subida
    if (rising_edge(clk)) then
      if (contador = 25000000) then
        -- Si el contador llegó a su límite, se reinicia y se invierte la salida
        contador <= 0;
        clkl     <= not clkl;
      else
        -- En caso contrario, se aumenta en uno.
        contador <= contador + 1;
      end if;
    end if;
  end process;
end architecture;