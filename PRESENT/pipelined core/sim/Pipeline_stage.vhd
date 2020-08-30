LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.constants.ALL; 
use STD.textio.all;                     -- basic I/O
use IEEE.std_logic_textio.all;          -- I/O for logic types

ENTITY Pipeline_stage IS
	PORT (
		textIn : IN STD_LOGIC_VECTOR (messageLength - 1 DOWNTO 0);
		textOut : OUT STD_LOGIC_VECTOR (messageLength - 1 DOWNTO 0);
		keyIn : IN STD_LOGIC_VECTOR (keyLength - 1 DOWNTO 0);
		keyOut : OUT STD_LOGIC_VECTOR (keyLength - 1 DOWNTO 0);
		roundCounter : IN STD_LOGIC_VECTOR (4 DOWNTO 0); 
		clock : IN STD_LOGIC;
		reset : IN STD_LOGIC 
	);
END Pipeline_stage;

ARCHITECTURE Behavioral OF Pipeline_stage IS

	-- Define components
	COMPONENT key_schedule
		PORT (
			keyIn : IN STD_LOGIC_VECTOR(keyLength - 1 DOWNTO 0);
			keyOut : OUT STD_LOGIC_VECTOR(keyLength - 1 DOWNTO 0);
			round_counter : IN STD_LOGIC_VECTOR(4 DOWNTO 0)
		);
	END COMPONENT;
 
	COMPONENT sBoxlayer
		PORT (
			textIn : IN STD_LOGIC_VECTOR (messageLength - 1 DOWNTO 0);
			textOut : OUT STD_LOGIC_VECTOR (messageLength - 1 DOWNTO 0)
		);
	END COMPONENT;
 
	COMPONENT pLayer
		PORT (
			textIn : IN STD_LOGIC_VECTOR (messageLength - 1 DOWNTO 0);
			textOut : OUT STD_LOGIC_VECTOR (messageLength - 1 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL key_s : STD_LOGIC_VECTOR(keyLength - 1 DOWNTO 0);
	SIGNAL round_counter : STD_LOGIC_VECTOR(4 DOWNTO 0);
 
	-- Updated signals
	--SIGNAL next_key : STD_LOGIC_VECTOR(keyLength - 1 DOWNTO 0);
	SIGNAL next_sbox_state : STD_LOGIC_VECTOR(messageLength - 1 DOWNTO 0);
	SIGNAL next_pLayer_state : STD_LOGIC_VECTOR(messageLength - 1 DOWNTO 0); 
	SIGNAL text_rKey_added : STD_LOGIC_VECTOR(messageLength - 1 DOWNTO 0);
	SIGNAL inText : STD_LOGIC_VECTOR(messageLength - 1 DOWNTO 0);

BEGIN
	KS : key_schedule
	PORT MAP(
		keyIn => keyIn,
		keyOut => keyOut,
		round_counter => round_counter
	);
 
	SBL : sBoxlayer
	PORT MAP(
		textIn => text_rKey_added, 
		textOut => next_sbox_state
	); 

	PL : pLayer
	PORT MAP(
		textIn => next_sbox_state,
		textOut => next_pLayer_state
	);

	text_rKey_added <= inText XOR key_s(79 DOWNTO 16);
 
 
	RoundEncryption: PROCESS (clock)
	BEGIN
		--IF rising_edge(clock) THEN
			IF reset = '1' THEN
			    round_counter <= roundCounter;
                inText <= textIn;	    
				textOut <= (OTHERS => '0');
				key_s <= keyIn;
			ELSE
			    inText <= textIn;
			    key_s <= keyIn;
				textOut <= next_pLayer_state;
			END IF;
		--END IF;
	END PROCESS;
END Behavioral;