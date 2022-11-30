library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

-- entity
entity calc is
  port (reset, clk, enter: in std_logic;
        numero : in  std_logic_vector(3 downto 0);
        sinal  : in  std_logic_vector(1 downto 0);
        HEX0, HEX1, HEX2, HEX3: out std_logic_vector (7 downto 0)
    );
end calc;
    
-- architecture
architecture hardware of calc is
    signal n1, n2, n3, n4, n5: std_logic_vector(3 downto 0) := "0000"; --valores para o calculo
    signal s1, s2, s3, s4, s5: std_logic_vector(1 downto 0) := "00"; --sinais
    signal result: std_logic_vector(7 downto 0) := "00000000";
begin
  sync_proc : process (clk, reset)
  begin
    if (reset = '1') then
        HEX0 <= "01111110"; -- 0
        HEX1 <= "11111111"; -- Desligado
        HEX2 <= "11111111"; -- Desligado
        HEX3 <= "11111111"; -- Desligado
    elsif (RISING_EDGE(clk)) then
        if(enter="1") then --verifica se for apertado enter
            
        end if;

  end if;
  end process sync_proc;
end hardware;