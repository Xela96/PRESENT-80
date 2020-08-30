library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package constants is

        constant messageLength : integer := 64;
        constant keyLength : integer := 80;
        constant serialisedMessageLength : integer := 4; 
        constant serialisedKeyLength : integer := 4;       
        
        type bidirectional_vector is array (integer range <>, integer range <>) of std_logic_vector(63 downto 0);
        type textArray is array (31 downto 0) of std_logic_vector(63 downto 0);
        type keyArray is array (31 downto 0) of std_logic_vector(79 downto 0);
        
        constant method: integer := 0;
        
end package constants;

package body constants is

end package body constants;