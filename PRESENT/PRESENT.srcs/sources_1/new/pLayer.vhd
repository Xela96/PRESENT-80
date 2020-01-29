library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pLayer is
  Port ( textIn : in STD_LOGIC_VECTOR (63 downto 0);
         textOut: out STD_LOGIC_VECTOR (63 downto 0)
         );
end pLayer;

architecture Behavioral of pLayer is

signal inText : STD_LOGIC_VECTOR (63 downto 0);

begin

    process(inText)
    begin
--        for i in 0 to 63 loop
--            inText( (i mod 4)*16+(i/4) ) <= inText(i);
--        end loop;  

    inText(0)<=intext(0);
    inText(1)<=intext(16);      
    inText(2)<=intext(32);      
    inText(3)<=intext(48);      
    inText(4)<=intext(1);      
    inText(5)<=intext(17);      
    inText(6)<=intext(33);      
    inText(7)<=intext(49);      
    inText(8)<=intext(2);      
    inText(9)<=intext(18);      
    inText(10)<=intext(34);      
    inText(11)<=intext(50);      
    inText(12)<=intext(3);      
    inText(13)<=intext(19);      
    inText(14)<=intext(35);      
    inText(15)<=intext(51);      
    inText(16)<=intext(4);      
    inText(17)<=intext(20);      
    inText(18)<=intext(36);      
    inText(19)<=intext(52);      
    inText(20)<=intext(5);      
    inText(21)<=intext(21);      
    inText(22)<=intext(37);      
    inText(23)<=intext(53);      
    inText(24)<=intext(6);      
    inText(25)<=intext(22);      
    inText(26)<=intext(38);      
    inText(27)<=intext(54);      
    inText(28)<=intext(7);      
    inText(29)<=intext(23);      
    inText(30)<=intext(39);      
    inText(31)<=intext(55);      
    inText(32)<=intext(8);      
    inText(33)<=intext(24);      
    inText(34)<=intext(40);      
    inText(35)<=intext(56);      
    inText(36)<=intext(9);      
    inText(37)<=intext(25);      
    inText(38)<=intext(41);      
    inText(39)<=intext(57);      
    inText(40)<=intext(10);      
    inText(41)<=intext(26);      
    inText(42)<=intext(42);      
    inText(43)<=intext(58);      
    inText(44)<=intext(11);      
    inText(45)<=intext(27);      
    inText(46)<=intext(43);      
    inText(47)<=intext(59);      
    inText(48)<=intext(12);      
    inText(49)<=intext(28);      
    inText(50)<=intext(44);      
    inText(51)<=intext(60);      
    inText(52)<=intext(13);
    inText(53)<=intext(29);      
    inText(54)<=intext(45);      
    inText(55)<=intext(61);      
    inText(56)<=intext(14);      
    inText(57)<=intext(30);      
    inText(58)<=intext(46);      
    inText(59)<=intext(62);      
    inText(60)<=intext(15);      
    inText(61)<=intext(31);      
    inText(62)<=intext(47);      
    inText(63)<=intext(63);        
     
    end process;

end Behavioral;
