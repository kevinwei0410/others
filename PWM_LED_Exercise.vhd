library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity PWM_LED_Exercise is
	port(
	      clk:in std_logic;			
			LED:out std_logic_vector(9 downto 0);
			reset: in std_logic							--本作業新加入的輸入變數
			);
end PWM_LED_Exercise;
architecture PWM_LED_Exercise of PWM_LED_Exercise is

signal divcnt:std_logic_vector(8 downto 0);			--先除 500 所使用的counter
signal cnt:std_logic_vector(9 downto 0); 				--0~1023
signal cnt_2 : std_logic_vector(24 downto 0);		--數0-250000000 的counter
signal cnt_3 : std_logic_vector(3 downto 0);			-- 數0-9，用來記錄較強的燈泡顯示要在哪個燈泡
begin

			process(clk, reset)
			begin	
				if reset = '0' then
						divcnt <= "000000000";
				else
					if clk'event and clk = '1' then
						if divcnt = "111110100" then			-- 数到500
							divcnt <= "000000000";
						else
							divcnt <= divcnt + 1;				-- ++
						end if;
					end if;
				end if;
			end process;
			
			
			process(divcnt(8), reset)
			begin
				if reset = '0' then
					cnt <= "0000000000";							-- reset發生時
				else
					if divcnt(8)'event and divcnt(8) = '1' then 	--最高位元的正元觸發即是clock cycle
						cnt <= cnt + 1;
					end if;
				end if;
			end process;
			
			
			process(clk)
				begin	
				if reset = '0' then
					cnt_2 <=   "0000000000000000000000000";		--reset happened 
					cnt_3 <= x"0";
				else
					if clk'event and clk = '1' then
						if cnt_3 = x"9" then
							cnt_3 <= x"0";									--BCD counter歸零
							cnt_2 <= cnt_2 + 1;			
						elsif cnt_2 = "1011111010111100000111111" then --數到‭24999999‬
							cnt_2 <=   "0000000000000000000000000";			--歸零
							cnt_3 <= cnt_3 + 1;
						else
							cnt_2 <= cnt_2 + 1;
						end if;
					end if;
				end if;
			end process;
			
			
			
			LED(0) <= '1' when cnt_3 = x"0" and cnt < 1000 else 		--如果BCD counter數到0，輸出強版本的光，其餘輸出弱版本的光
						 '1' when cnt < 100  else
						 '0';
			LED(1) <= '1' when cnt_3 = x"1" and cnt < 1000 else		--如果BCD counter數到1，輸出強版本的光，其餘輸出弱版本的光
						 '1' when cnt < 100  else
						 '0';
			LED(2) <= '1' when cnt_3 = x"2" and cnt < 1000 else		--如果BCD counter數到2，輸出強版本的光，其餘輸出弱版本的光
						 '1' when cnt < 100  else
						 '0';
			LED(3) <= '1' when cnt_3 = x"3" and cnt < 1000 else		--如果BCD counter數到3，輸出強版本的光，其餘輸出弱版本的光
						 '1' when cnt < 100  else
						 '0';
			LED(4) <= '1' when cnt_3 = x"4" and cnt < 1000 else		--如果BCD counter數到4，輸出強版本的光，其餘輸出弱版本的光
						 '1' when cnt < 100  else
						 '0';
			LED(5) <= '1' when cnt_3 = x"5" and cnt < 1000 else		--如果BCD counter數到5，輸出強版本的光，其餘輸出弱版本的光
						 '1' when cnt < 100  else
						 '0';
			LED(6) <= '1' when cnt_3 = x"6" and cnt < 1000 else		--如果BCD counter數到6，輸出強版本的光，其餘輸出弱版本的光
						 '1' when cnt < 100  else
						 '0';
			LED(7) <= '1' when cnt_3 = x"7" and cnt < 1000 else		--如果BCD counter數到7，輸出強版本的光，其餘輸出弱版本的光
						 '1' when cnt < 100  else
						 '0';
			LED(8) <= '1' when cnt_3 = x"8" and cnt < 1000 else		--如果BCD counter數到8，輸出強版本的光，其餘輸出弱版本的光
						 '1' when cnt < 100  else
						 '0';
			LED(9) <= '1' when cnt_3 = x"9" and cnt < 1000 else		--如果BCD counter數到9，輸出強版本的光，其餘輸出弱版本的光
						 '1' when cnt < 100  else
						 '0';
			
			
end PWM_LED_Exercise;