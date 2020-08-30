library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.constants.all;

entity PRESENT_tb is
end PRESENT_tb;

architecture Behavioral of PRESENT_tb is

  CONSTANT clk_period : time := 2.85ns; 

    component Parallel_PRESENT_cipher_core
    Port ( textIn : in STD_LOGIC_VECTOR (messageLength-1 downto 0);
           textOut : out STD_LOGIC_VECTOR (messageLength-1 downto 0);
           key : in STD_LOGIC_VECTOR (keyLength-1 downto 0);
           clock : in STD_LOGIC;
           reset : in STD_LOGIC);
    end component;
    
    component stimgen
    generic (clock_period : time := clk_period);
    Port ( plaintext : out STD_LOGIC_VECTOR(messageLength-1 downto 0);
           ciphertext : in STD_LOGIC_VECTOR(messageLength-1 downto 0);
           key : out STD_LOGIC_VECTOR(keyLength-1 downto 0);
           clock : inout STD_LOGIC;
           reset : inout STD_LOGIC
           );
    end component;

    signal inText : STD_LOGIC_VECTOR(messageLength-1 downto 0);
    signal outText : STD_LOGIC_VECTOR(messageLength-1 downto 0);
    signal key_s : STD_LOGIC_VECTOR(keyLength-1 downto 0);
    signal clk : STD_LOGIC := '0';
    signal rst : STD_LOGIC := '1';

    
begin

    pres: Parallel_PRESENT_cipher_core
        Port map (
                  textIn => inText,
                  textOut => outText,
                  key => key_s,
                  clock => clk,
                  reset => rst
                  );
    
    stimulus_generator: stimgen
                    Port map (
                              plaintext => inText,
                              ciphertext => outText,
                              key => key_s,
                              clock => clk,
                              reset => rst
                              );     

end Behavioral;
