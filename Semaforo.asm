;;Programación del siguiente semáforo Establecer los tiempos para 
;;los 8 indicadores los dos semáforos y el cruce peatonal
;;  Cdsm 09/05/2021
;Palabra de configuración

__CONFIG _CONFIG1, _LVP_OFF & _FCMEN_ON & _IESO_OFF & _BOR_OFF & _CPD_OFF & _CP_OFF & _MCLRE_ON & _PWRTE_OFF & _WDT_OFF & _XT_OSC
__CONFIG _CONFIG2, _WRT_OFF & _BOR21V

;Libreria para el PIC16F887
LIST P=16f887
#include <p16f887.inc>

 CBLOCK 0X1F
	WE
	QW
	R_ContA				; Contadores para los retardos.
	R_ContB
	R_ContC
	ENDC
 
ORG 0X00				;Vector Reset

 ; PSEUDOCODIGO PARA LOS BANCOS 
 PRINCIPAL
 BCF STATUS, RP0 
 BCF STATUS, RP1
 CLRF PORTD
 CLRF PORTB
 BSF STATUS, RP0
 CLRF TRISD
 CLRF TRISB 
 BCF STATUS, RP0
 goto INICIO
 
INICIO  
UNO
	    MOVLW B'10100001' 
		MOVWF PORTD
		BSF PORTB,6
        call RETARDO5

PARPADEO_VERDE_2
  		
	    MOVLW B'10100001' 
		MOVWF PORTD
        call RETARDO1
		MOVLW B'00000001' 
		MOVWF PORTD
        call RETARDO1
		MOVLW B'10100001' 
		MOVWF PORTD
        call RETARDO1
		MOVLW B'00000001' 
		MOVWF PORTD
        call RETARDO1 
DOS 
    	MOVLW B'10010001' 
		MOVWF PORTD
        call RETARDO1
		MOVLW B'00000001' 
		MOVWF PORTD
        call RETARDO1
		MOVLW B'10010001' 
		MOVWF PORTD
        call RETARDO1
		MOVLW B'00000001' 
		MOVWF PORTD
        call RETARDO1  

TRES 	
		BCF PORTB,6	
		MOVLW B'01001100' 
		MOVWF PORTD
		BSF PORTB,7 
        call RETARDO5

PARPADEO_VERDE_1

		MOVLW B'01001100' 
		MOVWF PORTD
        call RETARDO1
		MOVLW B'01001000' 
		MOVWF PORTD
		BCF PORTB,7 
        call RETARDO1
		MOVLW B'01001100' ;cero
		MOVWF PORTD
		BSF PORTB,7 
        call RETARDO1
		MOVLW B'01001000' ;cero
		MOVWF PORTD
		BCF PORTB,7 
        call RETARDO1

CUATRO 
 		MOVLW B'01001010' ;cero
		MOVWF PORTD
		BSF PORTB,7 
        call RETARDO1
		MOVLW B'01001000' ;cero
		MOVWF PORTD
		BCF PORTB,7
        call RETARDO1
		MOVLW B'01001010' ;cero
		MOVWF PORTD
		BSF PORTB,7 
        call RETARDO1
		MOVLW B'01001000' ;cero
		MOVWF PORTD
		BCF PORTB,7 
        call RETARDO1
		
		
 GOTO INICIO

    RETARDO5
    movlw d'50'
	GOTO Retardo_1Decima
    RETARDO1
	movlw	d'08'			
	Retardo_1Decima
	movwf	R_ContC			
	R1Decima_BucleExterno2
	movlw	d'100'			
	movwf	R_ContB			
	R1Decima_BucleExterno
	movlw	d'249'			
	movwf	R_ContA		
	R1Decima_BucleInterno          
	nop				
	decfsz	R_ContA,F		
	goto	R1Decima_BucleInterno
	decfsz	R_ContB,F	
	goto	R1Decima_BucleExterno	
	decfsz	R_ContC,F		
	goto	R1Decima_BucleExterno2	
	return				
END