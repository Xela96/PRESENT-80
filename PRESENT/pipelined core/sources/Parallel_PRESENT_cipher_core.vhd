library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 
USE work.constants.ALL;

entity Parallel_PRESENT_cipher_core is
  Port ( textIn : in STD_LOGIC_VECTOR (messageLength-1 downto 0);
           textOut : out STD_LOGIC_VECTOR (messageLength-1 downto 0);
           key : in STD_LOGIC_VECTOR (keyLength-1 downto 0);
           clock : in STD_LOGIC;
           reset : in STD_LOGIC);
end Parallel_PRESENT_cipher_core;

architecture Behavioral of Parallel_PRESENT_cipher_core is

	COMPONENT Pipeline_stage
	PORT (
		textIn : IN STD_LOGIC_VECTOR (messageLength - 1 DOWNTO 0);
		textOut : OUT STD_LOGIC_VECTOR (messageLength - 1 DOWNTO 0);
		keyIn : IN STD_LOGIC_VECTOR (keyLength - 1 DOWNTO 0);
		keyOut : OUT STD_LOGIC_VECTOR (keyLength - 1 DOWNTO 0);
		roundCounter : IN STD_LOGIC_VECTOR (4 DOWNTO 0); 
		clock : IN STD_LOGIC;
		reset : IN STD_LOGIC 
	);
	END COMPONENT;
	
	--signals
	signal state_s : textArray;
    signal key_s : keyArray;

begin

state_s(0) <= textIn;
key_s(0) <= key;

pipe: for i in 0 to 30 generate
	pipe_stage : Pipeline_stage
	PORT MAP(
		textIn => state_s(i),
		textOut => state_s(i+1), 
		keyIn => key_s(i),
		keyOut => key_s(i+1),
		roundCounter => std_logic_vector(to_unsigned(i+1,5)), 
		clock => clock,
		reset => reset
	);
end generate pipe;

textOut <= state_s(31) XOR key_s(31)(79 downto 16);

end Behavioral;
