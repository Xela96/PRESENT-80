library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.constants.all;

entity stimgen is
    generic (clock_period : time);
  Port ( plaintext : out STD_LOGIC_VECTOR(messageLength-1 downto 0);
         ciphertext : in STD_LOGIC_VECTOR(messageLength-1 downto 0);
         key : out STD_LOGIC_VECTOR(keyLength-1 downto 0);
         clock : inout STD_LOGIC;
         reset : inout STD_LOGIC :='0'
         );
end stimgen;

architecture Behavioral of stimgen is

  signal DONE : boolean := false;
  signal FAILED: boolean := false;

begin

   -- Clock generator
   Clock1: process
       variable clktmp : std_logic := '1';
   begin       
       while DONE /= true and FAILED /= true loop
           wait for CLOCK_PERIOD/2;
           clktmp := not clktmp;
           Clock <= clktmp;
       end loop;        
       wait;        
   end process;
   
    -- Apply stimulus signals and check result 
    CheckResult: process
    begin
    
        wait for 20ns;
        reset <= '1';        
        plaintext <= x"0000000000000000";
        key <= x"00000000000000000000";
        --reset <= '0';
        wait for CLOCK_PERIOD;
        reset <= '0';
        wait for 600ns;
            
        wait for 20ns;
        wait for 20ns;
        if ciphertext = x"5579C1387B228445" then
            report "Test vector 1 passed";
        else
            report "Test vector 1 failed";
        end if;
        
        reset <= '1';
        plaintext <= x"0000000000000000";
        key <= x"FFFFFFFFFFFFFFFFFFFF";
        wait for CLOCK_PERIOD;
        reset <= '0';
        wait for 600ns;
        
        wait for 20ns;
        wait for 20ns;
        if ciphertext = x"E72C46C0F5945049" then
            report "Test vector 2 passed";
        else
            report "Test vector 2 failed";
        end if;
        
        reset <= '1';
        plaintext <= x"FFFFFFFFFFFFFFFF";
        key <= x"00000000000000000000";
        wait for CLOCK_PERIOD;
        reset <= '0';
        wait for 600ns;
        
        wait for 20ns;
        wait for 20ns;
        if ciphertext = x"A112FFC72F68417B" then
            report "Test vector 3 passed";
        else
            report "Test vector 3 failed";
        end if;
        
        reset <= '1';
        plaintext <= x"FFFFFFFFFFFFFFFF";
        key <= x"FFFFFFFFFFFFFFFFFFFF";
        wait for CLOCK_PERIOD;
        reset <= '0';
        wait for 600ns;
        
        wait for 20ns;
        wait for 20ns;
        if ciphertext = x"3333DCD3213210D2" then
            report "Test vector 4 passed";
        else
            report "Test vector 4 failed";
        end if;
        
        DONE <= true;        
        
    
    end process;


end Behavioral;
