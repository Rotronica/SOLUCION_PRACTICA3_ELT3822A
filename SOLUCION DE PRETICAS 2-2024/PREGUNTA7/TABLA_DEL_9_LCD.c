#include <16f877a.h>
#fuses xt,nowdt,put,noprotect,nolvp
#use delay(clock=4M)
#byte PORTB=0X06
#byte TRISB=0X86
#define LCD_ENABLE_PIN  PIN_D0                                    
#define LCD_RS_PIN      PIN_D1                                    
#define LCD_RW_PIN      PIN_D2                                    
#define LCD_DATA4       PIN_D4                                    
#define LCD_DATA5       PIN_D5                                    
#define LCD_DATA6       PIN_D6                                    
#define LCD_DATA7       PIN_D7 
#include <lcd.c>
int i,x,y,dato;
void recorrer();
void main(){
 lcd_init();
 lcd_putc("\f");
 while(true){
  lcd_putc("\f");
  i++;
  dato=9*i;
  lcd_gotoxy(1,1);
  printf(lcd_putc,"MULT: 9 X %d = ",i);
  recorrer();
  printf(lcd_putc,"%d ",dato);
  delay_ms(500);
  if(i==10){i=0;dato=0;}
 }
}
void recorrer(){
 if(x<16){
  x++;
  lcd_gotoxy(x,2);
 }
 if(x>=16){
  lcd_gotoxy(y,2);
   y--;
  }
  if(y<=0){
   x=1;
   y=16;
   lcd_gotoxy(x,2);
  }
}
