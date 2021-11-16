;;  PRENDER Y APAGAR UN LED CONECTADO AL PUERTO B
;;  CADA 5 SEGUNDOS
;;  Cdsm 01/05/2021
;Palabra de configuración

__CONFIG _CONFIG1, _LVP_OFF & _FCMEN_ON & _IESO_OFF & _BOR_OFF & _CPD_OFF & _CP_OFF & _MCLRE_ON & _PWRTE_OFF & _WDT_OFF & _XT_OSC
__CONFIG _CONFIG2, _WRT_OFF & _BOR21V

;Libreria para el PIC16F887
LIST P=16f887
#include <p16f887.inc>

CBLOCK 0X1F
	
	R_ContA				; Contadores para los retardos.
	R_ContB
	R_ContC
ENDC
 
ORG 0X00


bsf STATUS, RP0           ;BANK O TO BANK 1 
movlw  b'01111111'         
movwf TRISB           
bcf STATUS, RP0 

INICIO  
 
    movlw b'10000000'
    movwf PORTB
    CALL R1
    movlw b'00000000'
    movwf PORTB
    CALL R5

goto INICIO


R5
    movlw d'83'
    goto R_1Decima
R1
    movlw d'05'	
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


