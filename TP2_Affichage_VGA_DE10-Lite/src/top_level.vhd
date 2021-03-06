

LIBRARY ieee;
USE ieee.std_logic_1164.all; 


ENTITY top_level IS 
	PORT
	(
		CLOCK_50 :  IN  STD_LOGIC;
		KEY :  IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
		SW :  IN  STD_LOGIC_VECTOR(9 DOWNTO 0);
		VGA_VS :  OUT  STD_LOGIC;
		VGA_HS :  OUT  STD_LOGIC;
		VGA_B :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
		VGA_G :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
		VGA_R :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END entity;

ARCHITECTURE struct OF top_level IS 

SIGNAL	rst :  STD_LOGIC;
SIGNAL	clk_vga :  STD_LOGIC;
component VGA_Audio_PLL is
	port (
		inclk0   : in  std_logic := '0'; --  refclk.clk
		areset      : in  std_logic := '0'; --   reset.reset
		c0 : out std_logic;
		c1 : out std_logic;
		c2 : out std_logic;
		locked : out std_logic         -- outclk0.clk
	);
end component;


BEGIN 

U1 : entity work.interface_vga
PORT MAP(rst => rst,
		 clk => clk_vga,
		 switch => SW(0),
		 ver_sync => VGA_VS,
		 hor_sync => VGA_HS,
		 blue => VGA_B,
		 green => VGA_G,
		 red => VGA_R,
		 switch_h => SW(4 downto 0),
		 switch_v => SW(9 downto 5));

U2 : VGA_Audio_PLL
PORT MAP(inclk0 => CLOCK_50,
		 areset    => rst,
		 c0 => clk_vga);
		 
rst <= NOT(KEY(0));

END architecture;