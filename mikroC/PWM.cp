#line 1 "C:/Users/rherr/Downloads/Ken/septimoSemestre/arquitecturaDeComputadoras/Tareas/pwn/mikroC/PWM.c"
unsigned short ciclo_de_trabajo_actual;
unsigned short ciclo_de_trabajo_anterior;

void main() {
 ANSEL = 0;
 ANSELH = 0;
 PORTA = 255;
 TRISA = 255;
 PORTC = 0;
 TRISC = 0;
 PWM1_Init(5000);
 ciclo_de_trabajo_actual = 16;
 ciclo_de_trabajo_anterior = 0;
 PWM1_Start();

 while (1) {
 if (Button(&PORTA, 0,1,1))
 ciclo_de_trabajo_actual++ ;
 if (Button(&PORTA, 1,1,1))
 ciclo_de_trabajo_actual-- ;

 if (ciclo_de_trabajo_anterior != ciclo_de_trabajo_actual) {
 PWM1_Set_Duty(ciclo_de_trabajo_actual);
 ciclo_de_trabajo_anterior = ciclo_de_trabajo_actual;
 }
 Delay_ms(200);
 }
}
