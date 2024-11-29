En primer lugar se comprueba que el comportamiento de las compuertas sea el esperado, para esto se aplica una tensión en forma de onda cuadrada a **1 kHz** y se comprueba su comportamiento negador en la siguiente imagen:

![[SCR01.png]]

	Entrada : Color Amarillo
	Salida : Color Azul

Posteriormente se platea medir los intervalos de "1" y "0" lógicos usando un primer canal de una fuente DC que suministrara un nivel de voltaje fijo de alimentación de **5 V** en los pines _VCC _y _GND_ (Diagrama fuente *V2*) .  Para la señal a invertir, se usara otro canal de la fuente DC que ira variando de **0 V a 5 V**  (Diagrama fuente *V1*) en el pin **1A**  y  en el pin  **1Y** se conectara una resistencia de **1 kΩ** (0.977 kΩ exp).  Se presenta el diagrama simplificado del circuito:

![[C1SN.png]]

Para poder separar el **"1"** lógico del **"0"** lógico,  se opta por basarse en la corriente de salida del inversor. Se espera que el gasto de corriente en el "0" sea mayor al "1", y los valores específicos son extraídos del datasheet:

![[Pasted image 20241128144020.png]]

Por lo mismo, se medirá el voltaje de la resistencia para conocer la corriente de salida y así estimar el intervalo:

| Vcc     | V1a     | Vr      | Iout   |
| ------- | ------- | ------- | ------ |
| 4.995 V | 5V      | 0.4 mV  | 0.4 mA |
| 4.990 V | 4.742 V | 0.4 mV  | 0.4 mA |
| 4.995 V | 4 V     | 0.4 mV  | 0.4 mA |
| 4.990 V | 3.498 V | 0.5 mV  | 0.5 mA |
| 4.992V  | 3.096 V | 0.6 mV  | 0.6 mA |
| 4.989 V | 3.001 V | 0.6 mV  | 0.6 mA |
| 4.995 V | 2.956 V | 2.290 V | 2.2 mA |
| 4.990 V | 2.49 V  | 2.444 V | 2.4 mA |
| 4.992V  | 2.2 V   | 2.926 V | 2.9 mA |
| 4.989 V | 2.1 V   | 4.880 V | 4.8 mA |
| 4.989 V | 1.895 V | 4.876 V | 4.8 mA |

Por la tabla anterior se concluye que :

### TTL : "1" Lógico  --> [3 V - 5V]
### TTL : "0" Lógico  --> [0 V - 2V]

--- 

Ahora se procede a medir el tiempo de subida, tiempo de bajada, tiempo de retardo, tiempo de almacenamiento para cada dispositivo. Se usara una alimentación de **5V** y se dará a la entrada una onda cuadrada de amplitud (HL 5V - 0V) a 1 kHz.

## Tiempo de Subida

Para esto se mide el tiempo de subida de la onda de salida usando _Measures_ en el scope, esto arroja lo siguiente :

tr80 : 26.3 ns
tr : 33.2 ns
## Tiempo de Bajada

Para esto se mide el tiempo de subida de la onda de salida usando _Measures_ en el scope, esto arroja lo siguiente :

tf80 : 19.6 ns
tf : 29.4 ns

## Tiempo de retardo

### 3. **Tiempo de Retardo de Propagación (tphlt_{phl}tphl​ y tplht_{plh}tplh​)**

El **tiempo de retardo de propagación** es el tiempo que tarda la señal de salida en responder a un cambio en la señal de entrada. Se mide en dos direcciones:

- **tplht_{plh}tplh​**: Tiempo de retardo cuando la salida cambia de baja a alta (Propagación de Bajo a Alto).
- **tphlt_{phl}tphl​**: Tiempo de retardo cuando la salida cambia de alta a baja (Propagación de Alto a Bajo).

YA SE TIENEN LOS DATOS
## Tiempo de Almacenamiento

### . **Tiempo de Almacenamiento (o Tiempo de Retención)**

El **tiempo de almacenamiento** se refiere al tiempo que la salida mantiene su estado después de que se ha aplicado una señal de entrada, especialmente en puertas que tienen memorias internas como los flip-flops o registros.

#### Procedimiento:

- **Generador de señales**: Configura el generador para que aplique un pulso de duración conocida en la entrada.
- **Osciloscopio**: Conecta la salida al osciloscopio y observa el comportamiento.
    - Mide el tiempo durante el cual la salida se mantiene en un estado constante (puede ser alto o bajo) después de la aplicación del pulso de entrada.

**Resultado**: El **tiempo de almacenamiento** es el tiempo que la salida permanece estable antes de que el siguiente cambio ocurra, si es que hay un siguiente cambio.

¿No aplica?

---


[Volver](https://github.com/juamorenogo/Digital_2024_2/tree/main/Lab_01/SN70LS04)
