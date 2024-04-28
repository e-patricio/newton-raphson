# Função de Raiz Quadrada usando o Método Newton-Raphson Recursivo 🔁🔍

Este projeto tem como objetivo implementar uma versão recursiva do método numérico conhecido como Newton-Raphson, com uma particularidade específica: calcular a raiz quadrada de um número inteiro e positivo, denominado x. O método de Newton-Raphson é uma técnica iterativa baseada na linearização de funções, utilizada para encontrar as raízes de uma função por meio de aproximações sucessivas.

A regra de recursividade que implementa o cálculo da raiz quadrada utilizando o método Newton-Raphson é a seguinte:
<p align="center">
  <img src="https://github.com/e-patricio/newton-raphson/assets/140465756/64ad6f32-977d-408e-a588-ccdcb83dca10" alt="Fórmula">
</p>

Onde x é o valor que desejamos encontrar a raiz quadrada, e i é o número de iterações que o método irá executar. Por exemplo, se executarmos a função para x = 100 e i = 3 a função retornará a
resposta sqrt_nr(100, 3) = 26, pois não houveram iterações suficientes para que o resultado convergisse. Agora, para os valores de x = 100 e i = 5, temos: sqrt_nr(100, 5) = 10, ou seja, o resultado
convergiu adequadamente pois √100 = 10.

## Como Executar
Para executar o alto nível desse programa:
1. Certifique-se de ter o Java instalado na máquina. Caso não tenha, acesse o [site oficial do Java](https://www.java.com/pt-BR/download/) e siga as instruções de instalação.
2. Utilize uma IDE (ferramenta de desenvolvimento) compatível com Java.
3. Baixe ou clone este repositório.
4. Execute o arquivo `altoNivel.java`.

Para executar o baixo nível desse programa:
1. Certifique-se de ter o ambiente de desenvolvimento MIPS configurado na sua máquina. Se necessário, consulte a documentação da sua IDE ou ferramenta de desenvolvimento para configurar o ambiente.
2. Abra o arquivo `baixoNivel.asm` no seu ambiente de desenvolvimento para assembly MIPS.
3. Compile e execute o código assembly MIPS para obter o resultado do cálculo da raiz quadrada utilizando o método Newton-Raphson de forma recursiva.

Lembre-se de ajustar as configurações do seu ambiente de desenvolvimento conforme necessário para garantir a compilação e execução corretas do código tanto em Java quanto em Assembly.

## Autores
[Eduarda dos Santos Patricio](https://github.com/e-patricio)

[Giovanna da Cruz Castro](https://github.com/gihcst)

[Naiumy dos Reis](https://github.com/Naiumydosreis)

[Yasmin Cardozo Aguirre](https://github.com/4gu1rr3)
