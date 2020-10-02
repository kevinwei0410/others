library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity clk_1HZ is
	port(
	      clk:in std_logic;
			clk1:out std_logic
			);
end clk_1HZ;
architecture clk_1HZ of clk_1HZ is
signal cnt:std_logic_vector(25 downto 0);
begin
		process(clk)
		begin
				if clk'event and clk = '1' then 
					if cnt =  "10111110101111000001111111" then
					   cnt <= "00000000000000000000000000";
					else
				      cnt <= cnt + 1;
				   end if;
		      end if;
	   end process;			
		
		clk1 <= cnt(25);
		
end clk_1HZ;	