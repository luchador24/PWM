
_main:

;PWM.c,4 :: 		void main() {
;PWM.c,5 :: 		ANSEL = 0;       // Todos los pines de E/S se configuran como digitales
	CLRF       ANSEL+0
;PWM.c,6 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;PWM.c,7 :: 		PORTA = 255;     // Estado inicial del puerto PORTA
	MOVLW      255
	MOVWF      PORTA+0
;PWM.c,8 :: 		TRISA = 255;     // Todos los pines del puerto PORTA se configuran como entradas
	MOVLW      255
	MOVWF      TRISA+0
;PWM.c,9 :: 		PORTC = 0;       // Estado inicial del puerto PORTC
	CLRF       PORTC+0
;PWM.c,10 :: 		TRISC = 0;       // Todos los pines del puerto PORTC se configuran como salidas
	CLRF       TRISC+0
;PWM.c,11 :: 		PWM1_Init(5000); // Inicialización del módulo PWM (5KHz)
	BCF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      199
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;PWM.c,12 :: 		ciclo_de_trabajo_actual = 16;    // Valor inicial de la variable ciclo_de_trabajo_actual
	MOVLW      16
	MOVWF      _ciclo_de_trabajo_actual+0
;PWM.c,13 :: 		ciclo_de_trabajo_anterior = 0;   // Reiniciar la variable ciclo_de trabajo_anterior
	CLRF       _ciclo_de_trabajo_anterior+0
;PWM.c,14 :: 		PWM1_Start();                    // Iniciar el módulo PWM1
	CALL       _PWM1_Start+0
;PWM.c,16 :: 		while (1) {                      // Bucle infinito
L_main0:
;PWM.c,17 :: 		if (Button(&PORTA, 0,1,1))     // Si se presiona el botón conectado al RA0
	MOVLW      PORTA+0
	MOVWF      FARG_Button_port+0
	CLRF       FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main2
;PWM.c,18 :: 		ciclo_de_trabajo_actual++ ;    // incrementar el valor de la variable current_duty
	INCF       _ciclo_de_trabajo_actual+0, 1
L_main2:
;PWM.c,19 :: 		if (Button(&PORTA, 1,1,1))     // Si se presiona el botón conectado al RA1
	MOVLW      PORTA+0
	MOVWF      FARG_Button_port+0
	MOVLW      1
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main3
;PWM.c,20 :: 		ciclo_de_trabajo_actual-- ;    // decrementar el valor de la variable current_duty
	DECF       _ciclo_de_trabajo_actual+0, 1
L_main3:
;PWM.c,22 :: 		if (ciclo_de_trabajo_anterior != ciclo_de_trabajo_actual) { // Si ciclo_de_trabajo_actual y ciclo_de trabajo_anterior no son iguales
	MOVF       _ciclo_de_trabajo_anterior+0, 0
	XORWF      _ciclo_de_trabajo_actual+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main4
;PWM.c,23 :: 		PWM1_Set_Duty(ciclo_de_trabajo_actual);              // ajustar un nuevo valor a PWM,
	MOVF       _ciclo_de_trabajo_actual+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;PWM.c,24 :: 		ciclo_de_trabajo_anterior = ciclo_de_trabajo_actual; // Guardar el nuevo valor
	MOVF       _ciclo_de_trabajo_actual+0, 0
	MOVWF      _ciclo_de_trabajo_anterior+0
;PWM.c,25 :: 		}
L_main4:
;PWM.c,26 :: 		Delay_ms(200); // Tiempo de retardo de 200mS
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
	NOP
;PWM.c,27 :: 		}
	GOTO       L_main0
;PWM.c,28 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
