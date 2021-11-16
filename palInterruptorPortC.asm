;;  PRENDER Y APAGAR UN LED CONECTADO AL PUERTO B
;;  MEDIANTE UN INTERRPTOR EN EL PUERTO C
;;  Cdsm 02/05/201
;Palabra de configuración

__CONFIG _CONFIG1, _LVP_OFF & _FCMEN_ON & _IESO_OFF & _BOR_OFF & _CPD_OFF & _CP_OFF & _MCLRE_ON & _PWRTE_OFF & _WDT_OFF & _XT_OSC
__CONFIG _CONFIG2, _WRT_OFF & _BOR21V

;Libreria para el PIC16F887
LIST P=16f887
#include <p16f887.inc>

org 0h
goto INICIO
org 05h

INICIO 

bsf STATUS, RP0           ;BANK O TO BANK 1 
movlw  b'0000000'   
movwf TRISB
movlw b'11111111' 
movwf TRISC          
bcf STATUS, RP0 

CICLO
 
    btfsc PORTC,4   ; revisar estado del bit4 del puerto c
	goto APAGAR   
	bsf PORTB,7     ; ponemos a uno el bit7 del puertoB
	goto CICLO

APAGAR 
	bcf PORTB,7   ; apaga el bit7 del puerto B
	goto CICLO    

END







