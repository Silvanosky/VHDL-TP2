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
   blue     	: out std_logic_vector(3 downto 0);
	switch_h : in std_logic_vector(4 downto 0);
	switch_v : in std_logic_vector(4 downto 0)
	);        
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
			if 639 < c_h and c_h <= 799 then
				red   <= (others =>'0');
				green <= (others =>'0');
				blue  <= (others =>'0');
			elsif 479 < c_v and c_v <= 524 then
				red   <= (others =>'0');
				green <= (others =>'0');
				blue  <= (others =>'0');
			elsif switch = '0' then
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
				end if;
			else
				if 0 <= c_v and c_v < 60 then
					red   <= x"0";
					green <= x"0";
					blue  <= x"0";
				elsif 60 <= c_v and c_v < 120 then
					red   <= x"F";
					green <= x"0";
					blue  <= x"0";
				elsif 120 <= c_v and c_v < 180 then
					red   <= x"0";
					green <= x"F";
					blue  <= x"0";
				elsif 180 <= c_v and c_v < 240 then
					red   <= x"F";
					green <= x"F";
					blue  <= x"0";
				elsif 240 <= c_v and c_v < 300 then
					red   <= x"0";
					green <= x"0";
					blue  <= x"F";
				elsif 300 <= c_v and c_v < 360 then
					red   <= x"F";
					green <= x"0";
					blue  <= x"F";
				elsif 360 <= c_v and c_v < 420 then
					red   <= x"0";
					green <= x"F";
					blue  <= x"F";
				elsif 420 <= c_v and c_v < 480 then
					red   <= x"F";
					green <= x"F";
					blue  <= x"F";
				end if;
			end if;
		END IF;
	END PROCESS;
END architecture;

architecture struct of colours is
	signal addr : std_logic_vector(14 downto 0);
	signal aclr : std_logic;
	signal clken : std_logic;
	signal q : STD_LOGIC_VECTOR (2 DOWNTO 0);
	signal Ppixel, Pligne : integer range 0 to 1023;
begin
	Ppixel <= to_integer(unsigned(switch_h));
	Pligne <= to_integer(unsigned(switch_v));
	s0: entity work.compteur_adresse(RTL2) port map (rst => rst, clk => clk, c_v => c_v, c_h => c_h, addr => addr, aclr => aclr, clken => clken, Pligne => Pligne, Ppixel => Ppixel);
	s1: entity work.ROM_Image port map (clock => clk, clken => clken, aclr => aclr, address => addr, q => q);
	PROCESS(clk,rst)
	BEGIN
		IF rst = '1'  THEN
			red <= (others =>'0');
			green <= (others =>'0');
			blue <= (others =>'0');
		elsif rising_edge(clk)then
			if 639 < c_h and c_h <= 799 then
				red   <= (others =>'0');
				green <= (others =>'0');
				blue  <= (others =>'0');
			elsif 479 < c_v and c_v <= 524 then
				red   <= (others =>'0');
				green <= (others =>'0');
				blue  <= (others =>'0');
			else
				red   <= (others => q(0));
				green <= (others => q(1));
				blue  <= (others => q(2));
			end if;
		END IF;
	END PROCESS;
end architecture;
			
