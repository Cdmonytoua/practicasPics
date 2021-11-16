;;REALIZAR UN CONTADOR DE 3 BITS CONECTADO AL PUERTO A Y 
;;MOSTRAR EL RESULTADO EN UN DISPLAY DE 7 SEGMENTOS EN EL PUERTO C
;;  Cdsm 03/05/201
;Palabra de configuración

__CONFIG _CONFIG1, _LVP_OFF & _FCMEN_ON & _IESO_OFF & _BOR_OFF & _CPD_OFF & _CP_OFF & _MCLRE_ON & _PWRTE_OFF & _WDT_OFF & _XT_OSC
__CONFIG _CONFIG2, _WRT_OFF & _BOR21V

;Libreria para el PIC16F887
LIST P=16f887
#include <p16f887.inc>

Reset   org 0x00
        goto INICIO
        org 0x05

CBLOCK 0X1F
	
	R_ContA				; Contadores para los retardos.
	R_ContB
	R_ContC
ENDC

INICIO  bsf STATUS,RP0
		movlw b'00000000' ;PUERTO C SALIDAS
	    movwf TRISC 
		movlw b'11111111' ;PUERTO A ENTRADAS
		movlw TRISA
	    bcf STATUS,RP0 ; CAMBIO DE BANCO DE 1 A 0

PRINCIPAL
		
CERO
		BTFSS PORTA,4
		GOTO CERO	
        MOVLW B'11000000' ;cero
		MOVWF PORTC
 		call PAUSA1
UNO
		BTFSC PORTA,4
		GOTO UNO	                     
		MOVLW B'11111001' ;1
		MOVWF PORTC
 		call PAUSA1
DOS	
		BTFSC PORTA,4
		GOTO DOS 
		MOVLW B'10100100'       
        ;MOVLW B'01011011' ;2
		MOVWF PORTC
        call PAUSA1
TRES
		BTFSC PORTA,4
		GOTO TRES	      
		MOVLW B'10110000'
       ;MOVLW B'01001111' ;3
		MOVWF PORTC
        call PAUSA1
CUATRO
		BTFSC PORTA,4
		GOTO CUATRO
		MOVLW B'10011001'   
        ;MOVLW B'01100110' ;4
		MOVWF PORTC
		call PAUSA1

CINCO
	    BTFSC PORTA,4
		GOTO CINCO      
		MOVLW B'10010010'
        ;MOVLW B'01101101' ;5
		MOVWF PORTC
 		call PAUSA1
SEIS
		BTFSC PORTD,7
		GOTO SEIS 
		MOVLW B'10000010'
       ;MOVLW B'01111101' ;6
		MOVWF PORTC
        call PAUSA1

SIETE
		BTFSC PORTA,4
		GOTO SIETE	         
		MOVLW B'11111000'
       ;MOVLW B'00000111' ;7
		MOVWF PORTC
        call PAUSA1
     

goto PRINCIPAL

PAUSA1
    movlw d'10'
    goto R_1Decima
 

	R_1Decima
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