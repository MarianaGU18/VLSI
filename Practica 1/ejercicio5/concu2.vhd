library ieee;
use ieee.std_logic_1164.all;

entity concu2 is
  port
  (
    clk   : in std_logic;
    ssg0  : out std_logic_vector(6 downto 0);
    ssg1  : out std_logic_vector(6 downto 0);
    carry : out std_logic
  );
end entity;

architecture arqmain of concu2 is
  signal clkl             : std_logic                   := '0';
  signal contador         : integer range 0 to 25000000 := 0;
  signal conteo1, conteo2 : integer                     := 0;
  signal bandera1         : std_logic                   := '0';
  signal bandera2         : std_logic                   := '0';

begin

	--divisor de frecuencia
	--=======================
	process(clk)--entrada
		begin
				if(rising_edge(clk)) then
					if(contador=25000000) then
						contador<=0;
						clkl<= not clkl; --salida
					else
						contador<= contador+1;
					end if;
				end if;
		end process;

 -- Proceso del contador 1
  process (clkl)
  begin
    if (rising_edge(clkl)) then
      if (conteo1 = 9) then
        conteo1  <= 0; -- salida 1
        bandera1 <= '1'; -- salida 2
          else
          conteo1  <= conteo1 + 1;
        bandera1 <= '0';
      end if;
    end if;
  end process;
  carry <= bandera1;
-- FIN del Proceso del contador 1

-- Proceso del contador 2;
  process (bandera1)
  begin
    if (rising_edge(bandera1)) then
      if (conteo2 = 9) then
        conteo2  <= 0;
        bandera2 <= '1';
      else
        conteo2  <= conteo2 + 1;
        bandera2 <= '0';
      end if;
    end if;
  end process;
-- FIN del Proceso del contador 2
 
 with conteo1 select  --Entrada
 ssg1<= "1000000" when 0, --salida
		 "1111001" when 1,
		 "0100100" when 2,
		 "0110000" when 3,
		 "0011001" when 4,
		 "0010010" when 5,
		 "0000010" when 6,
		 "1111000" when 7,
		 "0000000" when 8,
		 "0011000" when 9,
		 "1111111" when others;

with conteo2 select  --Entrada
 ssg0<= "1000000" when 0, --salida
		 "1111001" when 1,
		 "0100100" when 2,
		 "0110000" when 3,
		 "0011001" when 4,
		 "0010010" when 5,
		 "0000010" when 6,
		 "1111000" when 7,
		 "0000000" when 8,
		 "0011000" when 9,
		 "1111111" when others;

  
end architecture;