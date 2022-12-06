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
        when 0 => HEX <= "00000011"; -- 0
        when 1 => HEX <= "10011111"; -- 1
        when 2 => HEX <= "00100101"; -- 2
        when 3 => HEX <= "00001101"; -- 3
        when 4 => HEX <= "10011001"; -- 4
        when 5 => HEX <= "01001001"; -- 5
        when 6 => HEX <= "01000001"; -- 6
        when 7 => HEX <= "00011111"; -- 7
        when 8 => HEX <= "00000001"; -- 8
        when 9 => HEX <= "00001001"; -- 9
        when others => HEX <= "11111111"; --DELIGADO
      end case;
    end process proc;
end hardware;