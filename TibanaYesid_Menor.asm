# Programa para encontrar el número menor entre varios números.
# Archivo: TibanaYesid_Menor.asm

.data
    mensaje1: .asciiz "¿Cuántos números desea comparar? (min: 3, max: 5): "
    mensaje2: .asciiz "Ingrese un número: "
    resultado:  .asciiz "El menor número es: "
    newline: .asciiz "\n"

.text
.globl main

main:
    # Pregunta cuántos números desea comparar
    li $v0, 4              # syscall para imprimir cadena
    la $a0, mensaje1         # cargar el mensaje de prompt1
    syscall
    
    # Leer el número de números a comparar (mínimo 3 y máximo 5)
    li $v0, 5              # syscall para leer entero
    syscall
    move $t0, $v0          # almacenar el número ingresado en $t0 (cantidad de números a comparar)
    
    # Validar que el número esté en el rango de 3 a 5
    li $t1, 3              # mínimo 3 números
    li $t2, 5              # máximo 5 números
    blt $t0, $t1, exit     # si $t0 < 3, salir
    bgt $t0, $t2, exit     # si $t0 > 5, salir

    # Inicialización de variables
    li $t3, 2147483647     # $t3 será el menor número, lo inicializamos con el mayor valor posible
    
    # Bucle para leer los números y determinar el menor
    li $t4, 0              # contador de iteraciones
    
compare_loop:
    li $v0, 4              # syscall para imprimir cadena
    la $a0, mensaje2         # cargar el mensaje de prompt2
    syscall
    
    li $v0, 5              # syscall para leer entero
    syscall
    move $t5, $v0          # almacenar el número leído en $t5
    
    # Comparar el número leído con el menor número actual
    blt $t5, $t3, update_min  # si $t5 < $t3, actualiza el menor número
    b continue              # si no, continúa
    
update_min:
    move $t3, $t5           # actualizar el menor número con $t5

continue:
    addi $t4, $t4, 1        # incrementar el contador de iteraciones
    bne $t4, $t0, compare_loop  # si $t4 != $t0, continúa en el bucle

    # Imprimir el menor número
    li $v0, 4              # syscall para imprimir cadena
    la $a0, resultado          # cargar el mensaje de resultado
    syscall
    
    li $v0, 1              # syscall para imprimir entero
    move $a0, $t3          # cargar el menor número en $a0
    syscall
    
    # Imprimir nueva línea
    li $v0, 4
    la $a0, newline
    syscall
    
exit:
    li $v0, 10             # syscall para salir del programa
    syscall
