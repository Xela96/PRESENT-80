library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity key_schedule_tb is
end key_schedule_tb;

architecture Behavioral of key_schedule_tb is

    component key_schedule
    Port(
        keyIn: in STD_LOGIC_VECTOR(79 downto 0);
        keyOut: out STD_LOGIC_VECTOR(79 downto 0);
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
        rndCnt <= "00000"; --0
        wait for 10ns;
        
        inKey <= x"00000000000000000000";
        rndCnt <= "00001"; --1
        wait for 10ns;
        
--        inKey <= x"5000180000000001";
--        rndCnt <= "00010"; --2
--        wait for 10ns;
        
--        inKey <= x"60000a0003000001";
--        rndCnt <= "00011"; --3
--        wait for 10ns;
        
--        inKey <= x"b0000c0001400062";
--        rndCnt <= "00100"; --4
--        wait for 10ns;
        
--        inKey <= x"900016000180002a";
--        rndCnt <= "00101"; --5
--        wait for 10ns;
        
--        inKey <= x"0001920002c00033";
--        rndCnt <= "00110"; --6
--        wait for 10ns;
        
--        inKey <= x"a000a0003240005b";
--        rndCnt <= "00111"; --7
--        wait for 10ns;
        
--        inKey <= x"d000d4001400064c";
--        rndCnt <= "01000"; --8
--        wait for 10ns;
        
--        inKey <= x"30017a001a800284";
--        rndCnt <= "01001"; --9
--        wait for 10ns;
        
--        inKey <= x"e01926002f400355";
--        rndCnt <= "01010"; --10
--        wait for 10ns;
        
--        inKey <= x"f00a1c0324c005ed";
--        rndCnt <= "01011"; --11
--        wait for 10ns;
        
--        inKey <= x"800d5e014380649e";
--        rndCnt <= "01100"; --12
--        wait for 10ns;
        
--        inKey <= x"4017b001abc02876";
--        rndCnt <= "01101"; --13
--        wait for 10ns;
        
--        inKey <= x"71926802f600357f";
--        rndCnt <= "01110"; --14
--        wait for 10ns;
        
--        inKey <= x"10a1ce324d005ec7";
--        rndCnt <= "01111"; --15
--        wait for 10ns;
        
--        inKey <= x"20d5e21439c649a8";
--        rndCnt <= "10000"; --16
--        wait for 10ns;
        
--        inKey <= x"c17b041abc428730";
--        rndCnt <= "10001"; --17
--        wait for 10ns;
        
--        inKey <= x"c926b82f60835781";
--        rndCnt <= "10010"; --18
--        wait for 10ns;
        
--        inKey <= x"6a1cd924d705ec19";
--        rndCnt <= "10011"; --19
--        wait for 10ns;
        
--        inKey <= x"bd5e0d439b249aea";
--        rndCnt <= "10100"; --20
--        wait for 10ns;
        
--        inKey <= x"07b077abc1a8736e";
--        rndCnt <= "10101"; --21
--        wait for 10ns;
        
--        inKey <= x"426ba0f60ef5783e";
--        rndCnt <= "10110"; --22
--        wait for 10ns;
        
--        inKey <= x"41cda84d741ec1d5";
--        rndCnt <= "10111"; --23
--        wait for 10ns;
        
--        inKey <= x"f5e0e839b509ae8f";
--        rndCnt <= "11000"; --24
--        wait for 10ns;
        
--        inKey <= x"2b075ebc1d0736ad";
--        rndCnt <= "11001"; --25
--        wait for 10ns;
        
--        inKey <= x"86ba2560ebd783ad";
--        rndCnt <= "11010"; --26
--        wait for 10ns;
        
--        inKey <= x"8cdab0d744ac1d77";
--        rndCnt <= "11011"; --27
--        wait for 10ns;
        
--        inKey <= x"1e0eb19b561ae89b";
--        rndCnt <= "11100"; --28
--        wait for 10ns;
        
--        inKey <= x"d075c3c1d6336acd";
--        rndCnt <= "11101"; --29
--        wait for 10ns;
        
--        inKey <= x"8ba27a0eb8783ac9";
--        rndCnt <= "11110"; --30
--        wait for 10ns;
        
--        inKey <= x"6dab31744f41d700";
--        rndCnt <= "11111"; --31
--        wait for 10ns;

    end process;

end Behavioral;
