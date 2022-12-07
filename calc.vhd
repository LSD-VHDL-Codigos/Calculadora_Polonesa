library IEEE;
use IEEE.std_logic_1164.all;
use std.standard.all;
use ieee.numeric_std.all;

-- entity
entity calc is
  port (
    reset, clk, enterN, enterS : in std_logic;
    numero : in std_logic_vector(3 downto 0);
    sinal : in std_logic_vector(1 downto 0);
    HEX0, HEX1, HEX2, HEX3 : out std_logic_vector (7 downto 0));
end calc;

-- architecture
architecture hardware of calc is
  component convLeds is
    port (
      num : in integer range 0 to 10;
      HEX : out std_logic_vector (7 downto 0));
  end component;

  type pilhaNu is array (natural range <>) of integer range -999 to 999;
  type state_type is (US, UN, DN, DS); -- Us- UP sinal, UN- UP Numero ..
  signal PS, PN : state_type; --estados atuais do sinal e numero
  signal PilhaNumero : pilhaNu (0 to 10);
  signal unid, dec, cent, init : integer range 0 to 10 := 10; -- numero para os displays   
begin

  --Cria um digito para cada display
  x1 : convLeds port map(num => unid, HEX => HEX0);
  x2 : convLeds port map(num => dec, HEX => HEX1);
  x3 : convLeds port map(num => cent, HEX => HEX2);

  sync_proc : process (clk, reset)
    variable cnt : integer range -1 to 10 := - 1;
  begin
    if (rising_edge(clk)) then
      if (reset = '1' or init = 10) then
        init <= 0;
        unid <= 0;
        dec <= 10;
        cent <= 10;
        cnt := -1;
        if(enterN = '0') then
          PN <= DN;
        else
          PN <= UN;
        end if;
        if(enterS = '0') then
          PS <= DS;
        else
           PS <= US; 
        end if;

        PilhaNumero(0) <= 0;
        HEX3 <= "11111111"; -- DESLIGA O HEX3

      elsif (enterN = '1' and PN = DN) then
        cnt := cnt + 1;
        PilhaNumero(cnt) <= to_integer(unsigned(numero)); --converter o número da entrada para decimal
        init <= 1;
        PN <= UN;
      elsif (enterN = '0' and PN = UN) then
        PN <= DN;

      elsif (enterS = '1' and PS = DS) then
        if (cnt > 0) then --realiza o calculo
          if (sinal = "00") then --verifica se for o sinal de +
            PilhaNumero(cnt - 1) <= (PilhaNumero(cnt - 1) + PilhaNumero(cnt));
            init <= 1;
          elsif (sinal = "01") then --verifica se for o sinal de -
            PilhaNumero(cnt - 1) <= (PilhaNumero(cnt - 1) - PilhaNumero(cnt));
            init <=1;
          end if;
          cnt := cnt - 1;
        end if;

        if (sinal = "10") then --verifica se for o sinal de uma operacao de deslocamento
          PilhaNumero(cnt) <= (PilhaNumero(cnt) * 2);
          init <= 1;
        elsif (sinal = "11") then --verifica se for o sinal de >> (deslocamento para direita)
          PilhaNumero(cnt) <= (PilhaNumero(cnt)/2);
          init <=1;
        end if;
        PS <= US;
      elsif (enterS = '0' and PS = US) then
        PS <= DS; -- Down state
      end if;

      if(init = 1) then
        init <= 0;
        if(PilhaNumero(cnt)<0) then --instancia display negativos

          if(PilhaNumero(cnt)<-99) then
            cent <= PilhaNumero(cnt)/(-100);
            dec <= (PilhaNumero(cnt)*(-1)-(PilhaNumero(cnt)/(-100))*100)/10;
            unid <= PilhaNumero(cnt)*(-1) mod 10;
          elsif (PilhaNumero(cnt)< -9) then
            cent <= 10; --deliga o HEX2
            dec <= PilhaNumero(cnt)/(-10);
          else
            cent <= 10; --deliga o HEX2
            dec <= 10; --deliga o HEX1
          end if;

          HEX3 <= "10111111"; --coloca o sinal -
          unid <= PilhaNumero(cnt)*(-1) mod 10;

        else --instância display positivo

          if(PilhaNumero(cnt)>99) then
            cent <= PilhaNumero(cnt)/100;
            dec <= (PilhaNumero(cnt)-(PilhaNumero(cnt)/100)*100)/10;
          elsif(PilhaNumero(cnt)>9) then
            cent <= 10; --deliga o HEX2
            dec <= PilhaNumero(cnt)/10;
          else
            cent <= 10; --deliga o HEX2
            dec <= 10; --deliga o HEX1
          end if;

          unid <= PilhaNumero(cnt) mod 10;
          HEX3 <= "11111111";
        end if;

      end if;
    end if;  
  end process sync_proc;

end hardware;