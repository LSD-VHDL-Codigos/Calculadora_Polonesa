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
        HEX0, HEX1, HEX2, HEX3, HEX4, HEX5: out std_logic_vector (7 downto 0));
    end calc;

    -- architecture
    architecture hardware of calc is
    component convLeds is
        port (
        num : in integer range 0 to 10;
        HEX: out std_logic_vector (7 downto 0));
    end component;

    type pilhaNu is array (natural range <>) of integer range -999 to 999;
    type state_type is (US, UN, DN, DS); -- Us- UP sinal, UN- UP Numero ..
    signal PS, PN: state_type; --estados  do sinal e numero
    signal PilhaNumero :  pilhaNu (0 to 10);
    signal resultado : integer range -999 to 999; --variavel aux somente para visualização
    signal unid, dec, cent, milhar, decMilhar, centMilhar: integer range 0 to 10 := 10; -- numero para os displays   
begin

    --Cria um digito para cada display
    x1 : convLeds port map(num =>unid, HEX =>HEX0);
    x2 : convLeds port map(num =>dec, HEX =>HEX1);
    x3 : convLeds port map(num =>cent, HEX =>HEX2);
    x4 : convLeds port map(num =>milhar, HEX =>HEX3);
    x5 : convLeds port map(num =>decMilhar, HEX =>HEX4);
    x6 : convLeds port map(num =>centMilhar, HEX =>HEX5);

    sync_proc : process (clk, reset)
        variable cnt: integer range -1 to 10 := -1;
        begin
        if(rising_edge(clk)) then
            if(reset = '1') then
                unid <= 0;
                dec  <= 10;
                cent <= 10;
                milhar <= 10;
                decMilhar <=10;
                centMilhar <= 10;
                cnt := -1;
                PS <= DS;
                PN <= DN;
            elsif(enterN = '1' and PN= DN) then
                cnt := cnt + 1;
                PilhaNumero(cnt) <= to_integer(unsigned(numero)); --converter o número da entrada para decimal
                PN <= UN;
            elsif(enterN = '0' and PN=UN) then
                PN <= DN;
                
            elsif(enterS = '1' and PS=DS)  then
                if(cnt>0) then --realiza o calculo
                    if (sinal = "00") then --verifica se for o sinal de +
                        PilhaNumero(cnt-1) <= (PilhaNumero(cnt-1) + PilhaNumero(cnt));
                    elsif (sinal = "01") then --verifica se for o sinal de -
                        PilhaNumero(cnt-1) <= (PilhaNumero(cnt-1) - PilhaNumero(cnt));
                    end if;
                        cnt := cnt -1;
                end if;

                if (sinal = "10") then --verifica se for o sinal de uma operacao de deslocamento
                    PilhaNumero(cnt) <= (PilhaNumero(cnt)*2);
                elsif (sinal = "11") then --verifica se for o sinal de >> 
                    PilhaNumero(cnt) <= (PilhaNumero(cnt)/2);
                end if;
                PS <= US;
            elsif(enterS = '0' and PS=US) then
                PS <= DS;
        end if;
        end if;
        if(falling_edge(clk) and reset = '0') then --Mapeamento para o display 
            resultado <= PilhaNumero(0);

        end if;
        end process sync_proc;
    end hardware;