; ESTE SCRIPT MUEVE UN VALOR DEL PUERTO A AL PUERTO D y modo bajo consumo
__CONFIG  _LVP_OFF & _CPD_OFF & _CP_OFF & _PWRTE_OFF & _WDT_OFF & _XT_OSC & _BOREN_OFF & _WRT_OFF

;Libreria para el PIC16F877
LIST P=16f877a
#include <p16f877a.inc>
ORG 0X00    ;vector reset
;portA digital
BCF STATUS, RP0 ;
BCF STATUS, RP1 ; Bank0
CLRF PORTA ; Initialize PORTA by
BSF STATUS, RP0 ; Select Bank 1
MOVLW 0x06 ; Configure all pins
MOVWF ADCON1 ; as digital inputs
MOVLW 0x3f ; Value used to
MOVWF TRISA ; Set RA<3:0> as inputs

INICIO 
    banksel TRISD	;cambio de banco
    clrf TRISD	;limpiamos PortB
    banksel PORTD	;regreso banco

PRINCIPAL
    MOVF PORTA, 0 	;lo que tenga porta
    MOVWF PORTD 	;muevelo a portb
	SLEEP			;modo bajo consumo
    GOTO PRINCIPAL
END