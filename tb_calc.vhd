-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;

-- top-level entity
entity tb_calc is end entity;

-- architecture
architecture hardware of tb_calc is
  -- component declaration

  component calc is
    port (
      reset, clk, enterN, enterS: in std_logic;
      numero : in std_logic_vector(3 downto 0);
      sinal : in std_logic_vector(1 downto 0);
      HEX0, HEX1, HEX2, HEX3: out std_logic_vector (7 downto 0)
    );
  end component;

  constant PERIODO : time := 20 ns;
  signal ENT_CLK : std_logic := '0'; -- deve ser inicializado
  signal ENT_CLK_ENABLE : std_logic := '1'; -- Sinal de Enable do clock só para efeito de controle do fim da simulação
  signal ENT_RESET, ENT_ENTERN, ENT_ENTERS: std_logic;
  signal ENT_NUM : std_logic_vector(3 downto 0);
  signal ENT_SINAL : std_logic_vector(1 downto 0);
  signal ENT_H0, ENT_H1, ENT_H2, ENT_H3: std_logic_vector (7 downto 0);

begin
  -- geração do clock com periodo PERIODO
  ENT_CLK <= ENT_CLK_ENABLE and not ENT_CLK after PERIODO/2;
  ENT_CLK_ENABLE <= '1', '0' after 50*PERIODO; -- a simulação termina após transcorrer 20 períodos de clock.

  -- instanciação do DUT, que nesse exemplo é um ffd
  DUT : calc port map(clk => ENT_CLK, reset => ENT_RESET, numero => ENT_NUM, sinal => ENT_SINAL, enterN => ENT_ENTERN, enterS => ENT_ENTERS,
                       HEX0 => ENT_H0, HEX1 => ENT_H1, HEX2 => ENT_H2, HEX3 => ENT_H3);
  -- a partir daqui declaro os estímulos de entrada, ou a injecao de sinais
  -- um process para o reset
  reset : process
  begin
    ENT_RESET <= '1';
    wait for 2 * PERIODO; -- um reset de duração de 2 períodos de clock
    ENT_RESET <= '0';
    wait;
  end process reset;

  stimulus: process
  begin

    ENT_ENTERN <= '0';
    ENT_ENTERS <= '0';
    ENT_NUM <= "0101";
    wait for 2*PERIODO;
    ENT_ENTERN <= '1';
    wait for 4*PERIODO;
    ENT_ENTERN <= '0';
    wait for 2*PERIODO;
    ENT_NUM <= "0110";
    ENT_ENTERN <= '1';
    wait for 2*PERIODO;
    ENT_ENTERN <= '0';
    ENT_SINAL <= "00"; --ADICAO
    ENT_ENTERS <= '1';
    wait for 2*PERIODO;
    ENT_ENTERS <= '0';
    wait for 3*PERIODO;
    ENT_NUM <= "0111";
    ENT_ENTERN <= '1';
    wait for 3*PERIODO;
    ENT_ENTERN <= '0';
    ENT_ENTERS <= '1';
    ENT_SINAL <= "01"; -- SUBTRACAO
    wait for 3*PERIODO;
    ENT_ENTERN <= '0';
    ENT_ENTERS <= '0';
    wait;
  end process stimulus;
end architecture;