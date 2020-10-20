.data


.text		
	li a7,5
	ecall
	mv t1,a0
			
LOOP:	li t2, 10
	rem a0, t1, t2  # resto de t1/t2 = a0
	mv t3, a0
	
	li a7,1   # print int
	ecall 
	
	div a0, t1, t2  # divisão de t1/t2 = a0
	mv t1, a0
	bge t2, t1, FINAL	
	j LOOP
	
	
FINAL: 
	li a7,1   # print int
	ecall 	
		
	li a7,10   # código serviço: Encerra programa
	ecall