;; Implementar un contador en hexadecimal controlado por un bit del puerto A 
;;y mostrar el resultado en el puerto  C
;;  Cdsm 08/05/201
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

INICIO   bsf STATUS,RP0
	     movlw b'11111111' ;Se define puerto A como entrada
	     movwf TRISA
	     movlw b'00000000' ;Se define puerto C como salidas
	     movwf TRISC
	     bcf STATUS,RP0 ; Cambio de banco 1 a 0o 0

PRINCIPAL

CERO
		BTFSS PORTA,4
		GOTO CERO	
        MOVLW 0XC0 ;0
		MOVWF PORTC
        call R1
	     			
UNO
		BTFSC PORTA,4
		GOTO UNO	                     
        MOVLW 0XF9 ;1
		MOVWF PORTC
        call R1
		
DOS	
		BTFSC PORTA,4
		GOTO DOS        
		MOVLW 0XA4 ;2
		MOVWF PORTC
        call R1		
       
TRES
		BTFSC PORTA,4
		GOTO TRES	      
        MOVLW 0XB0 ;3
		MOVWF PORTC
        call R1		
       
CUATRO
		BTFSC PORTA,4
		GOTO CUATRO   
        MOVLW 0X99 ;4
		MOVWF PORTC
        call R1			

CINCO
		BTFSC PORTA,4
		GOTO CINCO      
        MOVLW 0X92 ;5
		MOVWF PORTC
        call R1		
        
SEIS
		BTFSC PORTA,4
		GOTO SEIS        
       MOVLW 0X82 ;6
		MOVWF PORTC
        call R1		
       		
SIETE
		BTFSC PORTA,4
		GOTO SIETE	         
        MOVLW 0XF8 ;7
		MOVWF PORTC
        call R1		
       
OCHO
		BTFSC PORTA,4
		GOTO OCHO	        
        MOVLW 0X80 ;8
		MOVWF PORTC
        call R1		
       
NUEVE
		BTFSC PORTA,4
		GOTO NUEVE	         
	    MOVLW 0X90 ;9
		MOVWF PORTC
        call R1		
       
DIEZ
		BTFSC PORTA,4
		GOTO DIEZ	         
	    MOVLW 0X88 ;a
		MOVWF PORTC
        call R1		
       
ONCE
		BTFSC PORTA,4
		GOTO ONCE	         
	    MOVLW 0X83 ;11
		MOVWF PORTC
        call R1		
       
DOCE
		BTFSC PORTA,4
		GOTO DOCE	         
	    MOVLW 0XC6 ;c
		MOVWF PORTC
        call R1	
TRECE
		BTFSC PORTA,4
		GOTO TRECE	         
	    MOVLW 0XA1 ;d
		MOVWF PORTC
        call R1		

CATORCE
		BTFSC PORTA,4
		GOTO CATORCE	         
	    MOVLW 0X86 ;e
		MOVWF PORTC
        call R1		

QUINCE
		BTFSC PORTA,4
		GOTO QUINCE	         
	    MOVLW 0X8E ;f
		MOVWF PORTC
        call R1		

BRINCO
		BTFSS PORTA,4
		GOTO BRINCO
	 	   
GOTO PRINCIPAL

;;;;;;;;;;;;;;;;;;;;;;;
R1
    movlw d'15'	
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