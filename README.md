# Arquitectura de Computadoras 2018
## Integrantes
Gonzalez, Roberto
Francalancia, Mariano

## Descripcion de Program Counter
 El modulo tiene como objeto el conteo de la posicion de la variable denominada PC, encargada de almacenar la direccion de memoria del bloque de **Memoria de Instruccion**.
 Al ser direccccionamiento a Byte, las direcciones se incerementan en 4 valores si no ocurre un salto condicional, caso contrario al valor de PC se le suma la direccion de salto condicional.
## El modulo PC consta las siguientes entradas y salidas:

 * Data_in (64 bits)
 * Clock_in (1 bit)
 * Data_out (64 bits)
 
 ## Comportamiento del Bloque
 Para llevar a cabo el incremeto del valor del contador , se utiliza dos sumadores, cada una para los tipos de salto. En caso de instruccion condicional, data_in depende de el resultado de la condicion **Zero**  de la ALU.
 En caso de Salto incondicional, el valor de Pc se incrementa en 4.
