library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity BCD_up_down_cnt_4digits is
	port(
	      clk:in std_logic;
			reset:in std_logic;
			over:out std_logic;
			HEX0,HEX1,HEX2,HEX3:out std_logic_vector(6 downto 0);
			UP_DOWN : in std_logic);
end BCD_up_down_cnt_4digits;

architecture BCD_up_down_cnt_4digits of BCD_up_down_cnt_4digits is

	component Cascade_BCD_up_down_cnt is	--上下數BCD計數器
	port(
	      clk:in std_logic;
			reset:in std_logic;
         casin:in std_logic;
			casout:out std_logic;
			BCD:out std_logic_vector(3 downto 0);
			UP_DOWN : in std_logic);
	end component;
	
	component clk_100HZ is						--除頻器
	port(
	      clk:in std_logic;
			clk100:out std_logic
			);
	end component;
	
	component SEG7_Decoder is					--DECODER用在輸出到7段顯示
	port(
	      I:in std_logic_vector(3 downto 0);
	      SEG7:out std_logic_vector(6 downto 0)
			);
	end component;

signal bcd0,bcd1,bcd2,bcd3:std_logic_vector(3 downto 0);	--BCD連接到解碼器
signal s0,s1,s2,clk100:std_logic;	--BCD counter 接到 下一個 BCD counter 

begin

U1: clk_100HZ port map (clk,clk100);	
U2: Cascade_BCD_up_down_cnt port map(clk100,reset,'1',s0,bcd0, UP_DOWN);		--clk100連接不改，reset 連接不改， casin = '1', casout = s0, UP_DOWN 連接不改
U3: Cascade_BCD_up_down_cnt port map(clk100,reset,s0,s1,bcd1, UP_DOWN);			--clk100連接不改，reset 連接不改， casin = s0, casout = s1, UP_DOWN 連接不改
U4: Cascade_BCD_up_down_cnt port map(clk100,reset,s1,s2,bcd2, UP_DOWN);			--clk100連接不改，reset 連接不改， casin = s1, casout = s2, UP_DOWN 連接不改
U5: Cascade_BCD_up_down_cnt port map(clk100,reset,s2,over,bcd3, UP_DOWN);		--clk100連接不改，reset 連接不改， casin = s2, casout = over, UP_DOWN 連接不改	
u6: SEG7_Decoder port map(bcd0,HEX0);					-- decode BCD結果到第一個七段顯示
u7: SEG7_Decoder port map(bcd1,HEX1);					-- decode BCD結果到第二個七段顯示
u8: SEG7_Decoder port map(bcd2,HEX2);					-- decode BCD結果到第三個七段顯示
u9: SEG7_Decoder port map(bcd3,HEX3);					-- decode BCD結果到第四個七段顯示

end BCD_up_down_cnt_4digits;