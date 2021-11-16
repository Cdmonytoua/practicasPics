;; MOTOR 10 pasos
;;  Cdsm 21/05/2021
;Palabra de configuración

__CONFIG _CONFIG1, _LVP_OFF & _FCMEN_ON & _IESO_OFF & _BOR_OFF & _CPD_OFF & _CP_OFF & _MCLRE_ON & _PWRTE_OFF & _WDT_OFF & _XT_OSC
__CONFIG _CONFIG2, _WRT_OFF & _BOR21V

;Libreria para el PIC16F887
LIST P=16f887
#include <p16f887.inc>

cblock 0X1F
contador 
contador1
contador2
endc
	
Reset   org 0x00
        goto INICIO
        org 0x05
 
; PSEUDOCODIGO PARA LOS BANCOS 
INICIO 
	BSF STATUS, RP0
	MOVLW B'00000000'
	MOVWF TRISB
	BCF STATUS, RP0

PRINCIPAL

	movlw b'1000' ;1
	movwf PORTB
	call retardo_2s
	movlw b'0100' ;2
	movwf PORTB
	call retardo_2s
	movlw b'0010' ;3
	movwf PORTB
	call retardo_2s
	movlw b'0001'	;4
	movwf PORTB
	call retardo_2s
	movlw b'0010' ;5
	movwf PORTB
	call retardo_2s
	movlw b'0100' ;6
	movwf PORTB
	call retardo_2s
	movlw b'1000' ;7
	movwf PORTB
	call retardo_2s
	movlw b'0100'	;8
	movwf PORTB
	call retardo_2s
	movlw b'0010'	;9
	movwf PORTB
	call retardo_2s
	movlw b'0001'	;10
	movwf PORTB
	call retardo_2s
	movlw b'10000'	;Alarma sonora
	movwf PORTB
	call retardo_2s
	
GOTO PRINCIPAL 
 
retardo_2s
    movlw    10
    movwf    contador
    r_1s
    call    retardo_200ms
    decfsz    contador, F
    goto r_1s
    return
retardo_200ms
    movlw    d'200'    ;repetimos 200 veces el retardo de un 1 ms
    goto    retardo_ms
retardo_5ms
    movlw    d'5'
    goto    retardo_ms
retardo_1ms
    movlw    d'1'
    goto    retardo_ms
retardo_100ms
    movlw    d'100'
    goto    retardo_ms
retardo_50ms
    movlw    d'50'
    goto    retardo_ms
retardo_ms
    movwf    contador2
loop1
    movlw    d'249'    ;numero de iteraciones que necesitamos hacer para conseguir un tiempo aproximado de 1 ms
    movwf    contador1
loop2
    nop
    decfsz    contador1,F
    goto    loop2
    decfsz    contador2,F
    goto    loop1
    return
end