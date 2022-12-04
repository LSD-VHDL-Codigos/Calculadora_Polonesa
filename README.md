# Calculadora_Polonesa
Enunciado do Trabalho 3 da Guia 13 de LSD:

Escrever em VHDL um código sintetizável (DUT) do Projeto RTL de uma calculadora de 4 operações diferentes quaisquer dentre (+, -, <<, >>, *, /, rem), que funcione na notação polonesa inversa (https://pt.wikipedia.org/wiki/Nota%C3%A7%C3%A3o_polonesa_inversa). Sua calculadora deverá ter como entradas: 1 chave (switch) como entrada de RESET síncrona; 1 sinal de clock; 4 chaves (switches) para entrada do valor do operando; 1 chave (switch) como validação da entrada do operando; 2 chaves (switches) para entrada de seleção do operador; 1 chave (switch) como validação da entrada do operador. Os resultados das operações realizadas pela calculadora (saída) deverão ser apresentados em 4 displays de 7 segmentos do kit DE10-Lite. Escreva um testbench em VHDL para testar a funcionalidade do seu código sintetizável (seu DUT). Por fim, crie um projeto dentro do Quartus II e sintetize o DUT que você testou com o GHDL. Use como recursos do kit para definir como entradas os switcjes da placa e um dos sinais de clock disponíveis, e como saídas use os 4 displays de 7 segmentos do kit. Faça o arquivo de associação de pinos do FPGA com as entradas e saídas da entidade do seu DUT (pin assignments). Gere o código binário (compile) de dentro do Quartus II para ser gravado no FPGA do kit DE10-Lite. Grave o FPGA com o seu DUT, teste o funcionamento do mesmo e apresente tudo ao professor no dia da aula marcada para a apresentação do trabalho 3.

 

Os grupos de alunos que fizeram o decodificador BCH no trabalho1 da disciplina deverão fazer a calculadora Hexadecimal.

 

Os grupos de alunos que fizeram o decodificador BCD no trabalho1 da disciplina deverão fazer a calculadora Decimal.
