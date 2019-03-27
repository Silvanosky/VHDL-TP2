library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity compteur_adresse is
port (
	c_v, c_h : integer range 0 to 1023;
	clk,rst : in std_logic;
	addr : out std_logic_vector(14 downto 0);
	aclr : out std_logic;
	clken : out std_logic);
end entity;

architecture RTL of compteur_adresse is
	signal cnt : integer range 0 to 2**15 - 1;
begin

	process(clk,rst)
	begin
		if rst = '1' then
			cnt <= 0;
			aclr <= '0';
			clken <= '0';
		elsif rising_edge(clk) then
			if c_h < 160 and c_v < 120 then
				aclr <= '0';
				cnt <= cnt + 1;
			else
				cnt <= 0;
				aclr <= '1';
			end if;
		end if;
	end process;
	
	addr <= std_logic_vector(to_unsigned(cnt,15));
end architecture;
	