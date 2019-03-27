library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity compteur_adresse is
generic(
	
	Npixel : in integer range 0 to 1023 := 160;
	Nligne : in integer range 0 to 1023 := 120
);
port (
	c_v, c_h : integer range 0 to 1023;
	clk,rst : in std_logic;
	addr : out std_logic_vector(14 downto 0);
	aclr : out std_logic;
	clken : out std_logic;
	Ppixel : in integer range 0 to 1023;
	Pligne : in integer range 0 to 1023);
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
			clken <= '1';
			if Ppixel <= c_h and c_h < Ppixel + Npixel then
				if Pligne <= c_v and c_v < Pligne + Nligne then
					aclr <= '0';
					cnt <= cnt + 1;
				else
					aclr <= '1';
					cnt <= 0;
				end if;
			else
				aclr <= '1';	
			end if;
		end if;
	end process;
	
	addr <= std_logic_vector(to_unsigned(cnt,15));
end architecture;

architecture RTL2 of compteur_adresse is
	signal cnt : integer range 0 to 2**15 - 1;
	signal x : integer range 0 to 1023;
	signal y : integer range 0 to 1023;
begin

	process(clk,rst)
	begin
		if rst = '1' then
			cnt <= 0;
			aclr <= '0';
			clken <= '0';
		elsif rising_edge(clk) then
			if 0 <= c_h and c_h < 640 then
				if 0 <= c_v and c_v < 480 then
					aclr <= '0';
					x <= c_h / 4;
					y <= c_v / 4;
					clken <= '1';
					cnt <= y * Npixel + x;
				else
					aclr <= '1';
					clken <= '0';
					cnt <= 0;
				end if;
			else
				aclr <= '1';	
				clken <= '0';
			end if;
		end if;
	end process;
	
	addr <= std_logic_vector(to_unsigned(cnt,15));
end architecture;
	