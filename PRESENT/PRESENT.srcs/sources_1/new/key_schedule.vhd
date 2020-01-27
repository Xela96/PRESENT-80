library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity key_schedule is
    Port ( keyIn : in STD_LOGIC_VECTOR(127 downto 0);
           keyOut : out STD_LOGIC_VECTOR(127 downto 0);
           round_counter : in STD_LOGIC_VECTOR(4 downto 0)); --5 bits so that 31 rounds can be counted
end key_schedule;

architecture Behavioral of key_schedule is

signal rotated_key : STD_LOGIC_VECTOR(79 downto 0);

component sbox
        Port( 
           dataIn : in STD_LOGIC_VECTOR(3 downto 0);
           dataOut : out STD_LOGIC_VECTOR(3 downto 0) 
           );
    end component;

begin

process(keyIn)
    begin
    rotated_key <= keyIn(18 downto 0) & keyIn(79 downto 19);
     
    keyOut(19 downto 15) <= rotated_key(19 downto 15) XOR round_counter;
    keyOut(75 downto 20) <= rotated_key(75 downto 20);
    keyOut(14 downto 0) <= rotated_key(14 downto 0);
    end process;
    
     SB: sbox
     Port map (
               dataIn => rotated_key(79 downto 76),
               dataOut => keyOut(79 downto 76)
               );

end Behavioral;
