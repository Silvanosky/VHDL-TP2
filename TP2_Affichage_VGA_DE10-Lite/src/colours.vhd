library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity colours is port(
   rst      	: IN  std_logic;         -- reset de l'interface
   clk		    : IN  std_logic;         -- horloge pixel
   c_v   		: IN integer range 0 to 1023;        
   c_h   		: IN integer range 0 to 1023;
   switch 	    : in std_logic;
   red			: out std_logic_vector(3 downto 0); 
   green		: out std_logic_vector(3 downto 0); 
   blue     	: out std_logic_vector(3 downto 0) );        
END entity colours;


ARCHITECTURE mire OF colours IS
BEGIN
	PROCESS(clk,rst)
	BEGIN  
		IF rst = '1'  THEN
			red <= (others =>'0');
			green <= (others =>'0');
			blue <= (others =>'0'); 
		elsif rising_edge(clk)then
			if 0 <= c_h and c_h < 80 then
				red   <= x"0";
				green <= x"0";
				blue  <= x"0";
			elsif 80 <= c_h and c_h < 160 then
				red   <= x"F";
				green <= x"0";
				blue  <= x"0";
			elsif 160 <= c_h and c_h < 240 then
				red   <= x"0";
				green <= x"F";
				blue  <= x"0";
			elsif 240 <= c_h and c_h < 320 then
				red   <= x"F";
				green <= x"F";
				blue  <= x"0";
			elsif 320 <= c_h and c_h < 400 then
				red   <= x"0";
				green <= x"0";
				blue  <= x"F";
			elsif 400 <= c_h and c_h < 480 then
				red   <= x"F";
				green <= x"0";
				blue  <= x"F";
			elsif 480 <= c_h and c_h < 560 then
				red   <= x"0";
				green <= x"F";
				blue  <= x"F";
			elsif 560 <= c_h and c_h < 640 then
				red   <= x"F";
				green <= x"F";
				blue  <= x"F";
			else
				red   <= (others =>'0');
				green <= (others =>'0');
				blue  <= (others =>'0'); 
			end if;
		END IF;
	END PROCESS;
END architecture;

architecture struct of colours is
begin
	
end architecture;
			
