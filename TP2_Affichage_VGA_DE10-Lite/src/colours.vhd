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
 	 	
    END IF;
  END PROCESS;
END architecture;

architecture struct of colours is
begin
	
end architecture;
			
