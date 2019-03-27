LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY SyncGen_tb IS
END ENTITY SyncGen_tb;

--
ARCHITECTURE bench OF SyncGen_tb IS
signal PixFreq : positive := 25000E3 ;  --25 MHz
signal PixPeriod : time := 1 sec /PixFreq; 
signal LinePeriod : time := 800 * PixPeriod ; -- 31469 Hz line frequency
signal FieldPeriod : time := 525 * LinePeriod;
signal clk,rst,hor_sync,ver_sync : std_logic;
signal test : boolean := true;


BEGIN
	--clk <= not clk after period;
	rst <= '1','0' after PixPeriod;
 	clk_generate:process
  begin
 
  while test=TRUE loop
    clk <= '0';
    wait for PixPeriod/2;
    clk <= '1';
    if ((PixPeriod/2)*2 = PixPeriod) then
    	wait for PixPeriod/2;
    else 
    	wait for (PixPeriod/2 + 1 ns);
    end if;
  end loop;
  wait;
  end process;
  
process
 variable t1, t2,t3: time := 0 ns;	
  begin
  	wait until falling_edge(hor_sync);
  		t1 := NOW;
  	wait until rising_edge(hor_sync);
  		t2 := NOW;
  		report "Horizontal Sync Pulse = " & time'image(t2-t1) ;
  		assert t2-t1 = 96*PixPeriod report "Error on Horizontal Sync Pulse! It must be 3840 ns" severity failure;
  	wait until falling_edge(hor_sync);-- for 2*LinePeriod;
  	--assert hor_sync'event report "Horizontal Synchro didn't come up in 2xLinePeriod !" severity failure;
  		t3 := NOW; 
  		report "Line Period = " & time'image(t3-t1) ;	
  		assert t3-t1 = LinePeriod report "Error on Line Period! It must be 32000 ns "  severity failure;
  	
  	
  	wait until falling_edge(ver_sync) for FieldPeriod;
	assert ver_sync'event report "Vertical Synchro didn't come up in FieldPeriod !" severity failure;
		t1 := NOW;
	wait until rising_edge(ver_sync);
  		t2 := NOW;
  		report "Vertical Sync Pulse = " & time'image(t2-t1) ;
  		assert t2-t1 = 2*LinePeriod report "Error on Vertical sync Pulse! It must be 64000 ns" severity failure;
	wait until falling_edge(ver_sync);
		t3 := NOW;
	report "Field Period = " & time'image(t3-t1) ;	
  	assert t3-t1 = FieldPeriod report "Error on Field Period! It must be 16800000 ns "  severity failure;
	
  	 
  	report "**************** Synchronisation timing is alright !********************";
                                          
  	wait for (5*FieldPeriod); 
  	test <= false;
  wait;
  end process;
  
  
 
  
  UUT : entity work.SyncGen
                 port map ( clk 	=> clk,
  			 						 rst 	=> rst,
  			 						 c_h => open,
  			 						 c_v => open,
                            hor_sync => hor_sync,
                            ver_sync => ver_sync );
                            
                            
                            
                            
END ARCHITECTURE bench;
