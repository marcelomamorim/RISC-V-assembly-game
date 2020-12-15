# MACROS para animacoes do player 1

.macro GREET()	# cumprimentos no inicio de um nivel
	xori s11,s11,0x001	# inverte o frame atual
	li a0,80
	PRINT_SPRITE(p1_greet1, 30)
	li a0,232
	PRINT_SPRITE(p2_greet1, 30)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame
	SLEEP(500)
	
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	li a0,80
	PRINT_SPRITE(p1_greet2, 30)
	li a0,212
	PRINT_SPRITE(p2_greet2, 30)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame
	SLEEP(500)
	
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	li a0,80
	PRINT_SPRITE(p1_greet1, 30)
	li a0,232
	PRINT_SPRITE(p2_greet1, 30)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame
	SLEEP(500)
	
	# players em posicao de ataque nos dois frames
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	li a0,60
	PRINT_SPRITE(p1_0_walking1, 30)
	li a0,212
	PRINT_SPRITE(p2_1_walking1, 30)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame
	
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	li a0,60
	PRINT_SPRITE(p1_0_walking1, 30)
	li a0,212
	PRINT_SPRITE(p2_1_walking1, 30)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame
	
	li s11,0	# sempre "retorna" frame 0
.end_macro

.macro DRAW() # cumprimentos no final de um nível empatado
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s1
	PRINT_SPRITE(p1_finish3, 30)
	mv a0,s5
	PRINT_SPRITE(p2_finish3, 30)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame
	SLEEP(500)
	
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s1
	PRINT_SPRITE(p1_finish4, 30)
	mv a0,s5
	PRINT_SPRITE(p2_finish4, 30)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame
	SLEEP(500)
	
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s1
	PRINT_SPRITE(p1_finish3, 30)
	mv a0,s5
	PRINT_SPRITE(p2_finish3, 30)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame
	SLEEP(500)
	
	li s11,0	# sempre "retorna" frame 0
.end_macro

.macro PRINT_P1() # printa o player 1 em posicao de ataque
	mv a0,s1	# x do player 1
	beqz s2,RIGHT

LEFT:	PRINT_SPRITE(p1_1_walking1, 30)
	j END
RIGHT:	PRINT_SPRITE(p1_0_walking1, 30)
	j END
END:
.end_macro

.macro PRINT_P1_DEFEATED() # printa o player 1 derrotado no chão
	mv a0,s1	# x do player 1
	beqz s6,RIGHT

LEFT:	PRINT_SPRITE(p1_1_defeat4, 30)
	j END
RIGHT:	PRINT_SPRITE(p1_0_defeat4, 30)
	j END
END:
.end_macro

.macro WALK_P1_DIR() # anda para a direita
	li t0,265
	bge s1,t0,LIMIT_P1_DIR	# x >= 265

	j MOVE_P1_DIR

LIMIT_P1_DIR:	li s1,272
				j CONT_WALK_P1_DIR
MOVE_P1_DIR:	addi s1,s1,8	# x += 8

CONT_WALK_P1_DIR:
	beqz s2,RIGHT	# orientacao = 0

LEFT:	
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2()
	mv a0,s1	# carrega o x atual
	addi a0,a0,4
	PRINT_SPRITE(p1_1_walking2, 30)
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
	PRINT_P2()
	mv a0,s1	# carrega o x atual
	addi a0,a0,-4
	PRINT_SPRITE(p1_0_walking2, 30)
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

.macro WALK_P1_ESQ() # anda para a esquerda
	mv t0,a0	# salva em t0 o x do player atual

	li t0,4
	blt s1,t0,LIMIT_P1_DIR	# x < 9

	j MOVE_P1_DIR

LIMIT_P1_DIR:	li s1,0
				j CONT_WALK_P1_DIR
MOVE_P1_DIR:	addi s1,s1,-8	# x -= 8

CONT_WALK_P1_DIR:
	beqz s2,RIGHT	# orientacao = 0

LEFT:
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s1	# carrega o x atual
	addi a0,a0,-2
	PRINT_SPRITE(p1_1_walking2, 30)
	PRINT_P2()
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
	mv a0,s1	# carrega o x atual
	addi a0,a0,4
	PRINT_SPRITE(p1_0_walking2, 30)
	PRINT_P2()
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

.macro PUNCH_P1() # chute
	beqz s2,T_RIGHT	# orientacao = 0
	j LEFT

T_RIGHT:
	la t0,RIGHT
	jr t0

LEFT:	PUNCH_P1_LEFT() # animacao de chute para a esquerda
	la t0,END
	jr t0
RIGHT:	PUNCH_P1_RIGHT() 	# animacao de chute para a direita

END:
.end_macro

.macro PUNCH_P1_RIGHT() # animacao de soco para a direita
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s1
	PRINT_SPRITE(p1_0_punch1, 30)
	PRINT_P2()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s1
	PRINT_SPRITE(p1_0_punch2, 30)
	PRINT_P2()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s1
	PRINT_SPRITE(p1_0_punch1, 30)
	PRINT_P2()
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

.macro PUNCH_P1_LEFT() # animacao de soco para a direita
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s1
	PRINT_SPRITE(p1_1_punch1, 30)
	PRINT_P2()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s1
	PRINT_SPRITE(p1_1_punch2, 30)
	PRINT_P2()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s1
	PRINT_SPRITE(p1_1_punch1, 30)
	PRINT_P2()
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

.macro KICK_P1_RIGHT() # animacao de chute para a direita
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s1
	PRINT_SPRITE(p1_0_kick1, 30)
	PRINT_P2()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s1
	PRINT_SPRITE(p1_0_kick2, 30)
	PRINT_P2()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s1
	PRINT_SPRITE(p1_0_kick1, 30)
	PRINT_P2()
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

.macro KICK_P1_LEFT() # animacao de chute para a esquerda
li t0,244
blt s1,t0,CONT_KICK_P1_LEFT	# x < 244

li s1,244

CONT_KICK_P1_LEFT:
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s1
	addi a0,a0,24
	PRINT_SPRITE(p1_1_kick1, 30)
	PRINT_P2()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s1
	addi a0,a0,4
	PRINT_SPRITE(p1_1_kick2, 30)
	PRINT_P2()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s1
	addi a0,a0,24
	PRINT_SPRITE(p1_1_kick1, 30)
	PRINT_P2()
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

.macro DEFEAT_P1() # animacao p1 caindo
	beqz s2,RIGHT	# orientacao = 0

LEFT:
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2()
	mv a0,s1
	PRINT_SPRITE(p1_1_defeat1, 30)
	li t0,0xFF200604	# escolhe o frame 0 ou 1
	sw s11,0(t0)		# troca de frame

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2()
	mv a0,s1
	PRINT_SPRITE(p1_1_defeat2, 30)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2()
	mv a0,s1
	PRINT_SPRITE(p1_1_defeat3, 30)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame
	
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2()
	PRINT_P1_DEFEATED()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	j END
RIGHT:
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2()
	mv a0,s1
	PRINT_SPRITE(p1_0_defeat1, 30)
	li t0,0xFF200604	# escolhe o frame 0 ou 1
	sw s11,0(t0)		# troca de frame

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2()
	mv a0,s1
	PRINT_SPRITE(p1_0_defeat2, 30)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2()
	mv a0,s1
	PRINT_SPRITE(p1_0_defeat3, 30)
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

.macro FINISH_P1() # animacao de finalizacao do player 1
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2_DEFEATED()
	mv a0,s1
	PRINT_SPRITE(p1_finish1, 30)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	SLEEP(500)

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2_DEFEATED()
	mv a0,s1
	PRINT_SPRITE(p1_finish2, 30)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	SLEEP(500)

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2_DEFEATED()
	mv a0,s1
	PRINT_SPRITE(p1_finish3, 30)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	SLEEP(500)

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2_DEFEATED()
	mv a0,s1
	PRINT_SPRITE(p1_finish4, 30)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	SLEEP(500)

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2_DEFEATED()
	mv a0,s1
	PRINT_SPRITE(p1_finish3, 30)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	PRINT_P2_DEFEATED()
	mv a0,s1
	PRINT_SPRITE(p1_finish3, 30)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	SLEEP(500)

	li s11,0		# retorna no frame 0
.end_macro

.macro JUMP_P1_LEFT() # animacao de pulo para a esquerda
	beqz s2,T_RIGHT	# orientacao = 0
	j LEFT

T_RIGHT:
	la t0,RIGHT
	jr t0

LEFT:	JUMP_P1_LEFT_1() # animacao de chute para a esquerda
	la t0,END
	jr t0
RIGHT:	JUMP_P1_LEFT_0() # animacao de chute para a esquerda

END:
.end_macro

.macro JUMP_P1_RIGHT() # animacao de pulo para a direita
	beqz s2,T_RIGHT	# orientacao = 0
	j LEFT

T_RIGHT:
	la t0,RIGHT
	jr t0

LEFT:	JUMP_P1_RIGHT_1() # animacao de chute para a direita
	la t0,END
	jr t0
RIGHT:	JUMP_P1_RIGHT_0() # animacao de chute para a direita

END:
.end_macro

.macro JUMP_P1_RIGHT_0() # animacao de chute para a direita
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	mv a0,s1
	PRINT_SPRITE(p1_0_jump1, 30)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	addi s1,s1,12
	VER_JUMP_RIGHT_P1()
	mv a0,s1
	PRINT_SPRITE(p1_0_jump6, 50)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo
	
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	addi s1,s1,12
	VER_JUMP_RIGHT_P1()
	mv a0,s1
	PRINT_SPRITE(p1_0_jump5, 80)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo
	
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	addi s1,s1,12
	VER_JUMP_RIGHT_P1()
	mv a0,s1
	PRINT_SPRITE(p1_0_jump4, 80)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo
	
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	addi s1,s1,12
	VER_JUMP_RIGHT_P1()
	mv a0,s1
	PRINT_SPRITE(p1_0_jump3, 80)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	addi s1,s1,12
	VER_JUMP_RIGHT_P1()
	mv a0,s1
	PRINT_SPRITE(p1_0_jump2, 50)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	mv a0,s1
	PRINT_SPRITE(p1_0_jump1, 30)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo

	# imprime o player em posicao de ataque nos dois frames
	VER_WALK_P1_RIGHT()
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame
	
	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	PRINT_P1()

	li s11,0		# retorna no frame 0
.end_macro

.macro JUMP_P1_RIGHT_1() # animacao de chute para a direita
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	mv a0,s1
	PRINT_SPRITE(p1_1_jump1, 30)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	addi s1,s1,12
	VER_JUMP_RIGHT_P1()
	mv a0,s1
	PRINT_SPRITE(p1_1_jump2, 50)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo
	
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	addi s1,s1,12
	VER_JUMP_RIGHT_P1()
	mv a0,s1
	PRINT_SPRITE(p1_1_jump3, 80)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo
	
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	addi s1,s1,12
	VER_JUMP_RIGHT_P1()
	mv a0,s1
	PRINT_SPRITE(p1_1_jump4, 80)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo
	
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	addi s1,s1,12
	VER_JUMP_RIGHT_P1()
	mv a0,s1
	PRINT_SPRITE(p1_1_jump5, 80)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	addi s1,s1,12
	VER_JUMP_RIGHT_P1()
	mv a0,s1
	PRINT_SPRITE(p1_1_jump6, 50)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	mv a0,s1
	PRINT_SPRITE(p1_1_jump1, 30)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo

	# imprime o player em posicao de ataque nos dois frames
	VER_WALK_P1_RIGHT()
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame
	
	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	PRINT_P1()

	li s11,0		# retorna no frame 0
.end_macro

.macro JUMP_P1_LEFT_0() # animacao de pulo para a esquerda
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	mv a0,s1
	PRINT_SPRITE(p1_0_jump1, 30)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	addi s1,s1,-12
	VER_JUMP_LEFT_P1()
	mv a0,s1
	PRINT_SPRITE(p1_0_jump2, 50)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo
	
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	addi s1,s1,-12
	VER_JUMP_LEFT_P1()
	mv a0,s1
	PRINT_SPRITE(p1_0_jump3, 80)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo
	
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	addi s1,s1,-12
	VER_JUMP_LEFT_P1()
	mv a0,s1
	PRINT_SPRITE(p1_0_jump4, 80)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo
	
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	addi s1,s1,-12
	VER_JUMP_LEFT_P1()
	mv a0,s1
	PRINT_SPRITE(p1_0_jump5, 80)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	addi s1,s1,-12
	VER_JUMP_LEFT_P1()
	mv a0,s1
	PRINT_SPRITE(p1_0_jump6, 50)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	mv a0,s1
	PRINT_SPRITE(p1_0_jump1, 30)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo

	# imprime o player em posicao de ataque nos dois frames
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame
	
	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	PRINT_P1()

	li s11,0		# retorna no frame 0
.end_macro

.macro JUMP_P1_LEFT_1() # animacao de pulo para a esquerda
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	mv a0,s1
	PRINT_SPRITE(p1_1_jump1, 30)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	addi s1,s1,-12
	VER_JUMP_LEFT_P1()
	mv a0,s1
	PRINT_SPRITE(p1_1_jump6, 50)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo
	
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	addi s1,s1,-12
	VER_JUMP_LEFT_P1()
	mv a0,s1
	PRINT_SPRITE(p1_1_jump5, 80)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo
	
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	addi s1,s1,-12
	VER_JUMP_LEFT_P1()
	mv a0,s1
	PRINT_SPRITE(p1_1_jump4, 80)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo
	
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	addi s1,s1,-12
	VER_JUMP_LEFT_P1()
	mv a0,s1
	PRINT_SPRITE(p1_1_jump3, 80)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	addi s1,s1,-12
	VER_JUMP_LEFT_P1()
	mv a0,s1
	PRINT_SPRITE(p1_1_jump2, 50)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	mv a0,s1
	PRINT_SPRITE(p1_1_jump1, 30)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo

	# imprime o player em posicao de ataque nos dois frames
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame
	
	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	PRINT_P1()

	li s11,0		# retorna no frame 0
.end_macro

.macro JUMP_P1_CENTER() # animacao de pulo para cima - centro
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	mv a0,s1
	PRINT_SPRITE(p1_0_jump1, 30)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	mv a0,s1
	PRINT_SPRITE(p1_0_jump2, 50)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo
	
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	mv a0,s1
	PRINT_SPRITE(p1_0_jump3, 80)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	mv a0,s1
	PRINT_SPRITE(p1_0_jump4, 80)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo
	
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	
	mv a0,s1
	PRINT_SPRITE(p1_0_jump5, 80)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	
	mv a0,s1
	PRINT_SPRITE(p1_0_jump6, 50)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	mv a0,s1
	PRINT_SPRITE(p1_0_jump1, 30)
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo

	# imprime o player em posicao de ataque nos dois frames
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	PRINT_P1()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame
	
	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()		# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL_JUMP()
	PRINT_P2()
	PRINT_P1()

	li s11,0		# retorna no frame 0
.end_macro

.macro ROLL_P1() # animacao de rolamento - judô
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s1
	PRINT_SPRITE(p1_0_jump6, 30)
	PRINT_P2()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s1
	PRINT_SPRITE(p1_0_jump5, 30)
	PRINT_P2()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo
	
	
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s1
	PRINT_SPRITE(p1_0_jump4, 30)
	PRINT_P2()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo
	
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s1
	PRINT_SPRITE(p1_0_jump3, 30)
	PRINT_P2()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo
	
	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s1
	PRINT_SPRITE(p1_0_jump2, 30)
	PRINT_P2()
	li t0,0xFF200604	# Escolhe o frame 0 ou 1
	sw s11,0(t0)		# Troca de frame

	ADD_FRAME_COUNTDOWN()	# contador de frames++
	VER_COUNTDOWN()			# atualiza tempo

	xori s11,s11,0x001	# inverte o frame atual
	CHANGE_BACKGROUND_PARTIAL()
	mv a0,s1
	PRINT_SPRITE(p1_0_jump1, 30)
	PRINT_P2()
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
