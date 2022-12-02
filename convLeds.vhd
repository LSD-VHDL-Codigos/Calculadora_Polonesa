library IEEE;
use IEEE.std_logic_1164.all;

-- entity
entity convLeds is
  port (
    num : in std_logic_vector(3 downto 0);
    HEX: out std_logic_vector (7 downto 0)
  );
end convLeds;

-- architecture
architecture hardware of convLeds is
begin
  proc:process(num)
    begin
        if(num = "0000") then HEX <= "11111110"; -- 0
        elsif (num = "0001") then HEX <= "11001111"; -- 1
        elsif (num = "0010") then HEX <= "11001111"; -- 2
        elsif (num = "0011") then HEX <= "10000110"; -- 3
        elsif (num = "0100") then HEX <= "11001100"; -- 4
        elsif (num = "0101") then HEX <= "10100100"; -- 5
        elsif (num = "0110") then HEX <= "10100000"; -- 6
        elsif (num = "0111") then HEX <= "10001111"; -- 7
        elsif (num = "1000") then HEX <= "10000000"; -- 8
        elsif (num = "1001") then HEX <= "10000100"; -- 9
        elsif (num = "1010") then HEX <= "11111110"; -- NEGATIVO
        else HEX <= "11111111"; --DELIGADO 
        end if;
    end process proc;
end hardware;