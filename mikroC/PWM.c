unsigned short ciclo_de_trabajo_actual;
unsigned short ciclo_de_trabajo_anterior;

void main() {
  ANSEL = 0;       // Todos los pines de E/S se configuran como digitales
  ANSELH = 0;
  PORTA = 255;     // Estado inicial del puerto PORTA
  TRISA = 255;     // Todos los pines del puerto PORTA se configuran como entradas
  PORTC = 0;       // Estado inicial del puerto PORTC
  TRISC = 0;       // Todos los pines del puerto PORTC se configuran como salidas
  PWM1_Init(5000); // Inicialización del módulo PWM (5KHz)
  ciclo_de_trabajo_actual = 16;    // Valor inicial de la variable ciclo_de_trabajo_actual
  ciclo_de_trabajo_anterior = 0;   // Reiniciar la variable ciclo_de trabajo_anterior
  PWM1_Start();                    // Iniciar el módulo PWM1

  while (1) {                      // Bucle infinito
    if (Button(&PORTA, 0,1,1))     // Si se presiona el botón conectado al RA0
    ciclo_de_trabajo_actual++ ;    // incrementar el valor de la variable current_duty
    if (Button(&PORTA, 1,1,1))     // Si se presiona el botón conectado al RA1
    ciclo_de_trabajo_actual-- ;    // decrementar el valor de la variable current_duty

    if (ciclo_de_trabajo_anterior != ciclo_de_trabajo_actual) { // Si ciclo_de_trabajo_actual y ciclo_de trabajo_anterior no son iguales
      PWM1_Set_Duty(ciclo_de_trabajo_actual);              // ajustar un nuevo valor a PWM,
      ciclo_de_trabajo_anterior = ciclo_de_trabajo_actual; // Guardar el nuevo valor
    }
    Delay_ms(200); // Tiempo de retardo de 200mS
  }
}