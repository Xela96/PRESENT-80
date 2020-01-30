library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sBoxlayer is
  Port ( textIn : in STD_LOGIC_VECTOR (63 downto 0);
         textOut: out STD_LOGIC_VECTOR (63 downto 0)
        );
  end sBoxlayer;

architecture Behavioral of sBoxlayer is

    component sbox
    Port(
        dataIn: in STD_LOGIC_VECTOR(3 downto 0);
        dataOut: out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

begin
        Gen_SBox:
        for i in 0 to 15 generate --generate instantiates arrays of components
            SBL: sbox
                Port map (
                          dataIn => textIn(4*i+3 downto 4*i),
                          dataOut => textOut(4*i+3 downto 4*i)
                          );
        end generate Gen_SBox;
end Behavioral;
