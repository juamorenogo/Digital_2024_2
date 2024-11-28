En primer lugar se comprueba que el comportamiento de las compuertas sea el esperado, para esto se aplica una tensión en forma de onda cuadrada a **1 kHz** y se comprueba su comportamiento negador en la siguiente imagen:


Posteriormente se platea medir los intervalos de "1" y "0" lógicos usando un primer canal de una fuente DC que suministrara el nivel de voltaje de alimentación en los pines _VCC _y _GND_.  Para la señal se usara otro canal de la fuente DC que ira variando de **0V a 5V**  y a su vez los pines correspondientes del inversor (**1A  /  1Y**) se conectara una resistencia de 0.977 kOhm en el pin de salida *1Y* donde se sabe que la corriente deberá con la siguiente proporción : 


![[Pasted image 20241128144020.png]] ***(CAMBIAR IMAGEN)***

Por lo mismo, se medirá el voltaje de la resistencia para conocer el voltaje en diferentes momentos de voltaje y asi estimar el intervalo:

| Vcc     | V1a     | Vr      | Iout |
| ------- | ------- | ------- | ---- |
| 4.995 V | 5V      | 1.4 mV  |      |
| 4.990 V | 4.794 V | 1.4 mV  |      |
| 4.995 V | 4.698V  | 1.4 mV  |      |
| 4.990 V | 4.298 V | 1.4 mV  |      |
| 4.992V  | 3.949 V | 1.5 mV  |      |
| 4.989 V | 3.805 V | 3.1 mV  |      |
| 4.995 V | 2.896 V | 170 mV  |      |
| 4.990 V | 2.51 V  | 425 mV  |      |
| 4.992V  | 2.20 V  | 889 mV  |      |
| 4.989 V | 2.1 V   | 1.058 V |      |
| 4.989 V | 2.004 V | 1.217 V |      |
| 4.990 V | 1.797 V | 1.55 V  |      |
| 4.992V  | 1.702 V | 1.688 V |      |
| 4.995 V | 1.590 V | 1.85 V  |      |
| 4.990 V | 1.51 V  | 1.9  V  |      |
| 4.992V  | 0.995 V | 2.67 V  |      |

Por la tabla anterior se concluye que :

### CMOS : "1" Lógico  --> [3.8 V - 5V]
### CMOS : "0" Lógico  --> [0 V - 1.5V]







---

[Volver](https://github.com/juamorenogo/Digital_2024_2/tree/main/Lab_01/SN70LS04)
