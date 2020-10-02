library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity pingpong is 
	port(
	      clk,reset,A,B:in std_logic;
			HEX0, HEX1, HEX2, HEX3:out std_logic_vector(6 downto 0);
	      L:out std_logic_vector(9 downto 0)
			);
end pingpong;

architecture pingpong of pingpong is
type state is (s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21);
signal present_state: state;
signal next_state : state;
signal cnt: std_logic_vector(24 downto 0);
signal clk2hz,score_A,score_B:std_logic;
signal scorecnt_A_1:std_logic_vector(3 downto 0);			-- A 的第1個位數
signal scorecnt_A_2:std_logic_vector(3 downto 0);			-- A 的第2個位數
signal scorecnt_B_1:std_logic_vector(3 downto 0);  		-- B 的第1個位數
signal scorecnt_B_2:std_logic_vector(3 downto 0);			-- B 的第2個位數
begin			

	process(clk)
	begin
			if clk'event and clk = '1' then
				if cnt =  "1011111010111100001000000" then
				   cnt <= "0000000000000000000000000";
				else 
					cnt <= cnt + 1;
				end if;
			end if;
	end process;

clk2hz <= cnt(24);

		process(clk2hz,reset)
		begin
				if reset = '0' then
					present_state <= s0;
	
				elsif clk2hz'event and clk2hz = '1' then
					present_state <= next_state;
				end if;
		end process;

		process(present_state)
		begin
				case present_state is
					when s0 =>
							if A = '0' then
								next_state <= s1;
							else
						      next_state <= s0;
							end if;
							L <= "0000000000";
							score_A <= '0';
							score_B <= '0';
					when s1 =>
							next_state <= s2;
							L <= "0000000001";
							score_A <= '0';
							score_B <= '0';
					when s2 =>
							next_state <= s3;
							L <= "0000000010";
							score_A <= '0';
							score_B <= '0';
					when s3 =>
							next_state <= s4;
							L <= "0000000100";
							score_A <= '0';
							score_B <= '0';
					when s4 =>
							next_state <= s5;
							L <= "0000001000";
							score_A <= '0';
							score_B <= '0';
					when s5 =>
							next_state <= s6;
							L <= "0000010000";
							score_A <= '0';
							score_B <= '0';
					when s6 =>
							next_state <= s7;
							L <= "0000100000";
							score_A <= '0';
							score_B <= '0';
					when s7 =>
							next_state <= s8;
							L <= "0001000000";
							score_A <= '0';
							score_B <= '0';
					when s8 =>						
							if B = '0' then		-- b miss
								next_state <= s0;
								score_A <= '1';
								score_B <= '0';
							else
								next_state <= s9;
								score_A <= '0';
								score_B <= '0';
							end if;
								L <= "0010000000";
					when s9 =>
							if B = '0' then
								next_state <= s0;	-- b miss
								score_A <= '1';
								score_B <= '0';
							else
								next_state <= s10;
								score_A <= '0';
								score_B <= '0';
							end if;
								L <= "0100000000";
					when s10 =>					
							if B = '1'then			-- B miss
								next_state <= s0;
								score_A <= '1';
								score_B <= '0';
							else							--B hit
								next_state <= s11;
								score_A <= '0';
								score_B <= '0';
							end if;
							L <= "1000000000";
					when s11 =>
							next_state <= s12;
							L <= "0100000000";
							score_A <= '0';
							score_B <= '0';
					when s12 =>
							next_state <= s13;
							L <= "0010000000";
							score_A <= '0';
							score_B <= '0';
					when s13 =>
							next_state <= s14;
							L <= "0001000000";
							score_A <= '0';
							score_B <= '0';
					when s14 =>
							next_state <= s15;
							L <= "0000100000";
					when s15 =>
							next_state <= s16;
							L <= "0000010000";
							score_A <= '0';
							score_B <= '0';
					when s16 =>
							next_state <= s17;
							L <= "0000001000";	
							score_A <= '0';
							score_B <= '0';						
					when s17 =>
							if A = '0' then			--a miss
							   next_state <= s20;
								score_A <= '0';
								score_B <= '1';
							else
								next_state <= s18;
								score_A <= '0';
								score_B <= '0';
							end if;
							L <= "0000000100";
					when s18 =>					
					      if A = '0' then			--a miss
							   next_state <= s20;
								score_A <= '0';
								score_B <= '1';
							else							
								next_state <= s19;
								score_A <= '0';
								score_B <= '0';
							end if;	
							L <= "0000000010";	
					when s19 =>
					      if A = '0' then		--A hit
							   next_state <= s2;
								score_A <= '0';
								score_B <= '0';
							else						-- A miss
								next_state <= s20;
								score_A <= '0';
								score_B <= '1';
							end if;
							L <= "0000000001";
					when s20 =>
							if B = '0' then
							   next_state <= s21;
							else
								next_state <= s20;
							end if;
							L <= "0000000000";
							score_A <= '0';
							score_B <= '0';
					when s21 =>
							next_state <= s11;
							L <= "1000000000";
							score_A <= '0';
							score_B <= '0';
				  end case;
			end process;
			
			
			process(score_A)					-- A 的分數計算
			begin
				if reset = '0' then
					scorecnt_A_2 <= "0000";
					scorecnt_A_1 <= "0000";
			   elsif score_A'event and score_A = '1' then
				   scorecnt_A_1 <= scorecnt_A_1 + 1;
					if scorecnt_A_1 = "1010" then
						scorecnt_A_1 <= "0000";
						scorecnt_A_2 <= scorecnt_A_2 + 1;
					end if;
				end if;
			end process;
			
			process(score_B)					-- B 的分數計算
			begin
				if reset = '0' then
					scorecnt_B_2 <= "0000";
					scorecnt_B_1 <= "0000";
			   elsif score_B'event and score_B = '1' then
				   scorecnt_B_1 <= scorecnt_B_1 + 1;
					if scorecnt_B_1 = "1010" then
						scorecnt_B_1 <= "0000";
						scorecnt_B_2 <= scorecnt_B_2 + 1;
					end if;
				end if;
			end process;	
			
			
			
		HEX0 <=  "1000000" when scorecnt_A_1 = "0000" else				--decoder for 第1個七段顯示
					"1111001" when scorecnt_A_1 = "0001" else
					"0100100" when scorecnt_A_1 = "0010" else
					"0110000" when scorecnt_A_1 = "0011" else
					"0011001" when scorecnt_A_1 = "0100" else
					"0010010" when scorecnt_A_1 = "0101" else
					"0000010" when scorecnt_A_1 = "0110" else
					"1111000" when scorecnt_A_1 = "0111" else
					"0000000" when scorecnt_A_1 = "1000" else
					"0010000" when scorecnt_A_1 = "1001" else
					"1111111";

		HEX1 <=  "1000000" when scorecnt_A_2 = "0000" else				--decoder for 第2個七段顯示
					"1111001" when scorecnt_A_2 = "0001" else
					"0100100" when scorecnt_A_2 = "0010" else
					"0110000" when scorecnt_A_2 = "0011" else
					"0011001" when scorecnt_A_2 = "0100" else
					"0010010" when scorecnt_A_2 = "0101" else
					"0000010" when scorecnt_A_2 = "0110" else
					"1111000" when scorecnt_A_2 = "0111" else
					"0000000" when scorecnt_A_2 = "1000" else
					"0010000" when scorecnt_A_2 = "1001" else
					"1111111";
					
		HEX2 <=  "1000000" when scorecnt_B_1 = "0000" else				--decoder for 第3個七段顯示
					"1111001" when scorecnt_B_1 = "0001" else
					"0100100" when scorecnt_B_1 = "0010" else
					"0110000" when scorecnt_B_1 = "0011" else
					"0011001" when scorecnt_B_1 = "0100" else
					"0010010" when scorecnt_B_1 = "0101" else
					"0000010" when scorecnt_B_1 = "0110" else
					"1111000" when scorecnt_B_1 = "0111" else
					"0000000" when scorecnt_B_1 = "1000" else
					"0010000" when scorecnt_B_1 = "1001" else
					"1111111";
					
		HEX3 <=  "1000000" when scorecnt_B_2 = "0000" else				--decoder for 第4個七段顯示
					"1111001" when scorecnt_B_2 = "0001" else
					"0100100" when scorecnt_B_2 = "0010" else
					"0110000" when scorecnt_B_2 = "0011" else
					"0011001" when scorecnt_B_2 = "0100" else
					"0010010" when scorecnt_B_2 = "0101" else
					"0000010" when scorecnt_B_2 = "0110" else
					"1111000" when scorecnt_B_2 = "0111" else
					"0000000" when scorecnt_B_2 = "1000" else
					"0010000" when scorecnt_B_2 = "1001" else
					"1111111";

end pingpong;