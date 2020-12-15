# MACROS para fun��es do jogo em geral

.macro SLEEP (%x) # Para a execucao por X ms
    li a7,32
    li a0,%x
    ecall
.end_macro

.macro CHANGE_BACKGROUND(%img) 	# Atualiza o background
	li t1,0xFF000000	# endereco inicial da Memoria VGA - frame 0
	li t2,0xFF012C00	# endereco final
	la t4,%img
	addi t4,t4,8		# primeiro pixels depois das informa??es de nlin ncol

	# escolhe o frame
	beqz s11,LOOP		# frame 0
	li t0,0x00100000
	add t1,t1,t0	# frame 1
	add t2,t2,t0	# frame 1
LOOP: 	
    	beq t1,t2,END		# Se for o ?ltimo endereco entao sai do loop
	lw t3,0(t4)		# le um conjunto de 4 pixels : word
	sw t3,0(t1)		# escreve a word na memoria VGA
	addi t1,t1,4		# soma 4 ao endereco
	addi t4,t4,4
	j LOOP			# volta a verificar

END:

.end_macro

.macro CHANGE_BACKGROUND_PARTIAL()	# atualiza a parte do mapa que eh relevante
	# carrega de acordo com o mapa atual
	beqz s10, MAP1	# se for 0 vai pro mapa 1 (novice)
	
	# multiplo de 4 = mapa 4
	li t1,4
	rem t0,s10,t1
	beqz t0,MAP4
	
	# multiplo de 3 = mapa 3
	li t1,3
	rem t0,s10,t1
	beqz t0,MAP3
	
	# multiplo de 2 = mapa 2
	li t1,2
	rem t0,s10,t1
	beqz t0,MAP2
	
	# mapa 1		
	j MAP1
	
MAP1:	la t4,map1
	j CONT_BKG
MAP2:	la t4,map2
	j CONT_BKG
MAP3:	la t4,map3
	j CONT_BKG
MAP4:	la t4,map4

CONT_BKG:
	li t1,0xFF000000	# endereco inicial da Memoria VGA - frame 0
	li t2,0xFF010680	# endereco final - 53 linhas (generalizado para todos os mapas e sprites)
	addi t4,t4,8		# primeiro pixels depois das informa??es de nlin ncol
	
	li t0,0x0000BB80	# 150 linhas
	add t4,t4,t0		# pula no frame
	add t1,t1,t0		# pula na memoria VGA
	
	# escolhe o frame
	beqz s11,LOOP		# frame 0
	li t0,0x00100000
	add t1,t1,t0		# frame 1
	add t2,t2,t0		# frame 1
	
LOOP: 	
    	beq t1,t2,END		# Se for o ultimo endereco entao sai do loop
	lw t3,0(t4)		# le um conjunto de 4 pixels : word
	sw t3,0(t1)		# escreve a word na memoria VGA
	addi t1,t1,4		# soma 4 ao endereco
	addi t4,t4,4
	j LOOP			# volta a verificar

END:
	
.end_macro

.macro CHANGE_BACKGROUND_PARTIAL_JUMP() # atualiza a parte do mapa que é relevante abrangendo o pulo
	# carrega de acordo com o mapa atual
	beqz s10,MAP1	# se for 0 vai pro mapa 1 (novice)
	
	# multiplo de 4 = mapa 4
	li t1,4
	rem t0,s10,t1
	beqz t0,MAP4
	
	# multiplo de 3 = mapa 3
	li t1,3
	rem t0,s10,t1
	beqz t0,MAP3
	
	# multiplo de 2 = mapa 2
	li t1,2
	rem t0,s10,t1
	beqz t0,MAP2
	
	# mapa 1		
	j MAP1
	
MAP1:	la t4,map1
	j CONT_BKG
MAP2:	la t4,map2
	j CONT_BKG
MAP3:	la t4,map3
	j CONT_BKG
MAP4:	la t4,map4

CONT_BKG:
	li t1,0xFF000000	# endereco inicial da Memoria VGA - frame 0
	li t2,0xFF010680	# endereco final - 53 linhas (generalizado para todos os mapas e sprites)
	addi t4,t4,8		# primeiro pixels depois das informa??es de nlin ncol
	
	li t0,0x00008980	# 124 linhas
	add t4,t4,t0		# pula no frame
	add t1,t1,t0		# pula na memoria VGA
	
	# escolhe o frame
	beqz s11,LOOP		# frame 0
	li t0,0x00100000
	add t1,t1,t0		# frame 1
	add t2,t2,t0		# frame 1
	
LOOP: 	
    	beq t1,t2,END		# Se for o ultimo endereco entao sai do loop
	lw t3,0(t4)		# le um conjunto de 4 pixels : word
	sw t3,0(t1)		# escreve a word na memoria VGA
	addi t1,t1,4		# soma 4 ao endereco
	addi t4,t4,4
	j LOOP			# volta a verificar

END:
.end_macro

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

.macro COUNTDOWN()
	mv a0,s9	# tempo atual
	
	li a7,301	# ecall customizada com a fonte do jogo
	li a1,152	# x
	li a2,25	# y
	li a3,0xFBCA	# cor
	li a4,0		# frame 0
	mv t2,a1	# salvando em registrador tempor�rios pois alguns registradores "a" resetam apos uma ecall
	
	li t0,10
	bge a0,t0,PRINT_CN 	# se for maior ou igual a 10
	addi a1,a1,8 		# imprime 1 casa a frente, se for menor que 10
	
PRINT_CN:
	mv t1,a0 	# salvando em registrador tempor�rios pois alguns registradores "a" resetam apos uma ecall
	mv t2,a1
	ecall
	
	li a4,1		# frame 1
	mv a0,t1	# tempo atual
	mv a1,t2	# x
	ecall
	
	mv a0,t1
	li t0,10
	bge a0,t0,EXIT_CN # se for maior ou igual a 10

ERASE_CN:
	li a4,0		# frame 0
	li a7,111	# printChar
	li a0,1		# caractere inv�lido
	li a1,152	# x
	li a2,25	# y
	li a3,0xFB07	# cor de fundo
	ecall
	li a4,1		# frame 1
	li a1,152	# x
	ecall
EXIT_CN:

.end_macro

.macro ADD_FRAME_COUNTDOWN() # contador de frames++
	addi s0,s0,1
.end_macro

.macro VER_COUNTDOWN() # verifica se atualiza countdown
	li t1,10			# FPS
	bne s0,t1,END	# nao soma cronômetro (10FPS)

	addi s9,s9,-1		# tempo--
	li s0,0			# reseta o contador de frames
	COUNTDOWN()		# imprime o tempo atualizado na tela
END:

.end_macro

.macro PRINT_LEVEL() # imprime o nivel (s10) na tela formatado
	mv a0,s10
	li a7,1
	ecall
	
	beqz s10,T_NOVICE
	
	li t0,10
	bge s10,t0,T_TEN	# nivel >= 10 repete
	
	li t0,1
	beq s10,t0,FIRST_F
	
	li t0,2
	beq s10,t0,SECOND_F
	
	li t0,3
	beq s10,t0,THIRD_F
	
	la t0,OTHER
	jr t0
	
T_NOVICE:la t0,NOVICE2
	jr t0
T_TEN:	la t0,TEN2
	jr t0

FIRST_F: 	la a0,st	# recebe a string "ST"
	j PRINT_DAN
SECOND_F:	la a0,nd	# recebe a string "ND"
	j PRINT_DAN
THIRD_F: 	la a0,rd	# recebe a string "RD"
	j PRINT_DAN
OTHER:	la a0,th	# recebe a string "TH"

PRINT_DAN:
	li a7,304	# ecall customizada com a fonte do jogo
	li a1,13	# x
	li a2,45	# y
	li a3,0xFBCA	# cor
	ecall
	
	la a0,dan	# recebe a string "DAN"
	li a1,37	# x
	ecall
	
	li a7,301	# ecall customizada com a fonte do jogo
	li a1,5		# x
	mv a0,s10	# recebe o nivel atual
	ecall

	j END
	
NOVICE2:
	li a7,304	# ecall customizada com a fonte do jogo
	li a1,5		# x
	li a2,45	# y
	li a3,0xFBCA	# cor
	la a0,novice	# recebe a string "NOVICE"
	ecall
	
	j END

TEN2:	
	li a7,301	# ecall customizada com a fonte do jogo
	li a1,5		# x
	li a2,45	# y
	li a3,0xFBCA	# cor
	li a0,10	# recebe o numero 10
	ecall
	
	li a7,304	# ecall customizada com a fonte do jogo
	li a1,21	# x
	la a0,th	# recebe a string "TH"
	ecall

	li a1,45	# x
	la a0,dan	# recebe a string "DAN"
	ecall
END:

.end_macro

.macro PRINT_SCORE()
	# PRINT SCORE
	li a4,0		# frame 0
	li a7,301	# ecall customizada com a fonte do jogo
	li a1,80	# x
	li a2,25	# y
	li a3,0xFBCA	# cor
	mv a0,s4	# valor impresso
	ecall
	li a4,1		# frame 1
	mv a0,s4	# valor impresso
	li a1,80	# x
	ecall
.end_macro

.macro YIN_YANG()	# printa o YIN_YANG de ambos os players (p1 = s3, p2 = s7)
	# PLAYER 1
	beqz s3,T_PLAYER2		# s3 == 0
	li t3,1
	beq s3,t3,T_YIN_YANG_1_P1	# s3 == 1
	li t3,2
	beq s3,t3,T_YIN_YANG_2_P1	# s3 == 2
	li t3,3
	beq s3,t3,T_YIN_YANG_3_P1	# s3 == 3

	la t0,YIN_YANG_4_P1		# s3 == 4
	jr t0

T_PLAYER2:
	la t0,PLAYER2
	jr t0
T_YIN_YANG_1_P1:
	la t0,YIN_YANG_1_P1
	jr t0
T_YIN_YANG_2_P1:
	la t0,YIN_YANG_2_P1
	jr t0
T_YIN_YANG_3_P1:
	la t0,YIN_YANG_3_P1
	jr t0

YIN_YANG_1_P1:
	PRINT_YIN_YANG_1_P1()
	
	la t0,PLAYER2
	jr t0
YIN_YANG_2_P1:
	PRINT_YIN_YANG_2_P1()

	la t0,PLAYER2
	jr t0
YIN_YANG_3_P1:
	PRINT_YIN_YANG_2_P1()
	PRINT_YIN_YANG_3_P1()

	la t0,PLAYER2
	jr t0
YIN_YANG_4_P1:
	PRINT_YIN_YANG_2_P1()
	PRINT_YIN_YANG_4_P1()

PLAYER2:	# PLAYER 2
	beqz s7,T_END		# s7 == 0
	li t3,1
	beq s7,t3,T_YIN_YANG_1_P2	# s7 == 1
	li t3,2
	beq s7,t3,T_YIN_YANG_2_P2	# s7 == 2
	li t3,3
	beq s7,t3,T_YIN_YANG_3_P2	# s7 == 3

	la t0,YIN_YANG_4_P2		# s7 == 4
	jr t0

T_END:
	la t0,END
	jr t0
T_YIN_YANG_1_P2:
	la t0,YIN_YANG_1_P2
	jr t0
T_YIN_YANG_2_P2:
	la t0,YIN_YANG_2_P2
	jr t0
T_YIN_YANG_3_P2:
	la t0,YIN_YANG_3_P2
	jr t0

YIN_YANG_1_P2:
	PRINT_YIN_YANG_1_P2()
	
	la t0,END
	jr t0
YIN_YANG_2_P2:
	PRINT_YIN_YANG_2_P2()

	la t0,END
	jr t0
YIN_YANG_3_P2:
	PRINT_YIN_YANG_2_P2()
	PRINT_YIN_YANG_3_P2()

	la t0,END
	jr t0
YIN_YANG_4_P2:
	PRINT_YIN_YANG_2_P2()
	PRINT_YIN_YANG_4_P2()
			
END:	li s11,0	# retorna no frame 0

.end_macro

.macro PRINT_YIN_YANG_1_P1()
	li a0,50
    PRINT_SPRITE(yin, 210)
    xori s11,s11,0x001    # inverte o frame atual
    li a0,50
    PRINT_SPRITE(yin, 210)
.end_macro

.macro PRINT_YIN_YANG_2_P1()
	li a0,50
    PRINT_SPRITE(yinyang, 210)
    xori s11,s11,0x001    # inverte o frame atual
    li a0,50
    PRINT_SPRITE(yinyang, 210)
.end_macro

.macro PRINT_YIN_YANG_3_P1()
	li a0,30
    PRINT_SPRITE(yin, 210)
    xori s11,s11,0x001    # inverte o frame atual
    li a0,30
    PRINT_SPRITE(yin, 210)
.end_macro

.macro PRINT_YIN_YANG_4_P1()
	li a0,30
    PRINT_SPRITE(yinyang, 210)
    xori s11,s11,0x001    # inverte o frame atual
    li a0,30
    PRINT_SPRITE(yinyang, 210)
.end_macro

.macro PRINT_YIN_YANG_1_P2()
	li a0,255
    PRINT_SPRITE(yin, 210)
    xori s11,s11,0x001    # inverte o frame atual
    li a0,255
    PRINT_SPRITE(yin, 210)
.end_macro

.macro PRINT_YIN_YANG_2_P2()
	li a0,255
    PRINT_SPRITE(yinyang, 210)
    xori s11,s11,0x001    # inverte o frame atual
    li a0,255
    PRINT_SPRITE(yinyang, 210)
.end_macro

.macro PRINT_YIN_YANG_3_P2()
	li a0,275
    PRINT_SPRITE(yin, 210)
    xori s11,s11,0x001    # inverte o frame atual
    li a0,275
    PRINT_SPRITE(yin, 210)
.end_macro

.macro PRINT_YIN_YANG_4_P2()
	li a0,275
    PRINT_SPRITE(yinyang, 210)
    xori s11,s11,0x001    # inverte o frame atual
    li a0,275
    PRINT_SPRITE(yinyang, 210)
.end_macro

.macro REVERSE_PLAYERS() # inverte a orientação dos players, se for o caso
	mv t0,s5	# x do player 2
	addi t0,t0,16	# range para inverter

	bge s1,t0,REVERSE	# se x1 >= x2-32
	j ORIGINAL

REVERSE:
	li s2,1
	li s6,0
	j END
ORIGINAL:
	li s2,0
	li s6,1
END:
	PRINT_P2()
	PRINT_P1()
.end_macro

.macro VER_JUMP_LEFT_P1() # verifica e atualiza para o pulo para a esquerda nao sair do mapa
	bltz s1,LIMIT
	j END

LIMIT: li s1,0
END:
.end_macro

.macro VER_JUMP_LEFT_P2() # verifica e atualiza para o pulo para a esquerda nao sair do mapa
	bltz s5,LIMIT
	j END

LIMIT: li s5,0
END:
.end_macro

.macro VER_JUMP_RIGHT_P1() # verifica e atualiza para o pulo para a direita nao sair do mapa
	li t0,273
	bge s1,t0,LIMIT
	j END
	
LIMIT: li s1,273
END:
.end_macro

.macro VER_JUMP_RIGHT_P2() # verifica e atualiza para o pulo para a direita nao sair do mapa
	li t0,273
	bge s5,t0,LIMIT
	j END
	
LIMIT: li s5,273
END:
.end_macro

.macro VER_WALK_P1_RIGHT() # verifica e atualiza player em posicao de ataque para nao sair do mapa
	li t0,272
	bge s1,t0,LIMIT
	j END
	
LIMIT: li s1,272
END:
.end_macro

.macro VER_WALK_P2_RIGHT() # verifica e atualiza player em posicao de ataque para nao sair do mapa
	li t0,272
	bge s5,t0,LIMIT
	j END
	
LIMIT: li s5,272
END:
.end_macro

### DEVELOPMENT / TEST ###
.macro ANIMATION_TEST() # testa as animações in-game de ambos os players
	li s1,100	# x do player 1
	
	li s2,0
	PRINT_P1()
    WALK_P1_ESQ()
    WALK_P1_DIR()
    JUMP_P1_LEFT()
    JUMP_P1_RIGHT()
    PUNCH_P1()
    KICK_P1()
	PRINT_P1_DEFEATED()
	DEFEAT_P1()
	FINISH_P1()
    li s2,1
	PRINT_P1()
    WALK_P1_ESQ()
    WALK_P1_DIR()
    JUMP_P1_LEFT()
    JUMP_P1_RIGHT()
    PUNCH_P1()
    KICK_P1()
	PRINT_P1_DEFEATED()
	DEFEAT_P1()
	FINISH_P1()

	li s5,200	# x do player 2
	li s6,0
	PRINT_P2()
    WALK_P2_ESQ()
    WALK_P2_DIR()
    JUMP_P2_LEFT()
    JUMP_P2_RIGHT()
    PUNCH_P2()
    KICK_P2()
	PRINT_P2_DEFEATED()
	DEFEAT_P2()
	FINISH_P2()
    li s6,1
	PRINT_P2()
    WALK_P2_ESQ()
    WALK_P2_DIR()
    JUMP_P2_LEFT()
    JUMP_P2_RIGHT()
    PUNCH_P2()
    KICK_P2()
	PRINT_P2_DEFEATED()
	DEFEAT_P2()
	FINISH_P2()
	
.end_macro