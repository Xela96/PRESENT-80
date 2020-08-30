library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sbox_tb is
end sbox_tb;

architecture Behavioral of sbox_tb is

    component sbox
    Port(
        dataIn: in STD_LOGIC_VECTOR(3 downto 0);
        dataOut: out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;
    
    signal inData : STD_LOGIC_VECTOR(3 downto 0);
    signal outData : STD_LOGIC_VECTOR(3 downto 0);

begin

    SB_test: sbox
        Port map (
                  dataIn => inData,
                  dataOut => outData
                  );
                  
    sbox_proc: process
    begin
        inData <= x"0";
        wait for 10ns;
    end process;                  

end Behavioral;
