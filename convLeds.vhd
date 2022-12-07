library IEEE;
use IEEE.std_logic_1164.all;

-- entity
entity convLeds is
  port (
    num : in integer range 0 to 10;
    HEX: out std_logic_vector (7 downto 0)
  );
end convLeds;

-- architecture
architecture hardware of convLeds is
begin
  proc:process(num)
    begin
      case num is
        when 0 => HEX <= "11000000"; -- 0 
        when 1 => HEX <= "11111001"; -- 1
        when 2 => HEX <= "10100100"; -- 2
        when 3 => HEX <= "10110000"; -- 3
        when 4 => HEX <= "10011001"; -- 4
        when 5 => HEX <= "10010010"; -- 5
        when 6 => HEX <= "10000010"; -- 6
        when 7 => HEX <= "11111000"; -- 7
        when 8 => HEX <= "10000000"; -- 8
        when 9 => HEX <= "10010000"; -- 9
        when others => HEX <= "11111111"; --DELIGADO
      end case;
    end process proc;
end hardware;