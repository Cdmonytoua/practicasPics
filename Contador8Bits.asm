;; Realizar un script  para generar un retraso de dos segundos
;;A partir de este retraso se incrementa un contador de 8 bits 
;;que muestra el resultado en el puerto B
;;  Cdsm 17/05/2021
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
	     movlw b'00000000' ;Se define puerto A como entrada
	     movwf TRISB
	     movlw b'00000000' ;Se define puerto C como salidas
	     movwf TRISC
	     bcf STATUS,RP0 ; Cambio de banco 1 a 0o 0

PRINCIPAL

call R2

CERO
        MOVLW 0XC0 ;0
		MOVWF PORTB
		call CICLO
        call R1
	     			
UNO
        MOVLW 0XF9 ;1
		MOVWF PORTB
		call CICLO
        call R1
		
DOS	
		MOVLW 0XA4 ;2
		MOVWF PORTB
		call CICLO
        call R1		
       
TRES
        MOVLW 0XB0 ;3
		MOVWF PORTB
		call CICLO
        call R1		
       
       
CUATRO
        MOVLW 0X99 ;4
		MOVWF PORTB
		call CICLO
        call R1		
   		

CINCO
        MOVLW 0X92 ;5
		MOVWF PORTB
		call CICLO
        call R1		
        

SEIS
        MOVLW 0X82 ;6
		MOVWF PORTB
		call CICLO
        call R1		
       		
SIETE
        MOVLW 0XF8 ;7
		MOVWF PORTB
		call CICLO
        call R1		
 

OCHO
        MOVLW 0X80 ;8
		MOVWF PORTB
		call CICLO
        call R1		
              
NUEVE
	    MOVLW 0X90 ;9
		MOVWF PORTB
		call CICLO
        call R1		
       
DIEZ
	    MOVLW 0X88 ;10
		MOVWF PORTB
		call CICLO
        call R1		
       
ONCE
	    MOVLW 0X83 ;11
		MOVWF PORTB
		call CICLO
        call R1		
       
DOCE
	    MOVLW 0XC6 ;12
		MOVWF PORTB
		call CICLO
        call R1	

TRECE
	    MOVLW 0XA1;13
		MOVWF PORTB
		call CICLO
        call R1		

CATORCE
	    MOVLW 0X86  ;14
		MOVWF PORTB
		call CICLO
        call R1		

QUINCE
	    MOVLW 0X8E ;15
		MOVWF PORTB
		call CICLO
        call R1		

GOTO PRINCIPAL   

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CICLO

CERO2
        MOVLW 0XC0 ;0
		MOVWF PORTC
        call R1
	     			
UNO2
        MOVLW 0XF9 ;1
		MOVWF PORTC
        call R1
		
DOS2
		MOVLW 0XA4 ;2
		MOVWF PORTC
        call R1		
       
TRES2
        MOVLW 0XB0 ;3
		MOVWF PORTC
        call R1		
       
CUATRO2
        MOVLW 0X99 ;4
		MOVWF PORTC
        call R1		
   		
CINCO2
        MOVLW 0X92 ;5
		MOVWF PORTC
        call R1		
        
SEIS2
        MOVLW 0X82 ;6
		MOVWF PORTC
        call R1		
       		
SIETE2
        MOVLW 0XF8 ;7
		MOVWF PORTC
        call R1		
 
OCHO2
        MOVLW 0X80 ;8
		MOVWF PORTC
        call R1		
              
NUEVE2
	    MOVLW 0X90 ;9
		MOVWF PORTC
        call R1		
       
DIEZ2
	    MOVLW 0X88 ;10
		MOVWF PORTC
        call R1		
       
ONCE2
	    MOVLW 0X83 ;11
		MOVWF PORTC
        call R1		
       
DOCE2
	    MOVLW 0XC6 ;12
		MOVWF PORTC
        call R1	

TRECE2
	    MOVLW 0XA1;13
		MOVWF PORTC
        call R1		

CATORCE2
	    MOVLW 0X86 ;14
		MOVWF PORTC
        call R1		

QUINCE2
	    MOVLW 0X8E ;15
		MOVWF PORTC
        call R1

;;;;;;;;;;;;;;;;;;;;;;;
R2  movlw d'20'	
    goto R_1Decima

R1
    movlw d'8'	
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