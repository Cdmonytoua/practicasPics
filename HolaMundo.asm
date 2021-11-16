;; MOSTRAR EN UN LCD EL MESANJE “HOLA MUNDO” una palabra en cada renglón
;;  Cdsm 15/05/2021
;Palabra de configuración

__CONFIG _CONFIG1, _LVP_OFF & _FCMEN_ON & _IESO_OFF & _BOR_OFF & _CPD_OFF & _CP_OFF & _MCLRE_ON & _PWRTE_OFF & _WDT_OFF & _XT_OSC
__CONFIG _CONFIG2, _WRT_OFF & _BOR21V

;Libreria para el PIC16F887
LIST P=16f887
#include <p16f887.inc>

Reset	org	0x00		
goto	Inicio		

CBLOCK	0x25
T_Enc_Led
T_Conta1
T_Conta2	
ENDC
			
Inicio	
		bsf	STATUS,RP0 	
		movlw	b'00000'	
		movwf	TRISD		
		movlw	b'00000000'	
		movwf	TRISB
		bcf	STATUS,RP0
		clrf	PORTD
		clrf 	PORTB
		BCF STATUS, RP0 

InicializacionLCD
		call 	LCD_Input
		call	Renglon1
		call 	Siguiente
		call 	Renglon2
		call    Retardo
		call    Retardo
		call    Retardo
		call    Retardo
		call    Retardo
		goto	InicializacionLCD

LCD_Input
		bcf	PORTD,2		;o en donde esté conectado Rs
		movlw	b'00000001'	;Limpia LCD
		movwf	PORTB
		call	Enable		; HABILITACION + RETARDO
		movlw	b'00001100'	; POSICION 0 EN EL RENGLON 0
		movwf	PORTB
		call	Enable		;Configuracion del Cursor
		movlw	b'00111100'
		movwf	PORTB
		call	Enable
		bsf	PORTD,2		;o en donde esté conectado Rs
		return

Enable
		bsf	PORTD,3		;o en donde esté conectado Enable
		call	Retardo
		call 	Retardo
		bcf	PORTD,3
		call	Retardo
		return

Imprime
		bsf	PORTD,2
		call	Enable
		return
Siguiente
		bcf	PORTD,2		;o en donde esté conectado Rs
		movlw	b'11000000'; 	nos envía al renglon 2
		movwf	PORTB
		call 	Enable
		return

; Texto en Rengon 1
Renglon1
		movlw	b'00100000'
		movwf	PORTB
		call	Imprime
		movlw	b'00100000'
		movwf	PORTB
		call	Imprime
		movlw	b'00100000'
		movwf	PORTB
		call	Imprime
		movlw	b'00100000'
		movwf	PORTB
		call	Imprime
		movlw	b'00100000'
		movwf	PORTB
		call	Imprime
		movlw	b'00100000'
		movwf	PORTB
		call	Imprime	
		movlw	'H'
		movwf	PORTB
		call	Imprime
		movlw	'O'
		movwf	PORTB
		call	Imprime
		movlw	'L'
		movwf	PORTB
		call	Imprime
		movlw	'A'
		movwf	PORTB
		call	Imprime
	
       
		return
Renglon2

		movlw	b'00100000'
		movwf	PORTB
		call	Imprime
		movlw	b'00100000'
		movwf	PORTB
		call	Imprime
		movlw	b'00100000'
		movwf	PORTB
		call	Imprime
		movlw	b'00100000'
		movwf	PORTB

		call	Imprime
		movlw	'M'
		movwf	PORTB
		call	Imprime
		movlw	'U'
		movwf	PORTB
		call	Imprime
		movlw	'N'
		movwf	PORTB
		call	Imprime
		movlw	'D'
		movwf	PORTB
		call	Imprime
		movlw	'O'
		movwf	PORTB
		call	Imprime
		movlw	b'00100000'
		movwf	PORTB
		call  Imprime
		movlw	':'
		movwf	PORTB
		call	Imprime
		movlw	')'
		movwf	PORTB
		call	Imprime
		
Retardo		
		movlw D'48' 
		movwf T_Conta2; M
		movlw D'255' 
		movwf T_Conta1 ;N
		decfsz T_Conta1
		goto $-1
		decfsz T_Conta2
		goto $-5
		return

end