#line 1 "E:/AUXILIAR/SEM 2-2024 AUX MICRO/SOLUCION DE PRETICAS 2-2024/PREGUNTA8/LCD_PULSADOR.c"
sbit LCD_RS at RD1_bit;
sbit LCD_EN at RD0_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_RS_Direction at TRISD1_bit;
sbit LCD_EN_Direction at TRISD0_bit;
sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD4_bit;
void main() {
 Lcd_Init();
 while(1){
 lcd_out(1,1,"HOLA MUNDO");
 delay_ms(1000);
 lcd_Cmd(_LCD_CLEAR);
 lcd_out(1,1,"RORIGO");
 delay_ms(1000);
 lcd_Cmd(_LCD_CLEAR);
 lcd_out(1,1,"SIGNO LEO");
 delay_ms(1000);
 lcd_Cmd(_LCD_CLEAR);
 lcd_out(1,1,"C.I: 7309665");
 delay_ms(1000);
 lcd_Cmd(_LCD_CLEAR);
 }
}
