.data

DOBRO:.string "Dobro:"
METADE: .string "Metade:"
PULA: .string "\n"

.text		
	li a7,5
	ecall
	mv t1,a0

	la a0,DOBRO
	li a7,4
	ecall
			
	li t2, 2
	mul a0, t1, t2
	li a7,1
	ecall
	
	la a0, PULA
	li a7,4
	ecall
	
	la a0, METADE
	li a7,4     # print string
	ecall
		
	li t2, 2
	div a0, t1, t2
	li a7,1   # print int
	ecall 	
		
	li a7,10   # código serviço: Encerra programa
	ecall