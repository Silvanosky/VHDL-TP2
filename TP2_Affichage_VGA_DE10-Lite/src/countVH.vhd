library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity countVH is port(
    rst      	: IN  std_logic;         -- reset de l'interface
    clk		   : IN  std_logic;         -- horloge pixel
	 c_h    : OUT integer range 0 to 1023;     -- compteur de pixels
	 c_v    : OUT integer range 0 to 1023 );   -- compteur de lignes
	 
END entity countVH;


ARCHITECTURE RTL OF countVH IS
	signal  count_v, count_h : integer RANGE 0 TO 1023;
BEGIN
	PROCESS(clk,rst)
	BEGIN  

		IF rst = '1'  THEN
			count_v <= 0;
			count_h <= 0;

		elsif rising_edge(clk)then
			if count_h = 799 then
				count_h <= 0;
				if count_v = 524 then
					count_v <= 0;
				else 
					count_v <= count_v + 1;
				end if;
			else
				count_h <= count_h + 1;
			end if;
		END IF;
	END PROCESS;

	c_v <= count_v;
	c_h <= count_h;
END RTL;
