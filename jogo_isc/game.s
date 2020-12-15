.include "./MACROSv21.s"
.include "./GAME_MACROS.s"
.include "./animations_player1.s"
.include "./animations_player2.s"

.data
.include "./sprites.s"

novice: .string "NOVICE"
st: .string "ST"
nd: .string "ND"
rd: .string "RD"
th: .string "TH"
dan: .string "DAN"
oneplayer: .string "1 PLAYER"

### JOGO ###
.text
	#la t0,GAME
	#jr t0
	
	li s11,0		# frame 0
	CHANGE_BACKGROUND(home_screen)
	li s11,1		# frame 1
	CHANGE_BACKGROUND(home_screen)
	
	li s4,1		# quantidade incrementada (1 ou -1)
	li s5,0		# frame atual do Shitake
	
MENU_LOOP:
	li t0,0xFF200604	# escolhe o frame 0 ou 1
	sw s11,0(t0)		# troca de frame
	xori s11,s11,0x0001	# inverte o frame

	j IMPRIME_SHITAKE	# imprime frame atual do Shitake
CONT_LOOP:
	add s5,s5,s4	# incrementa frame (+ / -)
	li t1,6
	beq s5,t1,SUB_FRAME_SHITAKE 	# frame--
	beqz s5,SUM_FRAME_SHITAKE	# frame++

CONT_LOOP2:
	li t1,0xFF200000	# carrega o endereco de controle do KDMMIO
	lw t0,0(t1)		# le bit de Controle Teclado
   	andi t0,t0,0x0001	# mascara o bit menos significativo
   	beq t0,zero,MENU_LOOP	# nao tem tecla pressionada entao volta ao loop
   	lw t2,4(t1)		# le o valor da tecla

	# inicializa os dados para a primeira fase
	### PLAYER 1 ###
	li s1,0	# p1_x-axis
	li s2,0	# p1_orientation
	li s3,0 # p1_yinyang-points
	li s4,0 # p1_score-points
	
	### PLAYER 2 ###
	li s5,0 # p2_x-axis
	li s6,1 # p2_orientation
	li s7,0 # p2_yinyang-points
	
	### GAME ###
	li s8,0		# contador de frames
	li s9,30 	# countdown
	li s10,0	# fase 0
	li s11,0	# frame 0
	
	la t0,GAME
	jr t0
	
SUM_FRAME_SHITAKE: 	li s4,1
			j CONT_LOOP2
SUB_FRAME_SHITAKE: 	li s4,-1
			j CONT_LOOP2
IMPRIME_SHITAKE:
	li a0,275	# x_axis do Shitake
	PRINT_SPRITE(sand_cat, 2) # apaga o frame anterior do Shitake
	
	li a0,275	# x_axis do Shitake
        li t0,0
        beq s5,t0,SHITAKE1
        li t0,1
        beq s5,t0,SHITAKE2
        li t0,2
        beq s5,t0,SHITAKE3
        li t0,3
        beq s5,t0,SHITAKE4
        li t0,4
        beq s5,t0,SHITAKE5
        j SHITAKE6

SHITAKE1:	PRINT_SPRITE(shitake1, 2)
        	j CONT_LOOP
SHITAKE2:    	PRINT_SPRITE(shitake2, 2)
        	j CONT_LOOP
SHITAKE3:    	PRINT_SPRITE(shitake3, 2)
        	j CONT_LOOP
SHITAKE4:    	PRINT_SPRITE(shitake4, 2)
        	j CONT_LOOP
SHITAKE5:    	PRINT_SPRITE(shitake5, 2)
        	j CONT_LOOP
SHITAKE6:    	PRINT_SPRITE(shitake6, 2)
        	j CONT_LOOP

### GAME INFO ###
GAME:
	la t0,LOAD_LEVEL
	jr t0
	
FINISH_GAME_P1: # termina a fase com o player 1 como vencedor
	addi s4,s4,100	# adiciona 100 pontos ao score
	addi s3,s3,1	# p1_yinyang++
	YIN_YANG()	# atualiza os yinyang atual
	
	DEFEAT_P2()
	FINISH_P1()
	
	COUNTDOWN_POINTS()	# animacao dos pontos do cronometro
	
	li t0,4
	bge s3,t0,T_NEXT_LEVEL	# se p1_yinyang >= 4, proxima fase
	j CONT_FINISH_GAME_P1
	
T_NEXT_LEVEL: # intermediario pois o endereco eh muito longo
	la t0,NEXT_LEVEL
	jr t0
	
CONT_FINISH_GAME_P1:
	la t0,GAME
	jr t0

NEXT_LEVEL: # carrega a proxima fase
	addi s10,s10,1	# proximo level (max: 10TH DAN)
	
	la t0,RESET_LEVEL
	jr t0

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
	
### PUNCH ###
P1_PUNCH:PUNCH_P1()
	VER_DIST()	# verifica distancia

	li t2,37
	blt a0,t2,PUNCH_FINISH_GAME	# dist <= 36

	la t0,CONT_GAMELOOP
	jr t0
PUNCH_FINISH_GAME:
	la t0,FINISH_GAME_P1
	jr t0

### KICK ###
P1_KICK:KICK_P1()
	VER_DIST()			# verifica distancia
	li t0,49			# range do chute
	blt a0,t0,KICK_FINISH_GAME	# dist <= 48 finaliza a fase atual
	
	la t0,CONT_GAMELOOP
	jr t0

KICK_FINISH_GAME:
	la t0,FINISH_GAME_P1
	jr t0
	
NO_KEY:
CONT_GAMELOOP:
	REVERSE_PLAYERS()
	
	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo
	beqz s9,EMPATE	# tempo acabou

	la t0,GAMELOOP
	jr t0

FINISH_GAMELOOP:	# faz algo
	la t0,GAMELOOP
	jr t0

EMPATE: DRAW()
	la t0,LOAD_LEVEL
	jr t0

RESET_LEVEL: # reseta o n�vel por completo
	li s3,0	# p2_yinyang
	li s7,0	# p2_yinyang

LOAD_LEVEL: # carrega o nivel (s10)
	beqz s10,T_MAP1	# se for 0 vai pro mapa 1 (novice)
	
	# multiplo de 4 = mapa 4
	li t1,4
	rem t0,s10,t1
	beqz t0,T_MAP4
	
	# multiplo de 3 = mapa 3
	li t1,3
	rem t0,s10,t1
	beqz t0,T_MAP3
	
	# multiplo de 2 = mapa 2
	li t1,2
	rem t0,s10,t1
	beqz t0,T_MAP2
	
	# mapa 1
	
T_MAP1:	la t0,MAP1
	jr t0
T_MAP2:	la t0,MAP2
	jr t0
T_MAP3:	la t0,MAP3
	jr t0
T_MAP4:	la t0,MAP4
	jr t0

MAP1:	li s11,0
	CHANGE_BACKGROUND(map1)
	li s11,1
	CHANGE_BACKGROUND(map1)
	la t0,RESET
	jr t0
MAP2:	li s11,0
	CHANGE_BACKGROUND(map2)
	li s11,1
	CHANGE_BACKGROUND(map2)
	la t0,RESET
	jr t0
MAP3:	li s11,0
	CHANGE_BACKGROUND(map3)
	li s11,1
	CHANGE_BACKGROUND(map3)
	la t0,RESET
	jr t0
MAP4:	li s11,0
	CHANGE_BACKGROUND(map4)
	li s11,1
	CHANGE_BACKGROUND(map4)
	la t0,RESET
	jr t0

RESET:	# RESETA VALORES (ambos os frames)
	li s1,60	# p1_x-axis
	li s2,0		# p1_orientation
	li s5,212 	# p2_x-axis
	li s6,1 	# p2_orientation
	li s9,30 	# countdown
	li s0,0		# aux. cronometro
	li s11,0 	# frame atual
		
	PRINT_SCORE()
	
	# PRINT 1 PLAYER
	li a4,0		# frame 0
	li a7,304	# ecall customizada com a fonte do jogo
	li a1,251	# x
	li a2,45	# y
	la a0,oneplayer	# carrega a string "1 PLAYER"
	ecall
	li a4,1		# frame 1
	li a1,251	# x
	li a2,45	# y
	la a0,oneplayer	# carrega a string "1 PLAYER"
	ecall
	
	li a4,0 	# frame 0
	PRINT_LEVEL()
	li a4,1		# frame 1
	PRINT_LEVEL()
	
	YIN_YANG()
	COUNTDOWN()
	
	GREET()		# animacao de cumprimento
	
	la t0,GAMELOOP
	jr t0

EXIT:	li a7,10	# syscall de exit
	ecall

.include "./SYSTEMv21_MOD.s"
