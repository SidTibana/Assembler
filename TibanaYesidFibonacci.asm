# Programa para generar la serie de Fibonacci y sumar los números de la serie.
# Archivo: TibanaYesidFibonacci.asm

.data
    mensaje1: .asciiz "¿Cuántos números de la serie Fibonacci desea generar?: "
    resultado:  .asciiz "La serie Fibonacci es: "
    sum_msg: .asciiz "La suma de los números de la serie es: "
    comma:   .asciiz ", "
    newline: .asciiz "\n"

.text
.globl main

main:
    # Pedir al usuario cuántos números de la serie Fibonacci desea generar
    li $v0, 4               # syscall para imprimir cadena
    la $a0, mensaje1          # cargar el mensaje de prompt1
    syscall
    
    # Leer la cantidad de números a generar
    li $v0, 5               # syscall para leer entero
    syscall
    move $t0, $v0           # almacenar el número ingresado en $t0 (cantidad de números a generar)
    
    # Inicialización de variables
    li $t1, 0               # primer número de Fibonacci (F0)
    li $t2, 1               # segundo número de Fibonacci (F1)
    li $t3, 0               # suma total de la serie
    li $t4, 0               # contador de iteraciones
    
    # Imprimir la serie de Fibonacci
    li $v0, 4               # syscall para imprimir cadena
    la $a0, resultado           # cargar el mensaje de resultado
    syscall

fibonacci_loop:
    # Imprimir el número actual de la serie (F0 o F1)
    move $a0, $t1           # cargar el valor de $t1 en $a0 para imprimirlo
    li $v0, 1               # syscall para imprimir entero
    syscall
    
    # Sumar el número actual a la suma total
    add $t3, $t3, $t1
    
    # Imprimir una coma si no es el último número de la serie
    addi $t4, $t4, 1
    bge $t4, $t0, done      # si hemos impreso todos los números, salir del bucle
    
    li $v0, 4               # syscall para imprimir cadena
    la $a0, comma            # cargar el mensaje de la coma
    syscall
    
    # Calcular el siguiente número de Fibonacci
    move $t5, $t2           # almacenar $t2 temporalmente
    add $t2, $t1, $t2       # calcular el siguiente Fibonacci: $t2 = $t1 + $t2
    move $t1, $t5           # actualizar $t1 con el valor anterior de $t2
    
    # Continuar con el bucle
    b fibonacci_loop

done:
    # Imprimir nueva línea después de la serie
    li $v0, 4
    la $a0, newline
    syscall
    
    # Imprimir la suma total de la serie
    li $v0, 4               # syscall para imprimir cadena
    la $a0, sum_msg          # cargar el mensaje de suma
    syscall
    
    # Imprimir la suma de los números de la serie
    move $a0, $t3           # cargar la suma total en $a0
    li $v0, 1               # syscall para imprimir entero
    syscall
    
    # Imprimir nueva línea después de la suma
    li $v0, 4
    la $a0, newline
    syscall
    
    # Salir del programa
    li $v0, 10              # syscall para salir
    syscall
