;; MOTOR A PASOS
;;  Cdsm 16/05/2021
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
	
Reset   org 0x00
        goto INICIO
        org 0x05
 
; PSEUDOCODIGO PARA LOS BANCOS 
INICIO 
	BSF STATUS, RP0
	MOVLW B'0000'
	MOVWF TRISB
	BCF STATUS, RP0

PRINCIPAL

	movlw b'1000' 
	movwf PORTB
	call RETARDO2
	movlw b'0100' 
	movwf PORTB
	call RETARDO2
	movlw b'00010' 
	movwf PORTB
	call RETARDO2
	movlw b'0001' 
	movwf PORTB
	call RETARDO2
	
GOTO PRINCIPAL 
 
RETARDO1
	movlw	d'1'			
	goto	Retardo_1Decima		

RETARDO2				
	movlw	d'15'
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
