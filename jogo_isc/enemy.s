.macro dificuldade_1()
	blt s5,s1,T_P2_DIR 	
	la t0,P2_ESQ
	jr, t0
	
T_P2_DIR:
	la t0,P2_DIR
	jr, t0
P2_ESQ:	
	WALK_P2_ESQ()
	VER_DIST()	# a0 agora tem a distancia
	li t1, 35
	blt a0,t1,ATQ_L
	j P2_FIM
ATQ_L:	
	PUNCH_P2_LEFT()
	j P2_FIM
P2_DIR:	
	WALK_P2_DIR()
	VER_DIST()	# a0 agora tem a distancia
	li t1, 35
	blt a0,t1,ATQ_R
	j P2_FIM
	
ATQ_R:	
	PUNCH_P2_RIGHT()
	j P2_FIM
P2_FIM: 
.end_macro