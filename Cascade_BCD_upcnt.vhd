library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Cascade_BCD_upcnt is
	port(
	      clk:in std_logic;
			reset:in std_logic;
         casin:in std_logic;
			casout:out std_logic;
			BCD:out std_logic_vector(3 downto 0)
			);
end Cascade_BCD_upcnt;
architecture Cascade_BCD_upcnt of Cascade_BCD_upcnt is
signal cnt:std_logic_vector(3 downto 0);
begin
		process(clk,reset)
		begin
				if reset = '0' then
					cnt <= "0000";
				elsif clk'event and clk = '1' and casin = '1' then
						if cnt = "1001" then
					      cnt <= "0000";	
						else
					       cnt <= cnt  + 1;
						end if;
				end if;
		end process;

		casout <= '1' when casin = '1' and cnt = "1001" else
	             '0';
		
      BCD <= cnt;
		
		
end Cascade_BCD_upcnt;	