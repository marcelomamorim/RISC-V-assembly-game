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

### Arquivo principal: game.s

O loop principal do jogo:

```
### GAMELOOP ###
GAMELOOP:
	# Switch frame
	li t0,0xFF200604	# escolhe o frame 0 ou 1
	sw s11,0(t0)		# troca de frame
	
	xori s11,s11,0x0001	# inverte o frame atual
	
	# Verifica se o player pressionou alguma tecla
	li t1,0xFF200000		# carrega o endereco de controle do KDMMIO
	lw t0,0(t1)			# le bit de Controle Teclado
	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,T_NO_KEY   		# se nenhuma tecla foi pressionada continua o GAMELOOP
	
	# pressionou uma tecla
	lw t2,4(t1)  		# le o valor da tecla tecla
	
	li t0,97		# a
	beq t2,t0,T_P1_ESQ	# anda para a esquerda	
	
	li t0,100		# d
	beq t2,t0,T_P1_DIR	# anda para a direita

	li t0,99		# c
	beq t2,t0,T_P1_PUNCH	# soco
	
	li t0,118		# v
	beq t2,t0,T_P1_KICK	# chute
	
	li t0,113		# q
	beq t2,t0,T_P1_JUMP_LEFT# pulo para a esquerda
	
	li t0,101		# e
	beq t2,t0,T_P1_JUMP_RIGHT# pulo para a direita
	
	li t0,122		# z
	beq t2,t0,T_P1_ROLL	# rolamento
	
	li t0,119		  	# w
	beq t2,t0,T_P1_JUMP_CENTER 	# pulo central
	
	li t0,110		  	# n
	beq t2,t0,CHEAT_NEXT_LEVEL 	# pr�xima fase
	
	li t0,98		  	# b
	beq t2,t0,CHEAT_PREV_LEVEL 	# fase anterior
	
	# tecla nao identificada
	
T_NO_KEY:	# prefixo T pois o beq nao suporta o tamanho do LABEL
	la t0,NO_KEY
	jr t0
T_P1_ESQ:
	la t0,P1_ESQ
	jr t0
T_P1_DIR:
	la t0,P1_DIR
	jr t0
T_P1_PUNCH:
	la t0,P1_PUNCH
	jr t0
T_P1_KICK:
	la t0,P1_KICK
	jr t0
T_P1_JUMP_LEFT:
	la t0,P1_JUMP_LEFT
	jr t0
T_P1_JUMP_RIGHT:
	la t0,P1_JUMP_RIGHT
	jr t0
T_P1_JUMP_CENTER:
	la t0,P1_JUMP_CENTER
	jr t0
T_P1_ROLL:
	la t0,P1_ROLL
	jr t0

CHEAT_NEXT_LEVEL:
	addi s10,s10,1	# level++
	la t0,LOAD_LEVEL
	jr t0
	
CHEAT_PREV_LEVEL:
	addi s10,s10,-1	# level--
	la t0,LOAD_LEVEL
	jr t0
	
P1_ESQ:	WALK_P1_ESQ()
	la t0,CONT_GAMELOOP
	jr t0
P1_DIR:	WALK_P1_DIR()
	la t0,CONT_GAMELOOP
	jr t0
P1_JUMP_LEFT: JUMP_P1_LEFT()
	la t0,CONT_GAMELOOP
	jr t0
P1_JUMP_RIGHT: JUMP_P1_RIGHT()
	la t0,CONT_GAMELOOP
	jr t0
P1_JUMP_CENTER: JUMP_P1_CENTER()
	la t0,CONT_GAMELOOP
	jr t0
P1_ROLL:ROLL_P1()
	la t0,CONT_GAMELOOP
	jr t0


```

- Player 1: animations_player1.s

Exemplo de funcionalidade do player 1 definida como macro.

```
.macro KICK_P1() # chute
	beqz s2,T_RIGHT	# orientacao = 0
	j LEFT

T_RIGHT:
	la t0,RIGHT
	jr t0

LEFT:	KICK_P1_LEFT() # animacao de chute para a esquerda
	la t0,END
	jr t0
RIGHT:	KICK_P1_RIGHT() 	# animacao de chute para a direita

END:
.end_macro

```

### Player 2: animations_player2.s

Faz a animação de quando o player 2 é perde o round.

```

.macro PRINT_P2_DEFEATED() # printa o player 2 derrotado no chão
	mv a0,s5	# x do player 2
	beqz s6,RIGHT

LEFT:	PRINT_SPRITE(p2_0_defeat4, 30)
	j END
RIGHT:	PRINT_SPRITE(p2_1_defeat4, 30)
	j END
END:
.end_macro


```

### Macros: GAME_MACROS.s

    Exemplo de macro onde passamos dois parâmetros -> o arquivo .data importado em 'sprite.s' e a altura da imagem. Essa função foi bem útil para fazer os movimentos de pulo.

```
.macro PRINT_SPRITE(%sprite, %y) # endereco - largura - altura - x - y (imprime o sprite na posicao (X, Y))
	li t4,0xFF000000 # endereco inicial da memoria de video
	la a5,%sprite 	# carrega o sprite
	
	lw a1,4(a5)	# a1 = h (altura do sprite)
	lw a2,0(a5)	# a2 = w (largura do sprite)
	
	mv a3,a0	# a3 = x
	li a4,%y	# a4 = y
	
	addi a5,a5,8 	# primeiro 8 pixels depois das informacoes de nlin ncol
	
	li t0,240
	sub t1,t0,a4	# inverte a orientacao em relacao ao eixo X
	sub t0,t1,a1
	
	mv a4,t0
			# t5 (ini) = x + 320 * (y - 1)
	mv t5,a3	# t5 = x
	li t1,320	
	mul t6,t1,a4	# t6 = 320 * y
	add t5,t5,t6	# t5 += t6
	
	add t4,t4,t5	# t4 += inicio
	
	li t3,320	# sum = 320 - w (quantidade para pular para a proxima linha)
	sub t3,t3,a2	# -w
	
	sub t4,t4,t3	# memoria -= inicio (afinal pula a cada LOOP_I, inclusive o primeiro)
	
	li t1,0 # i
	li t2,0 # j
	
	# escolhe o frame
	beqz s11,LOOP_I		# frame 0
	li t0,0x00100000
	add t4,t4,t0		# frame 1
	
LOOP_I:
	beq t1,a1,EXIT_LOOP
	addi t1,t1,1 	# i++
	li t2,0		# j = 0
	
	add t4,t4,t3
	
LOOP_J:
	beq t2,a2,LOOP_I
	addi t2,t2,1	# j++
	
	lb t0,0(a5)
	
	li a0,0xFFFFFFC7		# cor magenta
	beq t0,a0,CONT_LOOP_I	# se o pixel for magenta nao imprime nada

PRINT_IMG:	sb t0,0(t4)
	
CONT_LOOP_I:
	addi a5,a5,1	# sprite++
	addi t4,t4,1	# memoria++
	
	j LOOP_J

EXIT_LOOP:

.end_macro

```

### Imagens: sprites.s
    Um exemplo de como ficou a importação da imagem do mapa 1 para o programa:
    > .include "./images/map1.data"

### imagens em formato .data
    Todas as imagens foram convertidas do formato .bmp com dimensões 320x240 para .data a partir do programa bmp2oac.exe


## Artigo

Foi produzido um artigo como resultado do desenvolvimento desse jogo.