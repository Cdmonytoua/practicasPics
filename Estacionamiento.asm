;; DISEÑAR UN SCRIPT PARA UN ESTACIONAMIENTO DE 12 LUGARES, 
;; EL CUAL DEBE MOSTRAR UN MENSAJE DE LLENO, CON LUGARES  Y VACÍO
;;  Cdsm 27/05/2021
;Palabra de configuración

__CONFIG _CONFIG1, _LVP_OFF & _FCMEN_ON & _IESO_OFF & _BOR_OFF & _CPD_OFF & _CP_OFF & _MCLRE_ON & _PWRTE_OFF & _WDT_OFF & _XT_OSC
__CONFIG _CONFIG2, _WRT_OFF & _BOR21V

;Libreria para el PIC16F887
LIST P=16f887
#include <p16f887.inc>

ESPACIOS	equ	0x30
CARS	equ	0x31
Decenas	equ	0x32
Unidades	equ	0x33
DecenasA	equ	0x34
UnidadesA	equ	0x35
Centenas	equ	0x42
CentenasA	equ	0x43
Resto	equ	0x36
RestoA	equ	0x37
var2	equ	0x38
var3	equ	0x39
var4	equ	0x40
var1	equ	0x41


Reset	org 0x00
		goto Inicio
		org 0x05

Inicio
	bsf STATUS,RP0
	movlw b'00000000'
	movwf TRISB
	movlw b'00111111'
	movwf TRISD
	movlw b'00001111'
    movwf TRISC
	bcf STATUS,RP0

	call Retardoinicio
	call Retardoinicio	
	
	bcf PORTD,6 ;Rs=0
	movlw b'00111100' ;FUNCITION SET
	movwf PORTD 
	bsf PORTD,7 ;E=1
	call Retardo
	call Retardo
	bcf PORTD,7 ;E=0
	call Retardo
	movlw	d'12'
	movwf	ESPACIOS
	movlw	d'00'
	movwf	CARS
	goto	Encendido


Encendido

LCDCleanINICIO
	bcf PORTD,6 ;Rs=0
	movlw b'00000001' ;clean LCD
	movwf PORTB 
	bsf PORTD,7 ;E=1
	call Retardo
	call Retardo
	bcf PORTD,7 ;E=0
	call Retardo

LCDInicializacion
	bcf PORTD,6 ;Rs=0
	movlw b'00000010' ;HOME, POSICION 0 LINEA 1, DISPLAY EN 0
	movwf PORTB
	bsf PORTD,7 ;E=1
	call Retardo
	call Retardo
	bcf PORTD,7 ;E=0
	call Retardo
	bcf PORTD,6 ;Rs=0

LCDInicializacion2
	bcf PORTD,6 ;Rs=0
	movlw b'00001100' ;DISPLAY CONTROL
	movwf PORTB
	bsf PORTD,7 ;E=1
	call Retardo
	call Retardo
	bcf PORTD,7 ;E=0
	call Retardo
	bsf PORTD,6 ;Rs=1


MOSTRARINICIO
	call COMPARAR

PUSHBUTTON
	call Retardoinicio 
	btfsc PORTC,1
	goto INCREMENTO
	call Retardoinicio
	btfsc PORTC,3
	goto DECREMENTO	
    goto PUSHBUTTON	

INCREMENTO 
	call Segundo
    incf ESPACIOS
	decf CARS		
	call COMPARAR

DECREMENTO 
	call Segundo
    decf ESPACIOS
	incf CARS			
	call COMPARAR

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DESCOMPONER
	CLRF	W
	CLRF	Decenas
	CLRF	Unidades
	CLRF	Resto
	MOVF	ESPACIOS,W
	movwf	Resto
CENTENAS
       movlw d'100'      ;W=d'100'
       subwf Resto,W     ;Resto - d'100' (W)
       btfss STATUS,C    ;Resto menor que d'100'?
       goto DECENAS     ;SI
       movwf Resto       ;NO, Salva el resto
       incf Centenas,1   ;Incrementa el contador de centenas BCD
       goto CENTENAS    ;Realiza otra resta
DECENAS
	movlw d'10'       ;W=d'10'
	subwf Resto,W     ;Resto - d'10' (W)
	btfss STATUS,C    ;Resto menor que d'10'?
	goto UNIDADES    ;Si
	movwf Resto       ;No, Salva el resto
	incf Decenas,1    ;Incrementa el contador de centenas BCD
	goto DECENAS     ;Realiza otra resta
UNIDADES
	movf Resto,W      ;El resto son la Unidades BCD
	movwf Unidades
OBTEN_ASCII				 ;Rutina que obtiene el equivalente en ASCII
       movlw D'48'
       iorwf Unidades,f      
       iorwf Decenas,f
	return     


DESCOMPONERA
	CLRF	W
	CLRF	DecenasA
	CLRF	UnidadesA
	CLRF	RestoA
	MOVF	CARS,W
	movwf	RestoA
CENTENASA
       movlw d'100'      ;W=d'100'
       subwf RestoA,W     ;Resto - d'100' (W)
       btfss STATUS,C    ;Resto menor que d'100'?
       goto DECENASA     ;SI
       movwf RestoA       ;NO, Salva el resto
       incf CentenasA,1   ;Incrementa el contador de centenas BCD
       goto CENTENASA    ;Realiza otra resta
DECENASA
	movlw d'10'       ;W=d'10'
	subwf RestoA,W     ;Resto - d'10' (W)
	btfss STATUS,C    ;Resto menor que d'10'?
	goto UNIDADESA    ;Si
	movwf RestoA       ;No, Salva el resto
	incf DecenasA,1    ;Incrementa el contador de centenas BCD
	goto DECENASA     ;Realiza otra resta
UNIDADESA
	movf RestoA,W      ;El resto son la Unidades BCD
	movwf UnidadesA
OBTEN_ASCIIA				 ;Rutina que obtiene el equivalente en ASCII
       movlw D'48'
       iorwf UnidadesA,f      
       iorwf DecenasA,f 
	RETURN 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

COMPARAR
	movlw d'12'
	subwf ESPACIOS,W
	btfss STATUS,C
	call COMPARAR2
	movlw	d'12'
	movwf	ESPACIOS
	movlw	d'00'
	movwf	CARS
	call DESCOMPONER
	call DESCOMPONERA
	goto MOSTRARDISPONIBLE
COMPARAR2
	movlw d'0'
	subwf ESPACIOS,W
	btfss STATUS,Z
	goto COMPARAR3
	movlw	d'00'
	movwf	ESPACIOS
	movlw	d'12'
	movwf	CARS
	call DESCOMPONER
	call DESCOMPONERA
	goto MOSTRARLLENO
COMPARAR3
	call DESCOMPONER
	call DESCOMPONERA
	goto MOSTRARDISPONIBLE
	


MOSTRARLLENO
	call LCDClean 
	call LCDhome
	
	movlw " "
	movwf PORTB
	call DATO
	movlw "F"
	movwf PORTB
	call DATO
	movlw "U"
	movwf PORTB
	call DATO
	movlw "L"
	movwf PORTB
	call DATO
	movlw "L"
	movwf PORTB
	call DATO
	movlw " "
	movwf PORTB
	call DATO
	movlw " "
	movwf PORTB
	call DATO
	movlw " "
	movwf PORTB
	call DATO
	movwf PORTB
	call DATO	
	movf DecenasA,W
	movwf PORTB
	call DATO
	movf UnidadesA,W
	movwf PORTB
	call DATO
	goto PUSHBUTTON

MOSTRARDISPONIBLE	
	call LCDClean 
	call LCDhome
	
	movlw "A"
	movwf PORTB
	call DATO
	movlw "U"
	movwf PORTB
	call DATO
	movlw "T"
	movwf PORTB
	call DATO
	movlw "O"
	movwf PORTB
	call DATO
	movlw "S"
	movwf PORTB
	call DATO
	movlw " "
	movwf PORTB
	call DATO
	movlw " "
	movwf PORTB
	call DATO
	movf DecenasA,W
	movwf PORTB
	call DATO
	movf UnidadesA,W
	movwf PORTB
	call DATO

	bcf PORTD,6 ;Rs=0
	movlw b'11000001' ;DDRAM ADRESS 41H EN BINARIO 
	movwf PORTB 
	call CONTROL
	




	goto	PUSHBUTTON



LCDClean
	bcf PORTD,6 ;Rs=0
	movlw b'00000001' ;clean LCD
	movwf PORTB 
	bsf PORTD,7 ;E=1
	call Retardo
	call Retardo
	bcf PORTD,7 ;E=0
	call Retardo
	RETURN
LCDhome
	bcf PORTD,6 ;Rs=0
	movlw b'00000010' ;HOME, POSICION 0 LINEA 1, DISPLAY EN 0
	movwf PORTB
	bsf PORTD,7 ;E=1
	call Retardo
	call Retardo
	bcf PORTD,7 ;E=0
	call Retardo
	RETURN

DATO
	bsf PORTD,6 ;Rs=1
	bsf PORTD,7 ;E=1
	call Retardo
	call Retardo
	bcf PORTD,7 ;E=0
	call Retardo
	RETURN
	
CONTROL
	bsf PORTD,7 ;E=1
	call Retardo	
	call Retardo 
	bcf PORTD,7 ;E=0
	call Retardo	
	RETURN

Retardo  ;2,200 us
		movlw b'00000011' ;3
		movwf var1
retar1	movlw b'11111000' ;248
		movwf var2
		decfsz var2
		goto $-1
		decfsz var1
		goto retar1 
		return

Retardoinicio  ;10,500 us
		movlw b'00001110' ;14
		movwf var3
retar2	movlw b'11111000' ;248
		movwf var4
		decfsz var4
		goto $-1
		decfsz var3
		goto retar2 
		return

Segundo	;menos de medio segundo
		movlw b'00000011'
		movwf var1
retar4	movlw b'01010000'
		movwf var2
		movlw b'11111010'
		movwf var3
		nop
		nop
		decfsz var3
		goto $-3
		decfsz var2
		goto $-7
		decfsz var1
		goto retar4 
		return

OTROSEG	MOVLW	D'100'
			MOVWF	var1

RETARDO180	MOVLW	D'97'
			MOVWF	var2

RETARDO184	MOVLW	D'33'
			MOVWF	var3
REPETIR		DECFSZ	var3,1
			GOTO	REPETIR
			DECFSZ	var2,1
			GOTO	RETARDO184
			DECFSZ	var1,1
			GOTO	RETARDO180
RETURN

end