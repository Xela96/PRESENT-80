library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use work.constants.all;
 
entity pLayer is
  Port ( textIn : in STD_LOGIC_VECTOR (messageLength-1 downto 0);
         textOut: out STD_LOGIC_VECTOR (messageLength-1 downto 0)
         );
end pLayer;

architecture Behavioral of pLayer is

signal inText : STD_LOGIC_VECTOR (messageLength-1 downto 0);
signal outText : STD_LOGIC_VECTOR (messageLength-1 downto 0);


begin
inText <= textIn;

    process(inText)
    begin    

    outText(0)<=intext(0);
    outText(16)<=intext(1);      
    outText(32)<=intext(2);      
    outText(48)<=intext(3);
    outText(1)<=intext(4);      
    outText(17)<=intext(5);      
    outText(33)<=intext(6);  
    outText(49)<=intext(7);      
    outText(2)<=intext(8);      
    outText(18)<=intext(9);      
    outText(34)<=intext(10);      
    outText(50)<=intext(11);      
    outText(3)<=intext(12);     
    outText(19)<=intext(13);      
    outText(35)<=intext(14);      
    outText(51)<=intext(15);      
    outText(4)<=intext(16);      
    outText(20)<=intext(17);      
    outText(36)<=intext(18);      
    outText(52)<=intext(19);      
    outText(5)<=intext(20);     
    outText(21)<=intext(21);      
    outText(37)<=intext(22);      
    outText(53)<=intext(23);      
    outText(6)<=intext(24);
    outText(22)<=intext(25);      
    outText(38)<=intext(26);      
    outText(54)<=intext(27);      
    outText(7)<=intext(28);
    outText(23)<=intext(29);      
    outText(39)<=intext(30);
    outText(55)<=intext(31);      
    outText(8)<=intext(32);
    outText(24)<=intext(33);
    outText(40)<=intext(34);      
    outText(56)<=intext(35);      
    outText(9)<=intext(36);      
    outText(25)<=intext(37);      
    outText(41)<=intext(38);      
    outText(57)<=intext(39);      
    outText(10)<=intext(40);      
    outText(26)<=intext(41);      
    outText(42)<=intext(42);      
    outText(58)<=intext(43);      
    outText(11)<=intext(44);      
    outText(27)<=intext(45);      
    outText(43)<=intext(46);      
    outText(59)<=intext(47);      
    outText(12)<=intext(48);      
    outText(28)<=intext(49);      
    outText(44)<=intext(50);      
    outText(60)<=intext(51);      
    outText(13)<=intext(52);
    outText(29)<=intext(53);      
    outText(45)<=intext(54);      
    outText(61)<=intext(55);      
    outText(14)<=intext(56);      
    outText(30)<=intext(57);      
    outText(46)<=intext(58);      
    outText(62)<=intext(59);      
    outText(15)<=intext(60);      
    outText(31)<=intext(61);      
    outText(47)<=intext(62);      
    outText(63)<=intext(63);        
     
    end process;
    
    textOut <= outText;

end Behavioral;
