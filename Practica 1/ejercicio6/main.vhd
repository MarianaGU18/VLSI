

library ieee;
use ieee.std_logic_1164.all;

entity main is
  port (
    -- Reloj de entrada
    clk   : in std_logic;   
    -- Salidas a cada display de 7 segmentos (uno para cada dígito)
    ssg0  : out std_logic_vector(6 downto 0);
    ssg1  : out std_logic_vector(6 downto 0);
    ssg2  : out std_logic_vector(6 downto 0);
    ssg3  : out std_logic_vector(6 downto 0)
  );
end entity;

architecture arqmain of main is
    -- Señal interna para el reloj dividido (señal lenta para los contadores)
  signal clkl                           : std_logic := '0';

-- Señales internas para almacenar los valores de cada dígito del reloj (4 dígitos en total)
  signal count1, count2, count3, count4 : integer   := 0;

  -- Señales de bandera que indican cuándo cada contador ha alcanzado su valor máximo
  signal flag1, flag2, flag3, flag4     : std_logic := '0';

  -- Señal de reset para reiniciar los contadores cuando se alcanza la hora 23:59
  signal rst                            : std_logic := '0';
  
  
  
begin
  -- Entidad del divisor de frecuencias
  u1 : entity work.divfreq(rtl) port map (clk, clkl);

  -- Etidades para cada uno de los contadores
  c1 : entity work.cont(arqcont) -- Unidades segundos
    generic map(max_count => 9)
    port map(clkl, count1, rst, flag1);
	 
  c2 : entity work.cont(arqcont) -- Decenas segundos
    generic map(max_count => 5)
    port map(flag1, count2, rst, flag2);
	 
  c3 : entity work.cont(arqcont) -- Unidades hora
    generic map(max_count => 9) 
    port map(flag2, count3, rst, flag3);
	 
  c4 : entity work.cont(arqcont) -- Decenas hora
    generic map(max_count => 2) 
    port map(flag3, count4, rst, flag4);

  -- Salidas para cada display
  d1 : entity work.ss7(arqss7) port map(count1, ssg3);
  d2 : entity work.ss7(arqss7) port map(count2, ssg2);
  d3 : entity work.ss7(arqss7) port map(count3, ssg1);
  d4 : entity work.ss7(arqss7) port map(count4, ssg0);

  -- Proceso para verificar cuando llegue a 23:59, se considera el contador 
 -- de las decenas llega a 2 y el de las unidades a 4, en ese momento se reinician todos los contadores.
  process (clk, rst)
  begin
    if rising_edge(clk) then
      if count4 = 2 and count3 = 4 then
        rst <= '1';
      else
        rst <= '0';
      end if;
    end if;
  end process;
  
end architecture;

