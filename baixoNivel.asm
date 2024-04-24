.macro prtStr(%string)			# Macro para printar strings
	addi 	$sp, $sp, -8		# Abre dois espacos na pilha
	sw 	$v0, 0($sp)		# Guarda o valor que esta no registrador $v0 no topo da pilha
	sw 	$a0, 4($sp)		# Guarda o valor que esta no registrador $a0 na segunda posicao da pilha
	la 	$a0, %string		# Carrega o endereco da string em $a0
	li 	$v0, 4			# Carrega a instrucao 4 (print_string) em $v0
	syscall				# Chama o sistema para executar a instrucao
	lw 	$a0, 4($sp)		# Recupera o valor que esta na segunda posicao da pilha de volta ao $a0 
	lw 	$v0, 0($sp)		# Recupera o valor que esta no topo da pilha de volta ao $v0 
	addi 	$sp, $sp, 8		# Apaga o espaco aberto na pilha
.end_macro 

.macro leInt(%int)			# Macro para ler um valor inteiro
	addi	$sp, $sp, -4		# Abre espaco na pilha para um int
	sw	$v0, 0($sp)		# Coloca o que esta no registrador $v0 no topo da pilha
	li	$v0, 5			# Carrega a instrucao 5 (read_int) em $v0
	syscall				# Chama o sistema para executar a instrucao
	move 	%int, $v0		# Move o valor de $v0 para o destino %int
	lw 	$v0, 0($sp)		# Recupera o valor que esta no topo da pilha de volta ao $v0 
	addi 	$sp, $sp, 4		# Apaga o espaco aberto na pilha
.end_macro

.macro prtInt(%inteiro)		# Macro para printar um valor inteiro			
	addi	$sp, $sp, -8		# Abre dois espacos na pilha
	sw	$v0, 0($sp)		# Guarda o valor que esta no registrador $v0 no topo da pilha
	sw	$a0, 4($sp)		# Guarda o valor que esta no registrador $a0 na segunda posicao da pilha
	lw	$a0, %inteiro		# Carrega o endereco do inteiro em $a0
	li	$v0, 1			# Carrega a instrucao 1 (print_int) em $v0
	syscall				# Chama o sistema para executar a instrucao
	lw	$a0, 4($sp)		# Recupera o valor que esta na segunda posicao da pilha de volta ao $a0 
	lw	$v0, 0($sp)		# Recupera o valor que esta no topo da pilha de volta ao $v0
	addi	$sp, $sp, 8		# Apaga o espaco aberto na pilha
.end_macro 
		
.macro callRaiz()			# Macro para chamar a funcao raiz
	addi	$sp, $sp, -12		# Abre tres espacos na pilha
	sw	$a0, 8($sp)		# Guarda o valor que esta no registrador $a0 (x) na terceira posicao da pilha
	sw	$a1, 4($sp)		# Guarda o valor que esta no registrador $a1 (i) na segunda posicao da pilha
	sw	$ra, 0($sp)		# Guarda o valor que esta no registrador $r0 no topo da pilha		
	jal	raiz			# Vai para raiz
	lw	$ra, 0($sp)		# Recupera o valor que esta no topo da pilha de volta ao $ra
	lw	$a1, 4($sp)		# Recupera o valor que esta na segunda posicao da pilha de volta ao $a1
	lw	$a0, 8($sp)		# Recupera o valor que esta na terceira posicao da pilha de volta ao $a0
	addi	$sp, $sp, 12		# Apaga o espaco aberto na pilha
.end_macro 

.macro resultado()			# Macro para printar o resultado
	sw	$v0, result		# Salva em result o valor lido em $v0
	prtStr(strRaizI)		# Print("sqrt("
	prtInt(x)			# Print("sqrt(" + x
	prtStr(strVirg)			# Print("sqrt(" + x + ", "
	prtInt(i)			# Print("sqrt(" + x + ", " + i
	prtStr(strRaizF)		# Print("sqrt(" + x + ", " + i + ") = "
	prtInt(result)			# Print("sqrt(" + x + ", " + i + ") = " + result);
.end_macro 

.macro exit()				# Macro para sair do programa
	li	$v0, 10			# Carrega a instrucao 10 (exit) em $v0
 	syscall				# Chama o sistema para executar a instrucao
.end_macro

.data
x: .space 4 
i: .space 4
result: .space 4
strProgm: .asciiz "\nPrograma de Raiz - Newton-Raphson\nDesenvolvedoras: Eduarda Patricio, Giovanna Castro, Naiumy dos Reis e Yasmin Aguirre"
strDigite: .asciiz "\n\nDigite os parametros x e i para calcular sqrt_nr(x, i) ou -1 para abortar a execucao\nDigite o parametro x: "
strPrmI: .asciiz "Digite o parametro i: "
strRaizI: .asciiz "sqrt("
strVirg: .asciiz ", "
strRaizF: .asciiz ") = "

.text
	.globl main
main:
	prtStr(strProgm)		# Usa o macro prtStr para printar a string de strProgm
loop:
	prtStr(strDigite)		# Usa o macro prtStr para printar a string de strDigite
	leInt($a0)			# Usa o macro leInt para ler o valor inteiro de $a0
	sw	$a0, x			# Salva em x o valor lido em $a0
	blt $a0, $zero, fim		# Verifica se a entrada e negativa (x < 0)
	prtStr(strPrmI)			# Usa o macro prtStr para printar a string de strPrmI
	leInt($a1)			# Usa o macro leInt para ler o valor inteiro de $a1
	sw	$a1, i			# Salva em i o valor lido em $a1
	blt $a1, $zero, fim		# Verifica se a entrada e negativa (i < 0)
	callRaiz()			# Chama o macro que faz a funcao de raiz quadrada
	resultado()			# Chama o macro que imprime o resultado
	jal loop			# Repete o programa enquanto a entrada for positiva
fim:
	exit()				# Chama o macro que encerra o programa

raiz:				
	lw	$a1, 4($sp)		# Carrega o valor de $a1 em i
	lw	$a0, 8($sp)		# Carrega o valor de $a0 em x
	bgt	$a1, $zero, recurs	# Se (i > 0), vai para "recurs"
	li	$v0, 1			# Define o resultado como 1 se (i == 0)
	jr	$ra			# Volta para o macro callRaiz()
recurs:	
	addiu	$a1, $a1, -1		# Decrementa i (i--)
	callRaiz()			# Chama o macro que faz a funcao de raiz quadrada de novo
	addiu	$a1, $a1, 1		# Restaura o valor de i (i++)
	div	$t0, $a0, $v0		# x / sqrt_nr(x, i - 1)
	add	$v0, $v0, $t0		# sqrt_nr(x, i - 1) + (x / sqrt_nr(x, i - 1)
	srl	$v0, $v0, 1		# (sqrt_nr(x, i - 1) + (x / sqrt_nr(x, i - 1))) / 2
	jr	$ra			# Volta para raiz
