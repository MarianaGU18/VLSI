library ieee;
use ieee.std_logic_1164.all;

entity cont is
  port (
    clk    : in std_logic; -- Recibe de entrada un reloj
    conteo : buffer integer -- Como salida tiene un número
  );
end entity;

architecture arqcont of cont is
begin
  -- Process que tiene en la lista de sensibilidad la señal de reloj, esto
  -- quiere decir que cualquier cambio en esta señal activará el process.
  process (clk)
  begin
    -- Comprueba si la señal está en el flanco de subida
    if (rising_edge(clk)) then
      if (conteo = 9) then
        -- Si el conteo es 9 (el máximo) se reinicia el contador
        conteo <= 0;
      else
        -- En caso contrario, se suma 1 al contador
        conteo <= conteo + 1;
      end if;
    end if;
  end process;
end architecture;