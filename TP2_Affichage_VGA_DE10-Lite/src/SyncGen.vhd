library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SyncGen is port(
    rst      	: IN  std_logic;         -- reset de l'interface
    clk		   : IN  std_logic;         -- horloge pixel
	 c_h    		: OUT integer range 0 to 1023;
	 c_v    		: OUT integer range 0 to 1023;
	 hor_sync   : OUT std_logic;    -- synchronisation horizentale
	 ver_sync   : OUT std_logic );  -- synchronisation verticale
END entity SyncGen;


ARCHITECTURE struct OF SyncGen IS
	signal v,h : integer range 0 to 1023;

  component countVH is
    port (
      rst      	: IN  std_logic;
      clk		   : IN  std_logic;
  	  c_h    : OUT integer range 0 to 1023;
  	  c_v    : OUT integer range 0 to 1023
    );
  end component;

  component SyncVH is
    port (
      rst      	: IN  std_logic;
      clk		   : IN  std_logic;
      c_v   		: IN integer range 0 to 1023;
      c_h   		: IN integer range 0 to 1023;
      hor_sync   : OUT std_logic;
      ver_sync   : OUT std_logic
    );
  end component;

BEGIN

  c_v <= v;
  c_h <= h;

  cvh: countVH port map (
    rst => rst,
    clk => clk,
    c_h => h,
    c_v  => v
  );

  svh: SyncVH port map(
    rst => rst,
    clk => clk,
    c_v => v,
    c_h => h,
    hor_sync => hor_sync,
    ver_sync => ver_sync
  );

END struct;
