En primer lugar se comprueba que el comportamiento de las compuertas sea el esperado, para esto se aplica una tensión en forma de onda cuadrada a **1 kHz** y se comprueba su comportamiento negador en la siguiente imagen:

![[SCR01.png]]

	Entrada : Color Amarillo
	Salida : Color Azul

Posteriormente se platea medir los intervalos de "1" y "0" lógicos usando un primer canal de una fuente DC que suministrara un nivel de voltaje fijo de alimentación de **5 V** en los pines _VCC _y _GND_ (Diagrama fuente *V2*) .  Para la señal a invertir, se usara otro canal de la fuente DC que ira variando de **0 V a 5 V**  (Diagrama fuente *V1*) en el pin **1A**  y  en el pin  **1Y** se conectara una resistencia de **1 kΩ** (0.977 kΩ exp).  Se presenta el diagrama simplificado del circuito:

![[C1SN.png]]

Para poder separar el **"1"** lógico del **"0"** lógico,  se opta por basarse en la corriente de salida del inversor. Se espera que el gasto de corriente en el "0" sea mayor al "1", y los valores específicos son extraídos del datasheet:

![[Pasted image 20241128144020.png]]

Por lo mismo, se medirá el voltaje de la resistencia para conocer la corriente de salida y así estimar el intervalo:

| **Vcc** | **Voltaje entrada V1 (V)** | **VR (V)** | **Corriente (mA)** |
| ------- | -------------------------- | ---------- | ------------------ |
| 4.986   | 4.999                      | 1 mV       | 1.02 uA            |
| 4.996   | 4.495                      | 1 mV       | 1.02 uA            |
| 4.995   | 3.990                      | 1 mV       | 1.02 uA            |
| 4.995   | 3.698                      | 1.1 mV     | 1.12 uA            |
| 4.994   | 3.393                      | 1.2 mV     | 1.22 uA            |
| 4.994   | 2.994                      | 1.3 mV     | 1.326 uA           |
| 4.995   | 2.900                      | 2.03 V     | 2.07 mA            |
| 4.995   | 2.493                      | 4.992 V    | 5.09 mA            |
| 4.994   | 1.992                      | 4.887 V    | 4.98 mA            |
| 4.986   | 1.511                      | 4.875 V    | 4.97 mA            |
| 4.996   | 0.995                      | 4.872 V    | 4.97 mA            |
| 4.995   | 0.503                      | 4.870 V    | 4.969 mA           |
| 4.996   | 0.103                      | 4.871 V    | 4.97 mA            |


Por la tabla anterior se concluye que :

##### TTL : "1" Lógico  --> [4 V - 5V]
##### TTL : "0" Lógico  --> [0 V - 2V]

--- 

Ahora se procede a medir el **tiempo de subida**, **tiempo de bajada** y **tiempo de retardo** . Se usara una alimentación de **5V** y se dará a la entrada una onda cuadrada de amplitud de **0V** a **5V** a _1 kHz_.

## Tiempo de Subida

Para esto se mide el tiempo de subida de la onda de salida usando _Measures_ en el scope, esto arroja lo siguiente :

tr80 : 26.3 ns
tr : 33.2 ns
## Tiempo de Bajada

Para esto se mide el tiempo de subida de la onda de salida usando _Measures_ en el scope, esto arroja lo siguiente :

tf80 : 19.6 ns
tf : 29.4 ns

## Tiempo de retardo

El **tiempo de retardo de propagación** es el tiempo que tarda la señal de salida en responder a un cambio en la señal de entrada. Se mide en dos direcciones:

- **\( t_{PLH} \)**: Tiempo de retardo cuando la salida cambia de baja a alta (Propagación de Bajo a Alto).
  - **Valor medido**: 100 ns.

- **\( t_{PHL} \)**: Tiempo de retardo cuando la salida cambia de alta a baja (Propagación de Alto a Bajo).
  - **Valor medido**: 16.8 ns.
  
El **tiempo de retardo de propagación** entonces se calcula como :

$$ 100 ns - 16.8ns = 83.2 ns$$




---


[Volver](https://github.com/juamorenogo/Digital_2024_2/tree/main/Lab_01/SN70LS04)
