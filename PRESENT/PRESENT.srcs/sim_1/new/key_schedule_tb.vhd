library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity key_schedule_tb is
end key_schedule_tb;

architecture Behavioral of key_schedule_tb is

    component key_schedule
    Port(
        keyIn: in STD_LOGIC_VECTOR(79 downto 0);
        keyOut: in STD_LOGIC_VECTOR(79 downto 0);
        round_counter: in STD_LOGIC_VECTOR(4 downto 0)
        );
    end component;
        
    signal inKey : STD_LOGIC_VECTOR(79 downto 0);
    signal outKey : STD_LOGIC_VECTOR(79 downto 0);
    signal rndCnt : STD_LOGIC_VECTOR(4 downto 0);

begin

    KS: key_schedule
        Port map (
                  keyIn => inKey,
                  keyOut => outKey,
                  round_counter => rndCnt
                  );
                  
    KS_proc: process
    begin
        inKey <= x"00000000000000000000";
        rndCnt <= x"00000";
        wait for 10ns;
    end process;

end Behavioral;
