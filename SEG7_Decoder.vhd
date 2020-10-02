library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity SEG7_Decoder is
	port(
	      I:in std_logic_vector(3 downto 0);
	      SEG7:out std_logic_vector(6 downto 0)
			);
end SEG7_Decoder;
architecture SEG7_Decoder of SEG7_Decoder is
begin
		
		SEG7 <=  "1000000" when I = "0000" else
					"1111001" when I = "0001" else
					"0100100" when I = "0010" else
					"0110000" when I = "0011" else
					"0011001" when I = "0100" else
					"0010010" when I = "0101" else
					"0000010" when I = "0110" else
					"1111000" when I = "0111" else
					"0000000" when I = "1000" else
					"0010000" when I = "1001" else
					"1111111";
		
end SEG7_Decoder;		