.macro prtStr(%string)				#macro para printar strings
	addi 	$sp, $sp, -8			#abrindo espaço na pilha para dois registradores 
	sw 	$v0, 0($sp)			#colocando o que esta no registrador v0 no inicio da pilha
	sw 	$a0, 4($sp)			#colocando o que esta no registrador a0 no fim da pilha
	
	la $a0, %string				#carregando o endereço da variavel string para  a0
	li $v0, 4 				#carrega a instrução 4 para v0
	syscall					#chama o SO para executar a operação 4 (q ta em v0). 4 imprime strings
	
	lw 	$a0, 4($sp)			#carregando valor que esta no fim da pilha de volta ao a0 
	lw 	$v0, 0($sp)			#carregando o valor que esta no inicio da pilha de volta ao v0 
	addi 	$sp, $sp, 8			#apagando o espaço aberto na pilha
.end_macro 

.macro leInt(%int)				#macro para ler um valor inteiro
	addi	$sp, $sp, -4			#abrindo espaço na pilha para um int
	sw	$v0, 0($sp)			#colocando o que esta no registrador v0 no inicio da pilha
	
	li	$v0, 5				#carrega a instrução 5 para v0
	syscall					#chama o SO para executar a operação 5 (q ta em v0). 5 lê inteiros
	move %int, $v0				#move o valor de v0 para o destino %int
	
	lw $v0, 0($sp)				#carregando o valor que esta no inicio da pilha de volta ao v0 
	addi $sp, $sp, 4			#apaga o espaço aberto na pilha
.end_macro
		
		


.data
x: .space 4 
i: .space 4
strProgm: .asciiz "\nPrograma de Raiz - Newton-Raphson\nDesenvolvedoras: Eduarda Patricio, Giovanna Castro, Naiumy dos Reis e Yasmin Aguirre"
strDigite: .asciiz "\nDigite os parâmetros x e i para calcular sqrt_nr(x, i) ou -1 para abortar a execução!"
strPrmX: .asciiz "\nDigite o parâmetro x\n"
strPrmI: .asciiz "\nDigite o parâmetro i\n"

.text
	.globl main
main:
	prtStr(strProgm) 			#usa o macro prtStr para printar a string de strProgm
	prtStr(strDigite)			#usa o macro prtStr para printar a string de strDigite
	prtStr(strPrmX)				#usa o macro prtStr para printar a string de strPrmX
	leInt($a0)				#usa o macro leInt para ler um valor inteiro
	sw	$a0, x				#armazena em x o numero lido em a0
	prtStr(strPrmI)				#usa o macro prtStr para printar a string de strPrmI
	leInt($a1)				#usa o macro leInt para ler um valor inteiro
	sw	$a1, i				#armazena em x o numero lido em a1
	

