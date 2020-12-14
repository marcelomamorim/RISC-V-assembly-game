# MACROS para animacoes do player 2

.macro PRINT_P2() # printa o player 2 em posicao de ataque
	mv a0,s5	# x do player 2
	beqz s6,RIGHT

LEFT:	PRINT_SPRITE(p2_1_walking1, 30)
	j END
RIGHT:	PRINT_SPRITE(p2_0_walking1, 30)
	j END
END:
.end_macro

.macro PRINT_P2_DEFEATED() # printa o player 2 derrotado no chão
	mv a0,s5	# x do player 2
	beqz s6,RIGHT

LEFT:	PRINT_SPRITE(p2_0_defeat4, 30)
	j END
RIGHT:	PRINT_SPRITE(p2_1_defeat4, 30)
	j END
END:
.end_macro

.macro WALK_P2_DIR() # anda para a direita
	mv t0,a0	# salva em t0 o x do player atual
	addi s5,s5,8	# x += 8

	beqz s6,RIGHT	# orientacao = 0

LEFT:	
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5	# carrega o x atual
	addi a0,a0,-8
	PRINT_SPRITE(p2_1_walking2, 30)
    PRINT_P1()
	li t0,0xFF200604	# escolhe o frame 0 ou 1
	sw s11,0(t0)		# troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	# imprime o player em posicao de ataque nos dois frames
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2()
    PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame
	
	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2()
    PRINT_P1()
	
	j END
RIGHT:
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5	# carrega o x atual
	addi a0,a0,-8
	PRINT_SPRITE(p2_0_walking2, 30)
    PRINT_P1()
	li t0,0xFF200604	# escolhe o frame 0 ou 1
	sw s11,0(t0)		# troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	# imprime o player em posicao de ataque nos dois frames
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2()
    PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame
	
	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2()
    PRINT_P1()

END:
	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	li s11,0	# retorna no frame 0

.end_macro

.macro WALK_P2_ESQ() # anda para a esquerda
	mv t0,a0	# salva em t0 o x do player atual
	addi s5,s5,-8	# x -= 8

	beqz s6,RIGHT	# orientacao = 0

LEFT:
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5	# carrega o x atual
	addi a0,a0,2
	PRINT_SPRITE(p2_1_walking2, 30)
	PRINT_P1()
	li t0,0xFF200604	# escolhe o frame 0 ou 1
	sw s11,0(t0)		# troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	# imprime o player em posicao de ataque nos dois frames
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2()
    PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2()
    PRINT_P1()
	
	j END
RIGHT:
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5	# carrega o x atual
	addi a0,a0,4
	PRINT_SPRITE(p2_0_walking2, 30)
	PRINT_P1()
	li t0,0xFF200604	# escolhe o frame 0 ou 1
	sw s11,0(t0)		# troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	# imprime o player em posicao de ataque nos dois frames
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2()
    PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame
	
	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2()
    PRINT_P1()

END:
	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	li s11,0	# retorna no frame 0

.end_macro

.macro PUNCH_P2() # chute
	beqz s6,T_RIGHT	# orientacao = 0
	j LEFT

T_RIGHT:
	la t0,RIGHT
	jr t0

LEFT:	PUNCH_P2_LEFT() # animacao de chute para a esquerda
	la t0,END
	jr t0
RIGHT:	PUNCH_P2_RIGHT() 	# animacao de chute para a direita

END:
.end_macro

.macro PUNCH_P2_RIGHT() # animacao de soco para a direita
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5
	PRINT_SPRITE(p2_0_punch1, 30)
	PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5
	PRINT_SPRITE(p2_0_punch2, 30)
	PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5
	PRINT_SPRITE(p2_0_punch1, 30)
	PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	# imprime o player em posicao de ataque nos dois frames
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2()
    PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame
	
	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2()
    PRINT_P1()

	li s11,0		# retorna no frame 0
.end_macro

.macro PUNCH_P2_LEFT() # animacao de soco para a direita
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5
	PRINT_SPRITE(p2_1_punch1, 30)
	PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5
	PRINT_SPRITE(p2_1_punch2, 30)
	PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5
	PRINT_SPRITE(p2_1_punch1, 30)
	PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	# imprime o player em posicao de ataque nos dois frames
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2()
    PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame
	
	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2()
    PRINT_P1()

	li s11,0		# retorna no frame 0
.end_macro

.macro KICK_P2_RIGHT() # animacao de chute para a direita
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5
	PRINT_SPRITE(p2_0_kick1, 30)
	PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5
	PRINT_SPRITE(p2_0_kick2, 30)
	PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5
	PRINT_SPRITE(p2_0_kick1, 30)
	PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	# imprime o player em posicao de ataque nos dois frames
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2()
    PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame
	
	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2()
    PRINT_P1()

	li s11,0		# retorna no frame 0
.end_macro

.macro KICK_P2_LEFT() # animacao de chute para a esquerda
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5
	PRINT_SPRITE(p2_1_kick1, 30)
	PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5
	PRINT_SPRITE(p2_1_kick2, 30)
	PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5
	PRINT_SPRITE(p2_1_kick1, 30)
	PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	# imprime o player em posicao de ataque nos dois frames
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2()
    PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame
	
	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2()
    PRINT_P1()

	li s11,0		# retorna no frame 0
.end_macro

.macro KICK_P2() # chute
	beqz s6,T_RIGHT	# orientacao = 0
	j LEFT

T_RIGHT:
	la t0,RIGHT
	jr t0

LEFT:	KICK_P2_LEFT() # animacao de chute para a esquerda
	la t0,END
	jr t0
RIGHT:	KICK_P2_RIGHT() 	# animacao de chute para a direita

END:
.end_macro

.macro DEFEAT_P2() # animacao p1 caindo
	beqz s6,RIGHT	# orientacao = 0

LEFT:
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5
	PRINT_SPRITE(p2_1_defeat1, 30)
    PRINT_P1()
	li t0,0xFF200604	# escolhe o frame 0 ou 1
	sw s11,0(t0)		# troca de frame

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5
	PRINT_SPRITE(p2_1_defeat2, 30)
    PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5
	PRINT_SPRITE(p2_1_defeat3, 30)
    PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame
	
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2_DEFEATED()
    PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	j END
RIGHT:
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5
	PRINT_SPRITE(p2_0_defeat1, 30)
    PRINT_P1()
	li t0,0xFF200604	# escolhe o frame 0 ou 1
	sw s11,0(t0)		# troca de frame

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5
	PRINT_SPRITE(p2_0_defeat2, 30)
    PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5
	PRINT_SPRITE(p2_0_defeat3, 30)
    PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame
	
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
    PRINT_P2_DEFEATED()
    PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

END:	li s11,0	# retorna no frame 0

.end_macro

.macro FINISH_P2() # animacao de finalizacao do player 2
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5
	PRINT_SPRITE(p2_finish1, 30)
    PRINT_P1_DEFEATED()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	SLEEP(500)

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5
	PRINT_SPRITE(p2_finish2, 30)
    PRINT_P1_DEFEATED()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	SLEEP(500)

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5
	PRINT_SPRITE(p2_finish3, 30)
    PRINT_P1_DEFEATED()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	SLEEP(500)

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5
	PRINT_SPRITE(p2_finish4, 30)
    PRINT_P1_DEFEATED()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	SLEEP(500)

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5
	PRINT_SPRITE(p2_finish3, 30)
    PRINT_P1_DEFEATED()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s5
	PRINT_SPRITE(p2_finish3, 30)
    PRINT_P1_DEFEATED()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	SLEEP(500)

	li s11,0		# retorna no frame 0
.end_macro