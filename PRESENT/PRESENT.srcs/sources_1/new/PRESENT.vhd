library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.constants.all;

entity PRESENT is
    Port ( textIn : in STD_LOGIC_VECTOR (messageLength-1 downto 0);
           textOut : out STD_LOGIC_VECTOR (messageLength-1 downto 0);
           key : in STD_LOGIC_VECTOR (keyLength-1 downto 0);
           clock : in STD_LOGIC;
           reset : in STD_LOGIC
           );
end PRESENT;

architecture Behavioral of PRESENT is

    -- Define components
    component key_schedule
    Port(
        keyIn: in STD_LOGIC_VECTOR(keyLength-1 downto 0);
        keyOut: out STD_LOGIC_VECTOR(keyLength-1 downto 0);
        round_counter: in STD_LOGIC_VECTOR(4 downto 0)
        );
    end component;
    
    component sBoxlayer
    Port(
        textIn : in STD_LOGIC_VECTOR (messageLength-1 downto 0);
        textOut: out STD_LOGIC_VECTOR (messageLength-1 downto 0)
        );
    end component;
    
    component pLayer
    Port(
        textIn : in STD_LOGIC_VECTOR (messageLength-1 downto 0);
        textOut: out STD_LOGIC_VECTOR (messageLength-1 downto 0)
        );
    end component;
    
    -- Incoming signals
    signal key_s : STD_LOGIC_VECTOR(keyLength-1 downto 0);
    signal round_counter : STD_LOGIC_VECTOR(4 downto 0);
    
    -- Updated signals
    signal next_key : STD_LOGIC_VECTOR(keyLength-1 downto 0);
    signal next_sbox_state : STD_LOGIC_VECTOR(messageLength-1 downto 0);
    signal next_pLayer_state : STD_LOGIC_VECTOR(messageLength-1 downto 0);  
    
    signal inText : STD_LOGIC_VECTOR(messageLength-1 downto 0); 
    
    signal text_rKey_added : STD_LOGIC_VECTOR(messageLength-1 downto 0); 

begin

KS: key_schedule
        Port map (
                  keyIn => key_s,
                  keyOut => next_key,
                  round_counter => round_counter
                  );
                  
SBL: sBoxlayer
        Port map (
                  textIn => text_rKey_added,
                  textOut => next_sbox_state
                  );                  

PL: pLayer
        Port map (
                  textIn => next_sbox_state,
                  textOut => next_pLayer_state
                  );          
            
            
    text_rKey_added <= inText XOR key_s(79 downto 16); --inText value is incorrect so fix that      
                      
    process( clock)
    begin
        
        
        if rising_edge(clock) then
            if reset='1' then
                round_counter <= "00001";
                inText <= textIn;
                key_s <= key;
                textOut <= (others => '0');
            else
                inText <= next_pLayer_state;
                key_s <= next_key;
                round_counter <= std_logic_vector(unsigned(round_counter)+1);
--                if round_counter /="00000" then
----                    textOut <= (others => '0');
----                else
--                    textOut <= text_rKey_added;
--                end if;
                
                
                 case round_counter is
                    when "00000" => textOut <= text_rKey_added;
                    when others => textOut <= (others => '0');
                end case;
            end if; 
                        
        end if;
    end process;

end Behavioral;
