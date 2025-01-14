En primer lugar se comprueba que el comportamiento de las compuertas sea el esperado, para esto se aplica una tensión en forma de onda cuadrada a **1 kHz** y se comprueba su comportamiento negador en la siguiente imagen:

![](Imagenes/F0000TEK.bmp)

	Entrada : Color Amarillo
	Salida : Color Azul

Posteriormente se platea medir los intervalos de "1" y "0" lógicos usando un primer canal de una fuente DC que suministrara el nivel de voltaje de alimentación en los pines _VCC _y _GND_.  Para la señal se usara otro canal de la fuente DC que ira variando de **0V a 5V**  y a su vez los pines correspondientes del inversor (**I1  /  O1**) se conectara una resistencia de 0.977 kOhm en el pin de salida *O1* donde se sabe que la corriente deberá con la siguiente proporción : 

![|500](Imagenes/ImCD5.png)


Por lo mismo, se medirá el voltaje de la resistencia para conocer el voltaje en diferentes momentos de voltaje y así estimar el intervalo:

| Vcc     | V1a     | Vr (mV) | I_out (mA) |
| ------- | ------- | ------- | ---------- |
| 4.995 V | 5V      | 1.4     | 1.4 uA     |
| 4.990 V | 4.794 V | 1.4     | 1.4 uA     |
| 4.995 V | 4.698V  | 1.4     | 1.4 uA     |
| 4.990 V | 4.298 V | 1.4     | 1.4 uA     |
| 4.992V  | 3.949 V | 1.5     | 1.5 uA     |
| 4.989 V | 3.805 V | 3.1     | 3.1 uA     |
| 4.995 V | 2.896 V | 170     | 1.7 mA     |
| 4.990 V | 2.51 V  | 425     | 4.25 mA    |
| 4.992V  | 2.20 V  | 889     | 8.89 mA    |
| 4.989 V | 2.1 V   | 1058    | 1.06 mA    |
| 4.989 V | 2.004 V | 1217    | 1.22 mA    |
| 4.990 V | 1.797 V | 1550    | 1.55 mA    |
| 4.992V  | 1.702 V | 1688    | 1.68 mA    |
| 4.995 V | 1.590 V | 1850    | 1.85 mA    |
| 4.990 V | 1.51 V  | 1900    | 1.97 mA    |
| 4.992V  | 0.995 V | 2670    | 2.67 mA    |

Por la tabla anterior se concluye que  (A partir de la corriente requerida por el circuito) :

### CMOS : "1" Lógico  --> [3.9 V - 5V]
### CMOS : "0" Lógico  --> [0 V - 1.5V]


Ahora se procede a medir el tiempo de subida, tiempo de bajada, tiempo de retardo, tiempo de almacenamiento para cada dispositivo. Se usara una alimentación de **5V** y se dará a la entrada una onda cuadrada de amplitud (HL 5V - 0V) a 1 kHz.

## Tiempo de Subida

Para esto se mide el tiempo de subida de la onda de salida usando _Measures_ en el scope, esto arroja lo siguiente :

* **tr80** : 74.35 ns
* **tr** : 114.4ns
## Tiempo de Bajada

Para esto se mide el tiempo de subida de la onda de salida usando _Measures_ en el scope, esto arroja lo siguiente :

* **tf80** : 81.3 ns
* **tf** : 120 ns

## Tiempo de retardo

El **tiempo de retardo de propagación** es el tiempo que tarda la señal de salida en responder a un cambio en la señal de entrada. Se mide en dos direcciones:

- **\( t_{PLH} \)**: Tiempo de retardo cuando la salida cambia de baja a alta (Propagación de Bajo a Alto).
  - **Valor medido**: 60 ns.

- **\( t_{PHL} \)**: Tiempo de retardo cuando la salida cambia de alta a baja (Propagación de Alto a Bajo).
  - **Valor medido**: 8 ns.
  
El **tiempo de retardo de propagación** entonces se calcula como :

$$ 60 ns - 8ns = 52 ns$$


---

[Volver](https://github.com/juamorenogo/Digital_2024_2/blob/main/Lab_01/CD4069/README.md)
