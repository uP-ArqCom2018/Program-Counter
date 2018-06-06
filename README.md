# Arquitectura de Computadoras 2018
## Integrantes
Gonzalez, Roberto
Francalancia, Mariano

## Descripcion de Program Counter
 El modulo tiene como objeto el conteo de la posicion de la variable denominada PC, encargada de almacenar la direccion de memoria del bloque de **Memoria de Instruccion**.
 Al ser direccccionamiento a Byte, las direcciones se incerementan en 4 valores si no ocurre un salto condicional, caso contrario al valor de PC se le suma la direccion de salto condicional.
## El modulo PC consta las siguientes entradas y salidas:

 * DATA_i (64 bits) No disponible en el bloque master
 * DATA_o (64 bits) Conectado al **Bloque de Registros** indicando la dreccion de salto o instruccion siguiente
 * CLOCK_i (1 bit) Señal de **Clock**
 * ZERO_i (1 bit) Señal obtenida de la **ALU**
 * IMGEN_i (64 bits) Señales obtenidas del bloque **IMMGEN** de la **Banco de Registros**
 * INCOND_i (1 bit) Señal **Salto incondicional** obteniad de la **Unidad de Control**
 * COND_i (1 bit) Señal **Salto Condicional** obtenida de la **Unidad de Control**
 * RESET_i (1 bit) Señal de Reset Asincronico que lleva al el valor DATA_o del PC a 0. Su fincion es Resetear el uP. 
 
 ## Comportamiento del Bloque
 Para llevar a cabo el incremeto del valor del contador , se utiliza dos sumadores, cada una para los tipos de salto. En caso de instruccion condicional, data_in depende de el resultado de la condicion **Zero**  de la ALU,  seguido del control a travez del bit de control INCOND, COND.
 En caso de Salto incondicional, el valor de Pc se incrementa en 4.
