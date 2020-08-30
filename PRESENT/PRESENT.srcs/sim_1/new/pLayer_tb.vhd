library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pLayer_tb is
end pLayer_tb;

architecture Behavioral of pLayer_tb is

    component pLayer
    Port(
        textIn : in STD_LOGIC_VECTOR (63 downto 0);
        textOut: out STD_LOGIC_VECTOR (63 downto 0)
        );
    end component;
    
    signal inText : STD_LOGIC_VECTOR(63 downto 0);
    signal outText : STD_LOGIC_VECTOR(63 downto 0);
    
begin

PL: pLayer
        Port map (
                  textIn => inText,
                  textOut => outText
                  );
                  
    sbox_proc: process
    begin
        inText <= x"b2222222cccccccc";
        wait for 10ns;
    end process;                   


end Behavioral;
