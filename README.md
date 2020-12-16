## Jogo - The Way of the Exploding Fist

Jogo desenvolvido em grupo para a matéria de Introdução aos Sistemas Computacionais da Universidade de Brasília (UnB). 

![](/readme-imgs/jogo-assembly.png)

Funcionalidades do Player 1:

- Andar para a direita (d)
- Andar para a esquerda (a)
- Chute (c)
- Pulo central (w)
- Pulo esquerda (q)
- Pulo direita (e)
- Rolamento (z)

Movimentos do Player 2:

## Códigos extras
- Próximo nível (n)
- Nível anterior (b)


## Preparando o ambiente e iniciando o jogo


(1) O Rars deve ser instalado. https://github.com/TheThirdOne/rars

(2) Como diz no repositório do Rars: "RARS is distributed as an executable jar. You will need at least Java 8 to run it."

(2.1.) [Linux] Para distros debian-based:

> sudo apt update && sudo apt upgrade && sudo apt install default-jdk

(2.2.) [Linux] Para distros baseadas em arch:

- https://openjdk.java.net/install/

- https://wiki.archlinux.org/index.php/java#OpenJDK

- "Arch Linux officially only supports the OpenJDK implementation."

(2.3.) [Windows]:

- https://docs.oracle.com/en/java/javase/11/install/installation-jdk-microsoft-windows-platforms.html

(3) Clicar na opção 'Assemble the current file and clear breakpoints'.

![](/readme-imgs/assemble-file.png)

(4) Para executar o jogo no Rars é necessário ir à aba (3.1) 'Tools' > Bitmap Display e depois (3.2) 'Tools'> Keyboard and Display MMIO Simulator. Essas ferramentas devem ser conectadas ao programa.

(5) Por fim, clicar na opção 'Run the current program'.

![](/readme-imgs/start.png)

(6) O programa selecionado deve ser o 'game.s'.


## Dinâmica do jogo



O jogo começará assim.


![](/readme-imgs/menu.png)

Após alguma tecla pressionada, irá para a seguinte tela.


![](/readme-imgs/inicio.png)

Os players executam a macro greet(), fazendo os cumprimentos.


![](/readme-imgs/greet.png)

As funcionalidades estão documentadas abaixo:

(c) chute


![](/readme-imgs/chute.png)

(v) golpe


![](/readme-imgs/golpe-c.png)

(w) pulo central


![](/readme-imgs/pulo-cima.png)

(q) pulo para a direita


![](/readme-imgs/pulo-direita.png)

(e) pulo para a esquerda


![](/readme-imgs/pulo-esq.png)

(z) rolamento


![](/readme-imgs/rolamento.png)

## Detalhamento das funcionalidades

- game.s
- animations_player1.s
- animations_player2.s
- GAME_MACROS.s
- sprites.s