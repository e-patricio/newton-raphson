.macro prtStr(%string)				#macro para printar strings
	addi 	$sp, $sp, -8			#abrindo espa�o na pilha para dois registradores 
	sw 	$v0, 0($sp)			#colocando o que esta no registrador v0 no inicio da pilha
	sw 	$a0, 4($sp)			#colocando o que esta no registrador a0 no fim da pilha
	
	la 	$a0, %string			#carregando o endere�o da variavel string para  a0
	li 	$v0, 4 				#carrega a instru��o 4 para v0
	syscall					#chama o SO para executar a opera��o 4 (q ta em v0). 4 imprime strings
	
	lw 	$a0, 4($sp)			#carregando valor que esta no fim da pilha de volta ao a0 
	lw 	$v0, 0($sp)			#carregando o valor que esta no inicio da pilha de volta ao v0 
	addi 	$sp, $sp, 8			#apagando o espa�o aberto na pilha
.end_macro 

.macro leInt(%int)				#macro para ler um valor inteiro
	addi	$sp, $sp, -4			#abrindo espa�o na pilha para um int
	sw	$v0, 0($sp)			#colocando o que esta no registrador v0 no inicio da pilha
	
	li	$v0, 5				#carrega a instru��o 5 para v0
	syscall					#chama o SO para executar a opera��o 5 (q ta em v0). 5 l� inteiros
	move 	%int, $v0			#move o valor de v0 para o destino %int
	
	lw 	$v0, 0($sp)			#carregando o valor que esta no inicio da pilha de volta ao v0 
	addi 	$sp, $sp, 4			#apaga o espa�o aberto na pilha
.end_macro

.macro prtInt(%inteiro)
	addi	$sp, $sp, -8
	sw	$v0, 0($sp)	
	sw	$a0, 4($sp)	
	
	lw	$a0, %inteiro
	li	$v0, 1
	syscall
	
	lw	$a0, 4($sp)	
	lw	$v0, 0($sp)	
	addi	$sp, $sp, 8
.end_macro
		
.macro callRaiz()
	addi	$sp, $sp, -12
	sw	$a0, 8($sp)
	sw	$a1, 4($sp)	
	sw	$ra, 0($sp)
		
	jal	raiz	
			
	lw	$ra, 0($sp)	
	lw	$a1, 4($sp)
	lw	$a0, 8($sp)
	addi	$sp, $sp, 12
.end_macro

.macro exit()
	li	$v0, 10
 	syscall
.end_macro 

.macro resultado()
	sw	$v0, result	
	prtStr(strRaizI)			#println("sqrt("
	prtInt(x)				#println("sqrt("+x
	prtStr(strVirg)				#println("sqrt("+x+","
	prtInt(i)				#println("sqrt("+x+","+i
	prtStr(strRaizF)			#println("sqrt("+x+","+i+") = "
	prtInt(result)				#println("sqrt("+x+","+i+") = " + a);
.end_macro 

.data
x: .space 4 
i: .space 4
result: .space 4
strProgm: .asciiz "\nPrograma de Raiz - Newton-Raphson\nDesenvolvedoras: Eduarda Patricio, Giovanna Castro, Naiumy dos Reis e Yasmin Aguirre"
strDigite: .asciiz "\nDigite os par�metros x e i para calcular sqrt_nr(x, i) ou -1 para abortar a execu��o!"
strPrmX: .asciiz "\nDigite o par�metro x\n"
strPrmI: .asciiz "\nDigite o par�metro i\n"
strRaizI: .asciiz "\n sqrt("
strVirg: .asciiz ", "
strRaizF: .asciiz ") = "

.text
	.globl main
main:
	prtStr(strProgm) 			#usa o macro prtStr para printar a string de strProgm
loop:
	prtStr(strDigite)			#usa o macro prtStr para printar a string de strDigite
	prtStr(strPrmX)				#usa o macro prtStr para printar a string de strPrmX
	leInt($a0)				#usa o macro leInt para ler um valor inteiro
	sw	$a0, x				#armazena em x o numero lido em a0
	blt $a0, $zero, fim
	prtStr(strPrmI)				#usa o macro prtStr para printar a string de strPrmI
	leInt($a1)				#usa o macro leInt para ler um valor inteiro
	sw	$a1, i				#armazena em x o numero lido em a1
	blt $a1, $zero, fim
	callRaiz()				#Chama o macro que chama a função
	resultado()
	jal loop
fim:
	exit()					#}

raiz:				
	lw	$a1, 4($sp)			#i
	lw	$a0, 8($sp)			#x
	bgt	$a1, 0, recurs			#if(i > 0) 
	li	$v0, 1				#if(i == 0){result = 1;}
	jr	$ra				#Volta
recurs:	
	addiu	$a1, $a1, -1			#i-1
	callRaiz()	 			#Chama de novo
	addiu	$a1, $a1, 1			#Volta o i
	div	$t0, $a0, $v0			#x/sqrt_nr(x, i-1)
	add	$t1, $t0, $v0			#sqrt_nr(x, i-1) + (x/sqrt_nr(x, i-1)
	li	$t2, 2				#2
	div	$v0, $t1, $t2			#(sqrt_nr(x, i-1) + (x/sqrt_nr(x, i-1)))/2;
	jr	$ra				#Volta para raiz