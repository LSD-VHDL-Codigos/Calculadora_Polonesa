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
        when 0 => HEX <= "10000000"; -- 0
        when 1 => HEX <= "11110011"; -- 1
        when 2 => HEX <= "01001001"; -- 2
        when 3 => HEX <= "01100001"; -- 3
        when 4 => HEX <= "00110011"; -- 4
        when 5 => HEX <= "00100101"; -- 5
        when 6 => HEX <= "00000011"; -- 6
        when 7 => HEX <= "11110001"; -- 7
        when 8 => HEX <= "00000001"; -- 8
        when 9 => HEX <= "00100001"; -- 9
        when others => HEX <= "11111111"; --DELIGADO
      end case;
    end process proc;
end hardware;