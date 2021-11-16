;;  Utilizar el ADC del PIC para convertir un voltaje 
;; en el canal 1, a un valor de 8 bits en el puerto D.
;;  Cdsm 23/05/2021
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
        goto Inicio
        org 0x05

CBLOCK 0X1F
  R_ContA       ; Contadores para los retardos.
  R_ContB
  R_ContC
  R_ContD
  ENDC

Inicio  clrf PORTA       ;Limpia el puerto A
        clrf PORTB        
    bsf STATUS,RP0
    bcf STATUS,RP1    ;Cambio la banco 1
    movlw b'00000000' ; Se define el puerto A como analogico
      movwf ADCON1 ; Se mueve configuracion al puerto
    movlw b'11111111' ;Se define puerto A como entradas
      movwf TRISA
        movlw b'0000000' ;Se define puerto B como entrada
      movwf TRISB ; Se mueve configuracion al puerto
      movlw b'0100000'
    movwf OPTION_REG
      bcf STATUS,RP0 ; Cambio de banco 1 a 0o 0

 
INICIO_ADC1
      movlw b'11000001' ;Configuración ADCON0 RA0 
      movwf ADCON0      ;ADCS1=1 ADCS0=1 CHS2=0 CHS1=0 CHS0=0 GO/DONE=0 - ADON=1

       bsf ADCON0,2      ;Conversión en progreso GO=1
       call RETARDO20m   ;Espera que termine la conversión
ESPERA btfsc ADCON0,2    ;Pregunta por DONE=0? (Terminó conversión)
       goto ESPERA       ;No, vuelve a preguntar
       movf ADRESH,0     ;Si
       movwf PORTB       ;Muestra el resultado en PORTd
goto INICIO_ADC1


  RETARDO20m           
       movlw h'30'
       movwf R_ContD
  Loop   decfsz R_ContD,1
       goto Loop
       return
 
END