/*
 * File:   PUENTE_H.c
 * Author: Calle Rodrigo
 *
 * Created on 21 de noviembre de 2024, 1:30
 */
#include <pic16f877a.h>
#include "CONFIG.h"
#include <xc.h>
#define _XTAL_FREQ 4000000
#define ADELANTE   PORTBbits.RB4
#define ATRAS      PORTBbits.RB5
#define DERECHA    PORTBbits.RB6
#define IZQUIERDA  PORTBbits.RB7
void __interrupt() INT_RBI_0(void){
        if (INTCONbits.RBIF) { // Verifica si la interrupción es por cambio en el puerto B
            if (ADELANTE == 0) {PORTC=0XF9;}
            if (ATRAS == 0) {PORTC=0XF6;}
            if (DERECHA == 0) {PORTC=0XF8;}
            if (IZQUIERDA == 0) {PORTC=0XF1;}
        INTCONbits.RBIF = 0; // Limpia el flag de interrupción
        }
}
void main(void) {
    TRISC=0X00;
    TRISB=0XFF;
    OPTION_REGbits.nRBPU=0;
    INTCON=0B10001000;
    PORTC=0X00;
    PORTB=0X00;
    while(1){
    }
    return;
}
