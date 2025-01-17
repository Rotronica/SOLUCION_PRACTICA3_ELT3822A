PROCESSOR 16F877A
#include <xc.inc>
    ; PIC16F877A Configuration Bit Settings
; Assembly source line config statements
; CONFIG
  CONFIG  FOSC = XT             ; Oscillator Selection bits (XT oscillator)
  CONFIG  WDTE = OFF            ; Watchdog Timer Enable bit (WDT disabled)
  CONFIG  PWRTE = ON            ; Power-up Timer Enable bit (PWRT enabled)
  CONFIG  BOREN = OFF           ; Brown-out Reset Enable bit (BOR disabled)
  CONFIG  LVP = OFF             ; Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3 is digital I/O, HV on MCLR must be used for programming)
  CONFIG  CPD = OFF             ; Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
  CONFIG  WRT = OFF             ; Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
  CONFIG  CP = OFF              ; Flash Program Memory Code Protection bit (Code protection off)

; When assembly code is placed in a psect, it can be manipulated as a
; whole by the linker and placed in memory.  
;
; In this example, barfunc is the program section (psect) name, 'local' means
; that the section will not be combined with other sections even if they have
; the same name.  class=CODE means the barfunc must go in the CODE container.
; PIC18 should have a delta (addressible unit size) of 1 (default) since they
; are byte addressible.  PIC10/12/16 have a delta of 2 since they are word
; addressible.  PIC18 should have a reloc (alignment) flag of 2 for any
; psect which contains executable code.  PIC10/12/16 can use the default
; reloc value of 1.  Use one of the psects below for the device you use:
psect   RESET_VECT,class=CODE,delta=2 ; VECTOR DE RESET
RESET_VECT:
	       PAGESEL CONFIGURACION   
               GOTO  CONFIGURACION    ;IR A LA ETIQUETA CONFIGURACION
psect   INT_VECT,class=CODE,delta=2   ;VECTOR DE INTERRUPCION
INT_VECT:
               RETFIE
PSECT CODE, delta=2
CONFIGURACION:
               BSF    STATUS,5
	       BCF    STATUS,6
	       MOVLW  0XFF
               MOVWF  TRISB
	       MOVLW  0X00
	       MOVWF  TRISC
	       BCF    OPTION_REG,7
	       BCF    STATUS,5
	       CLRF   PORTB
	       CLRF   PORTC
MAIN:
               MOVF   PORTB,W
	       MOVWF  PORTC
	       GOTO   MAIN
	       END    RESET_VECT