library ieee;
use ieee.std_logic_1164.all;

entity conta2display is
port(
	clk: in std_logic; --Tomará el reloj de la tarjeta como entrada.
	ssg0: out std_logic_vector(6 downto 0); --Arreglo de 7 bits para el primer display de 7 segmentos.
	ssg1: out std_logic_vector(6 downto 0); --Salida para el segundo display.
	banderaSal: out std_logic --Variable que se utlizará para el tercer display en la siguiente actividad.
	);
end entity;

architecture arqconta2display of conta2display is
signal bandera: std_logic; --Señal que llevará el valor de la bandera de una entidad a otra.
signal conteo: integer range 0 to 9; --Señal que llevará el entero a mostrar en el segundo display.
begin
	u4: entity work.contador2(arqcontador2) port map(clk, ssg1, bandera); --Al contador modificado le damos como entrada
  -- al reloj de la tarjeta, le asignamos su salida ssg a nuestra salida ssg0, y su salida bandera a nustra señal bandera.
	
	u5: entity work.cont2(arqcont2) port map(bandera, conteo, banderaSal); --Al cont modificado le damos la señal bandera
  -- como su entrada clk, su salida conteo se la asignamos a nuestra señal conteo y su salida bandera a nuestra salida banderaSal.
	
	u6: entity work.ss7(arqss7) port map(conteo, ssg0); --Le pasamos el valor de la señal conteo como entrada para
  -- convertirlo a los valores del display y le asignamos su salida a nustra salida ssg1 para el segundo display.
end architecture;