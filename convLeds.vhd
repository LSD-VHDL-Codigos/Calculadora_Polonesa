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
        if(num = 0) then HEX <= "11111110"; -- 0
        elsif (num = 1) then HEX <= "11001111"; -- 1
        elsif (num = 2) then HEX <= "11001111"; -- 2
        elsif (num = 3) then HEX <= "10000110"; -- 3
        elsif (num = 4) then HEX <= "11001100"; -- 4
        elsif (num = 5) then HEX <= "10100100"; -- 5
        elsif (num = 6) then HEX <= "10100000"; -- 6
        elsif (num = 7) then HEX <= "10001111"; -- 7
        elsif (num = 8) then HEX <= "10000000"; -- 8
        elsif (num = 9) then HEX <= "10000100"; -- 9
        else HEX <= "11111111"; --DELIGADO 
        end if;
    end process proc;
end hardware;