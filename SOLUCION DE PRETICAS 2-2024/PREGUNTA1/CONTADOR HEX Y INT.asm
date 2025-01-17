;Autor: Calle Condori Rodrigo
;Realizar el diagrama de flujo y la codificación en ensamblador, 
;un contador hexadecimal del 000h al FFFh, el conteo inicia con un pulsador
;pull-down conectado al pin RC0, el conteo se interrumpe cada vez que se 
;presiona un pulsador pull-down conectado al pin RB0 
;generando una interrupción externa RB0(INT), cuando se genere la 
;interrupción, debe encenderse un motor DC, el programa vuelve y continúa 
;con el programa principal cuando se deja de presionar el pulsador 
;conectado a RB0. Utilizar displays de cátodo común.

   __CONFIG _XT_OSC & _WDTE_OFF & _PWRTE_ON & _CP_OFF & _LVP_OFF & _BOREN_OFF
   LIST P=16F877A
   #INCLUDE <P16F877A.INC>
   CBLOCK 0X20
   UNIDAD
   DECENA
   CENTENA
   AUX
   ENDC
   #DEFINE  STAR       PORTC,0
   #DEFINE  DISPLAY1   PORTC,1
   #DEFINE  DISPLAY2   PORTC,2
   #DEFINE  DISPLAY3   PORTC,3
   #DEFINE  MOTOR      PORTC,4
   #DEFINE  PULSADOR   PORTB,0
                 ORG    0X00
                 GOTO   CONFIGURAR
                 ORG    0X04
                 GOTO   INT_RB0
CONFIGURAR:
                 BSF    STATUS,RP0
                 BCF    STATUS,RP1
                 MOVLW  0X01
                 MOVWF  TRISC
                 MOVLW  0X01
                 MOVWF  TRISB
                 BSF    OPTION_REG,INTEDG
                 BCF    STATUS,RP0
                 MOVLW  B'10010000'
                 MOVWF  INTCON
                 CLRF   PORTB
                 CLRF   PORTC
                 CLRF   UNIDAD
                 CLRF   DECENA
                 CLRF   CENTENA
;----------------PRINIPAL--------------
MAIN:
                 CALL   VISUALIZAR
                 BTFSS  STAR
                 GOTO   MAIN
BUCLE:
                 CALL   VISUALIZAR
                 CALL   INTERNO
                 GOTO   BUCLE
;--------------------------------------
VISUALIZAR:
                 BSF    DISPLAY1
                 BCF    DISPLAY2
                 BCF    DISPLAY3
                 MOVF   UNIDAD,W
                 CALL   TABLA
                 MOVWF  PORTB
                 CALL   RETARDO_10MS

                 BCF    DISPLAY1
                 BSF    DISPLAY2
                 BCF    DISPLAY3
                 MOVF   DECENA,W
                 CALL   TABLA
                 MOVWF  PORTB
                 CALL   RETARDO_10MS

                 BCF    DISPLAY1
                 BCF    DISPLAY2
                 BSF    DISPLAY3
                 MOVF   CENTENA,W
                 CALL   TABLA
                 MOVWF  PORTB
                 CALL   RETARDO_10MS
                 RETURN
;TABLA NUMEROS HEX
TABLA:
                 ADDWF  PCL,F
                 RETLW  B'01111110'   ;0
                 RETLW  B'00001100'   ;1
                 RETLW  B'10110110'   ;2
                 RETLW  B'10011110'   ;3
                 RETLW  B'11001100'   ;4
                 RETLW  B'11011010'   ;5
                 RETLW  B'11111010'   ;6
                 RETLW  B'00001110'   ;7
                 RETLW  B'11111110'   ;8
                 RETLW  B'11011110'   ;9
                 RETLW  B'11101110'   ;A
                 RETLW  B'11111000'   ;B
                 RETLW  B'01110010'   ;C
                 RETLW  B'10111100'   ;D
                 RETLW  B'11110010'   ;E
                 RETLW  B'11100010'   ;F
INTERNO:
;AUX
                 INCF   AUX,F
                 MOVLW  .5
                 SUBWF  AUX,W
                 BTFSS  STATUS,Z
                 RETURN
;UNIDAD
                 CLRF   AUX
                 INCF   UNIDAD,F
                 MOVLW  .16
                 SUBWF  UNIDAD,W
                 BTFSS  STATUS,Z
                 RETURN
;DECENA
                 CLRF   UNIDAD
                 INCF   DECENA,F
                 MOVLW  .16
                 SUBWF  DECENA,W
                 BTFSS  STATUS,Z
                 RETURN         
;CENTENA
                 CLRF   DECENA
                 INCF   CENTENA,F
                 MOVLW  .16
                 SUBWF  CENTENA,W
                 BTFSS  STATUS,Z
                 RETURN
                 
                 CLRF   DECENA
                 CLRF   UNIDAD
                 CLRF   CENTENA
                 RETURN
INT_RB0:
                 BTFSS  INTCON,INTF
                 GOTO   LIMPIAR
ENCENDER_M1:
                 BSF    MOTOR
                 CALL   VISUALIZAR
                 BTFSC  PULSADOR
                 GOTO   ENCENDER_M1                               
LIMPIAR:
                 BCF    MOTOR
                 BCF    INTCON,INTF
                 RETFIE
                 INCLUDE <RETARDOS.INC>  
                 END