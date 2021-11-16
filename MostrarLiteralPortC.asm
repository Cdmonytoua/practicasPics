;;PRENDER Y APAGAR UN LED CONECTADO AL PUERTO B 
;;MEDIANTE UN INTERRUPTOR CONECTADO EN EL PUERTO C
;;cdsm 02/05/21
__CONFIG  _LVP_OFF & _CPD_OFF & _CP_OFF & _PWRTE_OFF & _WDT_OFF & _XT_OSC & _BOREN_OFF & _WRT_OFF

;Libreria para el PIC16F877
LIST P=16f877a
#include <p16f877a.inc>

;; Estructura 
ORG 0x00 ; Vector de reset

goto Main ;
ORG 0x04 ; Vector de interrupción

Main ;
banksel TRISC ; cambiamos de banco del 0 al 1
clrf TRISC ; Habilitamos el puerto B como salida
banksel PORTC ; cambiamos del banco 1 al 0

Loop
movlw b'00000001' ; Movemos una literal al registro W
movwf PORTC ; El valor del registro W se mueve al puerto B
goto Loop ; Se repite
End

