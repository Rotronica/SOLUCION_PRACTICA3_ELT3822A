#include <16f877a.h>
#fuses xt, nowdt, put, noprotect
#device adc=10
#use delay(clock=4M)
#include <lcd.c>
long q;
float p;
void main(){
setup_adc_ports(AN0);
setup_adc(ADC_CLOCK_INTERNAL);
lcd_init();
lcd_putc("\f");
 while(true){
  set_adc_channel(0);
  delay_us(20);
  q=read_adc();
  p=(5.0*q)/1024;
  lcd_gotoxy(1,1);
  printf(lcd_putc,"ADC = %Ld\n",q);
  printf(lcd_putc,"VOLTAJE= %1.3f",p);
 }
}
