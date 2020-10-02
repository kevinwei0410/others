library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

	port(
	      clk:in std_logic;
			reset:in std_logic;
			over:out std_logic;
			HEX0,HEX1,HEX2,HEX3:out std_logic_vector(6 downto 0)
			);
end BCD_up_cnt_4digits;
architecture BCD_up_cnt_4digits of BCD_up_cnt_4digits is


		component clk_100HZ is
			port(
					clk:in std_logic;
					clk100:out std_logic
					);
		end component;

		component SEG7_Decoder is
			port(
					I:in std_logic_vector(3 downto 0);
					SEG7:out std_logic_vector(6 downto 0)
					);
		end component;


		component Cascade_BCD_upcnt is
			port(
					clk:in std_logic;
					reset:in std_logic;
					casin:in std_logic;
					casout:out std_logic;
					BCD:out std_logic_vector(3 downto 0)
					);
		end component;


signal bcd0,bcd1,bcd2,bcd3:std_logic_vector(3 downto 0);
signal s0,s1,s2,clk100:std_logic;
begin

U1: clk_100HZ port map (clk,clk100);
U2: Cascade_BCD_upcnt port map(clk100,reset,'1',s0,bcd0);		
U3: Cascade_BCD_upcnt port map(clk100,reset,s0,s1,bcd1);	
U4: Cascade_BCD_upcnt port map(clk100,reset,s1,s2,bcd2);	
U5: Cascade_BCD_upcnt port map(clk100,reset,s2,over,bcd3);	
u6: SEG7_Decoder port map(bcd0,HEX0);		
u7: SEG7_Decoder port map(bcd1,HEX1);	
u8: SEG7_Decoder port map(bcd2,HEX2);	
u9: SEG7_Decoder port map(bcd3,HEX3);			
		
		
end BCD_up_cnt_4digits;	