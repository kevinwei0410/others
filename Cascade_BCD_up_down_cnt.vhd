library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Cascade_BCD_up_down_cnt is
	port(
	      clk:in std_logic;
			reset:in std_logic;
         casin:in std_logic;
			casout:out std_logic;
			BCD:out std_logic_vector(3 downto 0);
			UP_DOWN : in std_logic
			);
end Cascade_BCD_up_down_cnt;
architecture Cascade_BCD_up_down_cnt of Cascade_BCD_up_down_cnt is
signal cnt:std_logic_vector(3 downto 0);
begin
		process(clk,reset)
		begin
				if reset = '0' then
					cnt <= "0000";
				elsif clk'event and clk = '1' and casin = '1'then
					if UP_DOWN = '1' then	-- count up
						if cnt = "1001" then	
					      cnt <= "0000";	
						else
					       cnt <= cnt  + 1;
						end if;
					elsif UP_DOWN = '0' then	-- count down
						if cnt = "0000" then
							cnt <= "1001";
						else
							cnt <= cnt - 1;
						end if;
					end if;
				end if;
		end process;

		casout <= '1' when casin = '1' and cnt = "1001" and UP_DOWN = '1' else
	             '1' when casin = '1' and cnt = "0000" and UP_DOWN = '0' else
					 '0';
		
      BCD <= cnt;
		
		
end Cascade_BCD_up_down_cnt;	