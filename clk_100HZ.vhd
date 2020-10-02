library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity clk_100HZ is
	port(
	      clk:in std_logic;
			clk100:out std_logic
			);
end clk_100HZ;
architecture clk_100HZ of clk_100HZ is
signal cnt:std_logic_vector(18 downto 0);
begin
		process(clk)
		begin
				if clk'event and clk = '1' then 
					if cnt =  "1111010000100011111" then
					   cnt <= "0000000000000000000";
					else
				      cnt <= cnt + 1;
				   end if;
		      end if;
	   end process;			
		
		clk100 <= cnt(18);
		
end clk_100HZ;	