library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

-- entity
entity calc is
  port (
    reset, clk, enterN, enterS : in std_logic;
    numero : in std_logic_vector(3 downto 0);
    sinal : in std_logic_vector(1 downto 0);
    HEX0, HEX1, HEX2, HEX3, HEX4, HEX5: out std_logic_vector (7 downto 0));
end calc;

-- architecture
architecture hardware of calc is
  component convLeds is
    port (
      num : in std_logic_vector(3 downto 0);
      HEX: out std_logic_vector (7 downto 0));
  end component;

  type pilhaNu is array (natural range <>) of std_logic_vector(3 downto 0);
  type pilhaSi is array (natural range <>) of std_logic_vector(1 downto 0);
  signal PilhaNumero :  pilhaNu (0 to 10);
  signal PilhaSinal :  pilhaSi (0 to 10);
  signal unid, dec, cent, milhar, decMilhar, centMilhar: std_logic_vector(3 downto 0) := "1111"; -- numero para os displays

begin

  --Cria um digito para cada display
  x1 : convLeds port map(num =>unid, HEX =>HEX0);
  x2 : convLeds port map(num =>dec, HEX =>HEX1);
  x3 : convLeds port map(num =>cent, HEX =>HEX2);
  x4 : convLeds port map(num =>milhar, HEX =>HEX3);
  x5 : convLeds port map(num =>decMilhar, HEX =>HEX4);
  x6 : convLeds port map(num =>centMilhar, HEX =>HEX5);

  comb_proc : process (clk, reset)
  variable cntN, cntS : integer range 0 to 10 := 0;
  begin
    if (reset = '1') then
      unid <= "0000";
      dec  <= "1111";
      cent <= "1111";
      milhar <= "1111";
      decMilhar <="1111";
      centMilhar <= "1111";
      
    elsif (RISING_EDGE(clk)) then
      if (enterN = '1') then --verifica se for apertado enter para números 
          PilhaNumero(cntN) <= numero;
      end if;
      if(enterS = '1') then --verifica se for apertado enter para sinal
          PilhaSinal(cntS) <= sinal;
      end if;
    end if;
  end process comb_proc;
end hardware;