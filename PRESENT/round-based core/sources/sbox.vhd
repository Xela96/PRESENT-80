library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sbox is
    Port ( dataIn : in STD_LOGIC_VECTOR (3 downto 0);
           dataOut : out STD_LOGIC_VECTOR (3 downto 0));
end sbox;

architecture Behavioral of sbox is

begin
    process(dataIn)
    begin
        case dataIn is
    
            when x"0" => dataOut <= x"C";
            when x"1" => dataOut <= x"5";
            when x"2" => dataOut <= x"6";
            when x"3" => dataOut <= x"B";
            when x"4" => dataOut <= x"9";
            when x"5" => dataOut <= x"0";
            when x"6" => dataOut <= x"A";
            when x"7" => dataOut <= x"D";
            when x"8" => dataOut <= x"3";
            when x"9" => dataOut <= x"E";
            when x"A" => dataOut <= x"F";
            when x"B" => dataOut <= x"8";
            when x"C" => dataOut <= x"4";
            when x"D" => dataOut <= x"7";
            when x"E" => dataOut <= x"1";
            when x"F" => dataOut <= x"2";
            when others => dataOut <= x"0";
        end case;
    end process;
    
end Behavioral;
